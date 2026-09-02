[CmdletBinding()]
param(
    [string]$TtsDataPath = "",
    [switch]$SkipWorkshopCheck,
    [switch]$VerifyOnly
)

$ErrorActionPreference = "Stop"
$WorkshopId = "3794307123"
$PackageRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ManifestPath = Join-Path $PackageRoot "manifest-cache.json"

if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    throw "manifest-cache.json was not found. Extract the complete ZIP before running this installer."
}

if ([string]::IsNullOrWhiteSpace($TtsDataPath)) {
    $Documents = [Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)
    $TtsDataPath = Join-Path $Documents "My Games\Tabletop Simulator"
}
$TtsDataPath = [System.IO.Path]::GetFullPath($TtsDataPath)

if ((Split-Path -Leaf $TtsDataPath) -ne "Tabletop Simulator") {
    throw "TtsDataPath must point to the Tabletop Simulator data folder. Current path: $TtsDataPath"
}

if (-not $VerifyOnly) {
    $Running = Get-Process -Name "Tabletop Simulator" -ErrorAction SilentlyContinue
    if ($Running) {
        throw "Tabletop Simulator is running. Exit the game completely and run the installer again."
    }
}

$WorkshopJson = Join-Path $TtsDataPath "Mods\Workshop\$WorkshopId.json"
if (-not $SkipWorkshopCheck -and -not (Test-Path -LiteralPath $WorkshopJson -PathType Leaf)) {
    throw @"
The Workshop subscription file was not found:
$WorkshopJson

Subscribe to Workshop item $WorkshopId, start TTS once so the subscription file appears,
then exit TTS and run this installer again.
Use -TtsDataPath for a custom data folder or -SkipWorkshopCheck to preinstall the cache.
"@
}

$Manifest = Get-Content -LiteralPath $ManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
if ([string]$Manifest.workshop_id -ne $WorkshopId) {
    throw "The Workshop ID in the manifest does not match this installer."
}

$Copied = 0
$Verified = 0
$Index = 0
$Total = @($Manifest.resources).Count

foreach ($Resource in $Manifest.resources) {
    $Index++
    $RelativePath = ([string]$Resource.relative_path).Replace('/', [System.IO.Path]::DirectorySeparatorChar)
    $Source = Join-Path $PackageRoot $RelativePath
    $Destination = Join-Path $TtsDataPath $RelativePath
    $ExpectedHash = ([string]$Resource.sha256).ToUpperInvariant()

    Write-Progress -Activity "Sanguosha Guozhan 2026 cache pack" -Status "$Index / $Total  $RelativePath" -PercentComplete (($Index / $Total) * 100)

    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        throw "The package is missing a file: $RelativePath"
    }
    $SourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash.ToUpperInvariant()
    if ($SourceHash -ne $ExpectedHash) {
        throw "Package hash verification failed: $RelativePath"
    }

    if (-not $VerifyOnly) {
        $DestinationFolder = Split-Path -Parent $Destination
        New-Item -ItemType Directory -Path $DestinationFolder -Force | Out-Null
        Copy-Item -LiteralPath $Source -Destination $Destination -Force
        $Copied++
    }

    if (-not (Test-Path -LiteralPath $Destination -PathType Leaf)) {
        throw "The destination cache is missing a file: $Destination"
    }
    $DestinationHash = (Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash.ToUpperInvariant()
    if ($DestinationHash -ne $ExpectedHash) {
        throw "Destination hash verification failed: $Destination"
    }
    $Verified++
}

Write-Progress -Activity "Sanguosha Guozhan 2026 cache pack" -Completed
if ($VerifyOnly) {
    Write-Host "Verification complete: $Verified / $Total resources are correct." -ForegroundColor Green
} else {
    Write-Host "Installation complete: copied $Copied resources and verified $Verified resources." -ForegroundColor Green
    Write-Host "Start Tabletop Simulator and open the mod from Games -> Workshop."
}
