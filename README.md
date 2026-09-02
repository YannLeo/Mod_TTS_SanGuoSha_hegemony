# 三国杀国战线下2026 · TTS 创意工坊图包

这是 Tabletop Simulator 创意工坊模组 **三国杀国战线下2026** 的本地缓存资源包，用于网络较慢、Steam Cloud 下载失败或多人开局前预装资源的情况。

- 创意工坊 ID：`3794307123`
- 创意工坊地址：[Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3794307123)
- 图包版本：`v1.0.0`
- 对应资源：40 张图片、1 个音频、1 个 AssetBundle
- 内容总量：约 419.4 MiB

> 本包不是独立存档。推荐先订阅创意工坊模组，再安装本地缓存。模组规则、脚本和物件结构仍由 Steam 创意工坊订阅文件提供。

## 推荐安装方法（Windows）

1. 在 Steam 中订阅[三国杀国战线下2026](https://steamcommunity.com/sharedfiles/filedetails/?id=3794307123)。
2. 启动一次 Tabletop Simulator，等待该模组出现在 `Games → Workshop`，然后完全退出游戏。
3. 从本仓库右侧 **Releases** 下载 `Sanguosha-Guozhan-2026-WorkshopCache-v1.0.0.zip`，并完整解压到任意文件夹。
4. 在解压目录中打开 PowerShell，运行：

   ```powershell
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\Install-Workshop-Cache.ps1"
   ```

5. 看到“安装完成”后启动 TTS，从 `Games → Workshop` 打开模组。

安装脚本不会删除其他模组，也不会修改创意工坊存档；它只把本包列出的缓存文件复制到 TTS 的 `Mods` 目录，并逐个进行 SHA-256 校验。

### 文档目录或 TTS 数据目录不在默认位置

默认目录为：

```text
C:\Users\你的用户名\Documents\My Games\Tabletop Simulator
```

如果你的数据目录不同，显式指定：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\Install-Workshop-Cache.ps1" -TtsDataPath "D:\你的路径\Tabletop Simulator"
```

### 只校验已经安装的缓存

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\Install-Workshop-Cache.ps1" -VerifyOnly
```

## 手动安装

完全退出 TTS 后，把压缩包内的 `Mods` 文件夹合并到：

```text
C:\Users\你的用户名\Documents\My Games\Tabletop Simulator
```

出现同名文件时允许覆盖。因为文件名由 Steam Cloud URL 生成，相同文件名应对应相同资源；推荐使用安装脚本完成校验。

## 图包内容

```text
Mods/
├─ Images/          40 个 PNG 缓存
├─ Audio/            1 个 MP3 缓存
└─ Assetbundles/     1 个 Unity AssetBundle 缓存
```

- `manifest-cache.json`：Steam Cloud URL、目标路径、大小和 SHA-256 清单。
- `SHA256SUMS.txt`：发布文件校验值。
- `Install-Workshop-Cache.ps1`：Windows 安装与校验脚本。

没有收录 TTS 自动生成的 `Images Raw/*.rawt`，首次载入时游戏可能重新生成纹理缓存，这是正常现象。

## 常见问题

### 安装后仍然显示加载或下载

1. 确认订阅的是创意工坊 ID `3794307123`。
2. 确认解压/安装目标是 TTS 实际使用的数据目录。
3. 退出 TTS 后运行 `Install-Workshop-Cache.ps1 -VerifyOnly`。
4. 如果创意工坊模组已更新，可能产生了新的 Steam Cloud URL，需要下载对应的新版本图包。

### 能否只下载图包、不订阅创意工坊？

本包只提供运行时资源缓存，不提供独立的创意工坊存档。正常使用方式是“订阅创意工坊 + 安装图包”。

## GitHub 发布方式

不要把大型 ZIP 直接提交到 Git 仓库历史。请把本目录中的 README、脚本和清单提交到仓库，然后在 GitHub **Releases** 新建 `v1.0.0`，把以下两个文件作为 Release assets 上传：

- `Sanguosha-Guozhan-2026-WorkshopCache-v1.0.0.zip`
- `Sanguosha-Guozhan-2026-WorkshopCache-v1.0.0.zip.sha256`

## 更新说明

### v1.0.0

- 首个创意工坊缓存包。
- 精确收录创意工坊条目 `3794307123` 当前引用的 42 个唯一运行时资源。
- 包含图片、独立语音 AssetBundle 和背景音乐缓存。
- 提供订阅检查、复制和 SHA-256 校验脚本。

## 来源与说明

本项目为非官方爱好者制作内容，基于既有 TTS 模组继续整理，并对卡图白边、部分卡图、脚本、武将/游戏牌语音及交互进行了修改。

部分语音素材整理自 `qsgs-fans` 的相关资源项目，包括：

- [hegemony](https://gitee.com/qsgs-fans/hegemony)
- [standard_ex](https://gitee.com/qsgs-fans/standard_ex)
- [shzl](https://gitee.com/qsgs-fans/shzl)
- [qsgs-fans 项目列表](https://gitee.com/organizations/qsgs-fans/projects)

原游戏名称、美术、音频及相关标识的权利归各自权利人所有。本资源包不授予第三方素材的再许可，仅建议用于个人交流与 TTS 联机测试。公开发布前请补充原模组作者、卡图和音频的完整署名，并遵循各来源项目的许可与转载要求；若权利人要求移除相关内容，请由仓库维护者及时处理。
