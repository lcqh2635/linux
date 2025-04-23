以下是 Fedora 41 中推荐的 **常用 GUI 软件列表**，涵盖 **开发工具、办公、多媒体、系统工具** 等类别，均适配 GNOME 环境并支持 Wayland。所有软件均通过官方仓库或 Flathub 安装，确保兼容性和安全性。

---

### **📌 安装方法**
#### **1. 启用 Flathub（推荐）**
```bash
# 安装 ohmyzsh
https://github.com/ohmyzsh/ohmyzsh
zsh --version
sudo dnf install zsh -y
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

# 基础系统工具
flatpak install -y flathub \
com.github.tchx84.Flatseal \
io.github.flattool.Warehouse \
io.github.giantpinkrobots.flatsweep \
io.github.realmazharhussain.GdmSettings \
io.github.vikdevelop.SaveDesktop \
io.github.seadve.Kooha \
io.gitlab.adhami3310.Impression \
it.mijorus.gearlever \
org.gnome.Firmware \
org.gnome.Builder \
app.drey.Dialect \
ca.desrt.dconf-editor \
org.gnome.Gtranslator \
com.bitwarden.desktop \
de.haeckerfelix.Fragments \
org.gnome.gitlab.somas.Apostrophe \
org.gnome.World.PikaBackup

# 工作娱乐
flatpak install -y flathub \
com.qq.QQ \
com.tencent.WeChat \
io.github.qier222.YesPlayMusic \
com.baidu.NetDisk \
md.obsidian.Obsidian \
io.github.alainm23.planify

com.tencent.wemeet \
io.typora.Typora \


# 开发工具
flatpak install -y flathub \
com.jetbrains.IntelliJ-IDEA-Ultimate \
com.visualstudio.code \
me.iepure.devtoolbox \
cn.apipost.apipost

sudo dnf install -y tabby-terminal

# 游戏
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub io.github.Foldex.AdwSteamGtk -y

# 定期运行 flatpak uninstall --unused 删除旧版本运行时。
flatpak uninstall --unused -y

# 下载 jetbrains-toolbox
https://www.jetbrains.com/zh-cn/toolbox-app/download/download-thanks.html?platform=linux


https://www.jetbrains.com/zh-cn/toolbox-app/
```

#### **2. 安装方式选择**
- **官方仓库**：`sudo dnf install <软件包名>`
- **Flatpak**：`flatpak install flathub <应用ID>`
- **RPM Fusion**（第三方仓库）：需先启用（见注释）

---

### **💻 开发工具**
| 软件名称          | 功能描述       | 安装命令                                                     | 备注                  |
| ----------------- | -------------- | ------------------------------------------------------------ | --------------------- |
| **VS Code**       | 代码编辑器     | `sudo dnf install code`                                      | 或 Flatpak 版         |
| **IntelliJ IDEA** | Java IDE       | `flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community` | 社区版免费            |
| **GitKraken**     | Git 图形客户端 | `flatpak install flathub com.axosoft.GitKraken`              | 需订阅高级功能        |
| **DBeaver**       | 数据库管理工具 | `sudo dnf install dbeaver`                                   | 支持 MySQL/PostgreSQL |

```bash
sudo dnf install google-chrome-stable
sudo dnf install evolution obs-studio
# evolution配置qq邮箱授权码： embwnsuwkdjrebge
sudo dnf install fastfetch
fastfetch
sudo dnf install vagrant VirtualBox virtualbox-guest-additions

# 开发常用软件
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate -y
flatpak install flathub com.google.AndroidStudio -y
flatpak install flathub dev.zed.Zed -y
flatpak install flathub io.github.shiftey.Desktop -y
flatpak install flathub com.visualstudio.code -y
# 触手可及的开发工具箱
flatpak install flathub me.iepure.devtoolbox -y


# 一键安装 Watt Toolkit 软件脚本，参考 https://steampp.net/
# 安装后还需要额外处理一些问题 https://steampp.net/liunxSetupCer
# 安装目录     /home/lcqh/.local/share/WattToolkit
curl -sSL https://steampp.net/Install/Linux.sh | bash
# 处理 Watt Toolkit 程序没有 Host 文件权限
sudo chmod a+w /etc/hosts
# 在网络加速中点击 加速设置 然后点击 安装证书
# 在设置中将 背景不透明度 调到最高，禁用背景透明效果

# 火狐浏览器导入 Watt Toolkit 证书
# 打开 设置 - 隐私与安全 - 安全 - 证书 - 查看证书。
# 选择 证书颁发机构 然后点击导入
# 证书地址为 /home/lcqh/.local/share/Steam++/Plugins/Accelerator/SteamTools.Certificate.cer
# 勾选 信任由此证书颁发机构来标识网站

# Google浏览器导入 Watt Toolkit 证书
# 打开 设置 - 隐私与安全 - 安全 - 管理证书
# chrome 搜索栏输入chrome://settings/certificates，选择导入证书
# 本地证书 - 自定义 - 可信证书 - 导入
# 证书地址为 /home/lcqh/.local/share/Steam++/Plugins/Accelerator/SteamTools.Certificate.cer
# 点击 Steam 左上角 stream 菜单 - Settings - interface 在其中设置界面为中文
```

---

### **📚 办公与生产力**
| 软件名称        | 功能描述                   | 安装命令                                                    | 备注         |
| --------------- | -------------------------- | ----------------------------------------------------------- | ------------ |
| **LibreOffice** | 开源办公套件               | `sudo dnf install libreoffice-langpack-zh-Hans`             | 默认已安装   |
| **OnlyOffice**  | 兼容 MS Office 格式        | `flatpak install flathub org.onlyoffice.desktopeditors`     | 界面更现代   |
| **Apostrophe**  | 官方推荐的 Markdown 编辑器 | `flatpak install flathub org.gnome.gitlab.somas.Apostrophe` | 学术研究必备 |
| **Obsidian**    | Markdown 笔记工具          | `flatpak install flathub md.obsidian.Obsidian`              | 支持插件扩展 |

```bash
sudo dnf install libreoffice-langpack-zh-Hans

# GNOME 官方推荐的 Markdown 编辑器，界面极简，支持实时预览、数学公式（LaTeX）、导出 PDF/HTML。
flatpak install -y flathub org.gnome.gitlab.somas.Apostrophe
```

---

### **🎨 图形与设计**
| 软件名称     | 功能描述                    | 安装命令                    | 备注              |
| ------------ | --------------------------- | --------------------------- | ----------------- |
| **GIMP**     | 图像编辑（Photoshop替代）   | `sudo dnf install gimp`     | 支持插件          |
| **Inkscape** | 矢量绘图（Illustrator替代） | `sudo dnf install inkscape` | 适合 SVG 设计     |
| **Krita**    | 数字绘画工具                | `sudo dnf install krita`    | 压感笔支持优秀    |
| **Blender**  | 3D 建模与动画               | `sudo dnf install blender`  | 需启用 RPM Fusion |

---

### **🎵 多媒体**
| 软件名称       | 功能描述       | 安装命令                                     | 备注          |
| -------------- | -------------- | -------------------------------------------- | ------------- |
| **VLC**        | 万能视频播放器 | `sudo dnf install vlc`                       | 需 RPM Fusion |
| **Spotify**    | 音乐流媒体     | `flatpak install flathub com.spotify.Client` | 官方客户端    |
| **OBS Studio** | 直播/录屏工具  | `sudo dnf install obs-studio`                | 需 RPM Fusion |
| **HandBrake**  | 视频转码工具   | `sudo dnf install handbrake`                 | 支持 GPU 加速 |

```

```

---

### **🛠️ 系统工具**
| 软件名称         | 功能描述       | 安装命令                        | 备注                    |
| ---------------- | -------------- | ------------------------------- | ----------------------- |
| **GNOME Tweaks** | 系统高级设置   | `sudo dnf install gnome-tweaks` | 必备优化工具            |
| **Timeshift**    | 系统快照备份   | `sudo dnf install timeshift`    | 类似 macOS Time Machine |
| **Stacer**       | 系统清理与监控 | `sudo dnf install stacer`       | 图形化任务管理器        |
| **GParted**      | 分区管理工具   | `sudo dnf install gparted`      | 需 root 权限            |

---

### **💡 使用建议**
1. **优先选择 Flatpak**：避免依赖冲突，尤其适合闭源软件（如 Spotify）。  
2. **硬件加速**：视频编辑/游戏类软件需安装 NVIDIA 驱动或 VA-API：  
   ```bash
   sudo dnf install ffmpeg-freeworld intel-media-driver
   ```
3. **清理缓存**：定期维护 Flatpak 应用：  
   ```bash
   flatpak uninstall --unused
   ```

---

### **一键安装所有推荐软件（示例）**

按此清单配置后，Fedora 41 将覆盖绝大多数日常使用场景，兼顾生产力和娱乐需求！ 🚀

```bash
# 安装常用 Flathub 软件
# 管理 Flatpak 权限
flatpak install flathub com.github.tchx84.Flatseal -y
# 管理 Flatpak 的所有内容
flatpak install flathub io.github.flattool.Warehouse -y
# Flatpak残留清理器
flatpak install flathub io.github.giantpinkrobots.flatsweep -y
# 管理 AppImages 应用
flatpak install flathub it.mijorus.gearlever -y
# 在设备上安装固件管理
flatpak install flathub org.gnome.Firmware -y
# 种子下载器
flatpak install flathub de.haeckerfelix.Fragments -y
# 系统备份
flatpak install flathub org.gnome.World.PikaBackup -y
# GDM 设置
flatpak install flathub io.github.realmazharhussain.GdmSettings -y
flatpak install flathub org.gnome.Evolution -y
flatpak install flathub io.typora.Typora -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.baidu.NetDisk -y
flatpak install flathub io.github.qier222.YesPlayMusic -y
flatpak install flathub com.microsoft.Edge -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub app.zen_browser.zen -y
flatpak install flathub org.videolan.VLC -y
# 使用 Linux 设备作为第二屏幕
flatpak install flathub eu.nokun.MirrorHall -y
# 翻译
flatpak install flathub app.drey.Dialect -y
# 办公软件
flatpak install flathub org.libreoffice.LibreOffice -y
# 制作 ISO 系统启动盘
flatpak install flathub io.gitlab.adhami3310.Impression -y
# 快捷、安全的文件传输工具
flatpak install flathub app.drey.Warp -y
# 下载、使用且能自适应的 GTK 应用程序字体
flatpak install flathub org.gustavoperedo.FontDownloader -y
# 管理您的密码和密钥，优先使用 bitwarden
flatpak install flathub org.gnome.seahorse.Application -y
flatpak install flathub com.bitwarden.desktop -y
# 用于编辑 dconf 数据库的图形化工具
flatpak install flathub ca.desrt.dconf-editor -y
# 对应用程序和库进行翻译和本地化，它能处理所有形式的 gettext po 文件
flatpak install flathub org.gnome.Gtranslator -y
# 保护您的数据安全、数据备份
flatpak install flathub org.gnome.World.PikaBackup -y
# 保存您的桌面环境配置，例如：主题、字体、扩展等等
flatpak install flathub io.github.vikdevelop.SaveDesktop -y
# Podman 虚拟容器化管理器，需要本地安装 Podman 或者提供远程连接地址
flatpak install flathub com.github.marhkb.Pods -y
flatpak install flathub io.podman_desktop.PodmanDesktop -y
# 一个系统 systemd 服务管理器
flatpak install flathub io.github.plrigaux.sysd-manager -y
# VPN 软件
flatpak install flathub com.protonvpn.www -y
flatpak install flathub io.github.Fndroid.clash_for_windows -y
# Lutris 可帮您安装和运行大多数平台上几乎所有时代的电子游戏。通过对现有的模拟器、兼容层、第三方游戏引擎等进行整合利用，Lutris 可为您提供一个统一的界面来启动您的所有游戏。
flatpak install flathub net.lutris.Lutris -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub io.github.Foldex.AdwSteamGtk -y
# 与AI模型聊天
flatpak install flathub com.jeffser.Alpaca -y
# 查看有关系统的信息
flatpak install flathub io.github.nokse22.inspector -y
# Bottles 允许您在 Linux 上运行 Windows 软件，例如应用程序和游戏。
flatpak install flathub com.usebottles.bottles -y
# 让 Firefox 保持时尚，可轻松安装 Firefox GNOME Theme* 并在后台自动更新。
flatpak install flathub dev.qwery.AddWater -y
# 为 GNOME 创建应用程序
flatpak install flathub org.gnome.Builder -y
# Workbench 用于使用 GNOME 技术进行学习和原型设计，无论是第一次修补还是构建和测试 GTK 用户界面。
flatpak install flathub re.sonny.Workbench -y
# https://flathub.org/zh-Hans/apps/com.jetbrains.IntelliJ-IDEA-Ultimate
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate -y
# 及时跟进您的订阅
flatpak install flathub io.gitlab.news_flash.NewsFlash -y
# 忘记忘记事情
flatpak install flathub io.github.alainm23.planify -y
# 这款阅读器的界面简洁、美观、适应性强，可让您轻松搜索、排序和阅读系列文章。
flatpak install flathub info.febvre.Komikku -y
# 创建和编辑应用程序快捷方式
flatpak install flathub io.github.fabrialberio.pinapp -y
# 自定义应用程序图标
flatpak install flathub page.codeberg.libre_menu_editor.LibreMenuEditor -y
# 屏幕录制，替代 OBS
flatpak install flathub io.github.seadve.Kooha -y
flatpak install -y flathub com.obsproject.Studio
# 彻底删除应用及数据：
flatpak uninstall --delete-data flathub com.obsproject.Studio -y
# 定期运行 flatpak uninstall --unused 删除旧版本运行时。
flatpak uninstall --unused -y
# 列出已配置的远程仓库
flatpak remote-list -d
sudo flatpak override --reset

# 以下软件为适配主题，依旧使用自带默认主题
flatpak install flathub com.qq.QQ -y
flatpak install flathub com.tencent.WeChat -y
flatpak install flathub com.tencent.wemeet -y
flatpak install flathub cn.apipost.apipost -y
flatpak install flathub com.rustdesk.RustDesk -y
# Fedora 自带启动盘 ISO 写入工具
flatpak install flathub org.fedoraproject.MediaWriter -y
# 创建图像或编辑照片
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.wps.Office -y



```

