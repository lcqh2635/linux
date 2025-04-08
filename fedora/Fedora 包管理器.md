Fedora Workstation 主要使用 **`dnf`**（新一代 RPM 包管理器）和 **`flatpak`**（跨发行版沙盒化软件包），以下是常用命令及其作用详解：

---

# 添加中科大 Fedora 镜像源，参考 https://mirrors.ustc.edu.cn/help/fedora.html
sudo sed -e 's|^metalink=|#metalink=|g' \
         -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
         -i.bak \
         /etc/yum.repos.d/fedora.repo \
         /etc/yum.repos.d/fedora-updates.repo

# 最后运行 sudo dnf makecache 生成缓存
sudo dnf makecache
# 添加中科大 Flatpak 镜像源，参考 https://mirrors.ustc.edu.cn/help/flathub.html
sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
# 恢复默认值
sudo flatpak remote-modify flathub --url=https://dl.flathub.org/repo
# 首先更新所有仓库信息
flatpak update --appstream
# 尝试更新所有已安装的软件包
flatpak update
# 列出所有应用，获取 <应用ID>
flatpak list --app
# 卸载 Flatpak 应用
flatpak uninstall <应用ID>

sudo dnf install gnome-tweaks.noarch
flatpak install flathub org.gnome.Extensions -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
# 安装终端自动补全包，安装后 logout
sudo dnf install bash-completion.noarch
source /etc/profile.d/bash_completion.sh

# 网站国内可用 DNS 测试 ping 	https://ping.chinaz.com/www.youtube.com
# 配置Github访问加速
echo "
# GitHub Start
20.27.177.113    github.com
185.199.108.133    raw.githubusercontent.com

103.200.30.143    archive.org

# GitHub End
" | sudo tee -a /etc/hosts
# 简化版（匹配任意条件内容）
# 修改（将 20.27.177.113 替换为 192.168.1.100）
sudo sed -i 's/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\([[:space:]]\+github\.com\)/20.205.243.166\1/' /etc/hosts
sudo sed -i 's/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\([[:space:]]\+raw\.githubusercontent\.com\)/185.199.111.133\1/' /etc/hosts
# 验证
grep 'github.com' /etc/hosts
grep 'raw.githubusercontent.com' /etc/hosts

echo "103.200.30.143    archive.org" | sudo tee -a /etc/hosts

cat /etc/hosts | grep archive.org  # 检查是否添加成功
ping archive.org                  # 测试域名解析是否指向目标 IP

# 检查是否解析为新IP
ping github.com
ping raw.githubusercontent.com
cat /etc/hosts
nautilus admin:/etc/hosts

# 安装基础依赖包
sudo dnf install git.x86_64 wl-clipboard.x86_64
git config --global user.name "龙茶清欢"
git config --global user.email "2320391937@qq.com"
ssh-keygen -t rsa -b 4096 -C "2320391937@qq.com"
# 需要安装 wl-clipboard 工具
cat ~/.ssh/id_rsa.pub | wl-copy
# https://gitee.com/profile/sshkeys
# https://github.com/settings/keys

# 主题美化
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
sed -i 's/\$opacity: if([^;]*);/\$opacity: 1;/g' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss
./install.sh       # 同时安装Dark/Light两种主题
./tweaks.sh -f flat
sudo ./tweaks.sh -g
# 授予全局访问 GTK 配置和主题文件的权限
# 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-3.0 目录。该目录包含 GTK 3 的配置文件（如主题、图标、字体设置等）。
sudo flatpak override --filesystem=xdg-config/gtk-3.0
# 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-4.0 目录。
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --filesystem=/usr/share/themes  # 系统主题目录
sudo flatpak override --filesystem=~/.themes          # 用户主题目录（如果有自定义主题）

# 列出所有应用，获取 <应用ID>
flatpak list --app
flatpak override org.videolan.VLC --filesystem=xdg-config/gtk-3.0
flatpak override org.videolan.VLC --filesystem=xdg-config/gtk-4.0
# 将 WhiteSur 主题包连接到 Flatpak 仓库
./tweaks.sh -F

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
./install.sh
git clone https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1
./install.sh
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
sudo ./install-gnome-backgrounds.sh

# 安装 kvantum（Qt 主题配置工具）
sudo dnf install kvantum

kvantum 主题存放在 ~/.config/Kvantum/

ls ~/.config/Kvantum/  # 查看用户主题，我么安装的就在这里面
ls /usr/share/Kvantum/ # 查看系统主题

nautilus admin:/usr/share/Kvantum/

git clone https://github.com/vinceliuice/WhiteSur-kde.git --depth=1
./install.sh -w opaque

# 设置环境变量
echo 'export QT_STYLE_OVERRIDE=kvantum' >> ~/.bashrc
source ~/.bashrc
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.local/share/icons
ls $HOME/.themes
ls $HOME/.local/share/icons
sudo flatpak override --env=GTK_THEME=WhiteSur-Dark
sudo flatpak override --env=ICON_THEME=WhiteSur-Dark

# 对于单个应用程序
sudo flatpak override org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
sudo flatpak override org.fedoraproject.MediaWriter --env=ICON_THEME=WhiteSur-Dark

# 若需更深度适配（如 Kvantum）
flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
# 允许读写取系统主题，默认权限为 读写（Read-Write），应用可以读取和修改目录中的文件。
# ro 表示 只读（Read-Only）。它的作用是限制 Flatpak 应用对指定目录的访问权限，仅允许 读取 文件，而 禁止写入或修改。
flatpak override --user --filesystem=/usr/share/themes:ro
flatpak override --user --filesystem=~/.themes:ro  # 若使用用户级主题

# 指定主题名称（如 WhiteSur-Light）
flatpak override --user --env=GTK_THEME=WhiteSur-Light
# 例如强制 Media Writer 使用 GTK 主题
flatpak override --user org.fedoraproject.MediaWriter --env=QT_QPA_PLATFORMTHEME=gtk3
flatpak run --env=GTK_THEME=WhiteSur-Light org.fedoraproject.MediaWriter
# 列出所有已安装的 Flatpak 应用和运行时
flatpak list
# 查看应用使用的运行时等信息
flatpak list --app
# 查看所有应用的全局覆盖配置
flatpak override --show
flatpak run --env=GTK_DEBUG=all <应用ID>
flatpak run --env=GTK_DEBUG=all org.fedoraproject.MediaWriter

flatpak info org.fedoraproject.MediaWriter
flatpak info com.obsproject.Studio
flatpak info org.videolan.VLC
flatpak info cn.apipost.apipost
flatpak info org.gnome.Extensions
flatpak info io.typora.Typora
flatpak info md.obsidian.Obsidian
# 建议优先使用 GNOME 运行时（对 GTK 主题兼容性更好）
flatpak install flathub org.gnome.Platform
flatpak search org.gtk.Gtk3theme

# 在 Linux 中的 Flatpak 应用程序上应用 GTK 系统主题，参考 https://cn.linux-console.net/?p=18267
# 安装 Kvantum 软件
flatpak install org.kde.KStyle.Kvantum -y
kvantum-manager  # 在 "Change/Delete Theme" 中微调 WhiteSur 参数
sudo flatpak override --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro org.fedoraproject.MediaWriter

# 安装 StylePak 软件，参考 https://github.com/refi64/stylepak
dnf install ostree libappstream-glib

# 应用主题
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'

gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/WhiteSur/WhiteSur-timed.xml'
gsettings get org.gnome.desktop.background picture-uri


# 安装配置系统字体
sudo dnf install adobe-source-han-sans-cn-fonts
sudo dnf install adobe-source-han-serif-cn-fonts
sudo dnf install jetbrains-mono-fonts
logout
gsettings set org.gnome.desktop.interface font-name '思源黑体 CN Medium 12'
gsettings set org.gnome.desktop.interface document-font-name '思源宋体 CN Medium 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font '思源黑体 CN Bold 12'

gsettings reset org.gnome.desktop.interface font-name
gsettings reset org.gnome.desktop.interface document-font-name
gsettings reset org.gnome.desktop.wm.preferences titlebar-font
gsettings get org.gnome.desktop.wm.preferences theme

gsettings set org.gnome.desktop.interface cursor-size 20
gsettings get org.gnome.desktop.interface cursor-size

# 列出所有已安装的 Schema
gsettings list-schemas
# 列出某个 Schema 下的所有键
gsettings list-keys org.gnome.desktop.interface
gsettings list-keys org.gnome.nautilus.preferences
gsettings list-keys org.gnome.software
# 查看键的取值类型和描述
gsettings describe org.gnome.desktop.interface font-name
# 递归列出某个 Schema 的键值（例如 org.gnome.desktop.interface）
gsettings list-recursively org.gnome.desktop.interface
gsettings list-recursively org.gnome.nautilus.preferences
gsettings list-recursively org.gnome.software

yay -S apifox switchhosts tabby
# https://www.virtualbox.org/wiki/Linux_Downloads
sudo dnf install vagrant.noarch virtualbox-guest-additions.x86_64

https://v2.tauri.app/zh-cn/start/prerequisites/#linux
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 安装 sdkman 工具，官网 https://sdkman.io/install
curl -s "https://get.sdkman.io" | bash
# 安装 nvm，参考官方文档 https://nvm.p6p.net/
# nodejs 官网 https://nodejs.cn/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# 最新地址 淘宝 NPM 镜像站喊你切换新域名啦!
npm config set registry https://registry.npmmirror.com
npm config get registry
npm install -g bun
echo 你刚安装的 bun 版本号为： $(bun --version)
# 将 bunfig.toml 作为隐藏文件添加到用户主目录
echo '[install]
# 使用阿里云加速仓库，仓库地址可从阿里云官方获取，地址为 https://developer.aliyun.com/mirror/
registry = "https://registry.npmmirror.com/"
' >> ~/.bunfig.toml
cat ~/.bunfig.toml
# 使用 bun 创建一个基于 vue-ts 模板的项目，bun即是一个包管理器也是JS运行时
bun create vite bun-vue3-ts --template vue-ts
bun install
bun run dev
# 是用 bun 创建一个 tauri 2.0 项目，参考 https://v2.tauri.app/zh-cn/
bun create tauri-app
cd tauri-app
bun install
# 需要提前安装并配置好 Android Studio  参考 https://tauri.app/zh-cn/start/prerequisites/#android
bun run tauri android init
# For Desktop development, run:
bun run tauri dev
# 对于 Android 开发: 需要提前安装并配置好 Android Studio  参考 https://tauri.app/zh-cn/start/prerequisites/#android
bun run tauri android dev

# 安装 go 直接打开 manjaro自带的应用商城搜索 go 并安装即可
sudo dnf install golang.x86_64
go version
# 配置加速代理
go env -w GOPROXY=https://goproxy.cn,direct
go env


# 下载 jetbrains-toolbox
https://www.jetbrains.com/zh-cn/toolbox-app/download/download-thanks.html?platform=linux

sudo dnf install google-chrome-stable.x86_64
sudo dnf install libreoffice-langpack-zh-Hans.x86_64
sudo dnf install evolution.x86_64
flatpak install flathub org.gnome.Evolution -y
# evolution配置qq邮箱授权码： embwnsuwkdjrebge
sudo dnf install fastfetch.x86_64
fastfetch
# 自定义 GNOME 的方方面面，类似 gnome-tweaks
flatpak install flathub page.tesk.Refine -y

flatpak install flathub io.github.realmazharhussain.GdmSettings -y

flatpak install flathub io.typora.Typora -y
flatpak install flathub md.obsidian.Obsidian -y

flatpak install flathub com.qq.QQ -y
flatpak install flathub com.tencent.WeChat -y
flatpak install flathub com.qq.QQmusic -y
flatpak install flathub com.tencent.wemeet -y
flatpak install flathub com.baidu.NetDisk -y
flatpak install flathub io.github.qier222.YesPlayMusic -y

flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate -y
flatpak install flathub com.visualstudio.code -y
# Dev tools at your fingertips
flatpak install flathub me.iepure.devtoolbox -y
flatpak install flathub cn.apipost.apipost -y
flatpak install flathub com.getpostman.Postman -y

flatpak install flathub com.microsoft.Edge -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.videolan.VLC -y

# 管理 Flatpak 权限
flatpak install flathub com.github.tchx84.Flatseal -y
# Manage all things Flatpak
flatpak install flathub io.github.flattool.Warehouse -y
# Flatpak残留清理器
flatpak install flathub io.github.giantpinkrobots.flatsweep -y
# 管理 AppImages 应用
flatpak install flathub it.mijorus.gearlever -y
# Use Linux devices as second screens
flatpak install flathub eu.nokun.MirrorHall -y
# Telegram
flatpak install flathub org.telegram.desktop -y
# 翻译
flatpak install flathub app.drey.Dialect -y
# 办公软件
flatpak install flathub org.libreoffice.LibreOffice -y
# RustDesk
flatpak install flathub com.rustdesk.RustDesk -y
# 制作 ISO 系统启动盘
# Fedora 启动盘写入工具
flatpak install flathub org.fedoraproject.MediaWriter -y
flatpak install flathub com.system76.Popsicle -y
flatpak install flathub io.gitlab.adhami3310.Impression -y
# 快捷、安全的文件传输工具
flatpak install flathub app.drey.Warp -y
# 下载、使用且能自适应的 GTK 应用程序字体
flatpak install flathub org.gustavoperedo.FontDownloader -y
# 管理您的密码
flatpak install flathub org.gnome.World.Secrets -y
flatpak install flathub org.gnome.seahorse.Application -y
# 用于编辑 dconf 数据库的图形化工具
flatpak install flathub ca.desrt.dconf-editor -y
# 对应用程序和库进行翻译和本地化，它能处理所有形式的 gettext po 文件
flatpak install flathub org.gnome.Gtranslator -y
# 保护您的数据安全、数据备份
flatpak install flathub org.gnome.World.PikaBackup -y
# 在设备上安装固件管理
flatpak install flathub org.gnome.Firmware -y
# 种子下载器
flatpak install flathub net.agalwood.Motrix -y
# 保存您的桌面环境配置
flatpak install flathub io.github.vikdevelop.SaveDesktop -y
# Podman 虚拟容器化管理器，需要本地安装 Podman 或者提供远程连接地址
flatpak install flathub com.github.marhkb.Pods -y
# 一个系统 systemd 服务管理器
flatpak install flathub io.github.plrigaux.sysd-manager -y
# Create beautiful ASCII art
flatpak install flathub io.gitlab.gregorni.Letterpress -y
# Turn text into ASCII banners
flatpak install flathub dev.geopjr.Calligraphy -y
# proton vpn
flatpak install flathub com.protonvpn.www -y
# Clash's graphical client, based on Electron.
flatpak install flathub io.github.Fndroid.clash_for_windows -y
# Give Steam the Adwaita treatment
flatpak install flathub io.github.Foldex.AdwSteamGtk -y

# Flaypak 中 KDE 应用 https://flathub.org/zh-Hans/apps/collection/developer/KDE/1
# Flaypak 中 Gnome 应用 https://flathub.org/zh-Hans/apps/collection/developer/The%20GNOME%20Project/1

https://apifox.com/
https://github.com/Eugeny/tabby/releases


Alphabetical App Grid
Bluetooth Quick Connect
# 安装 Lunar Calendar 农历 扩展插件需要如下内容
#https://gitlab.gnome.org/Nei/ChineseCalendar/-/archive/20250205/ChineseCalendar-20250205.tar.gz
# tar -xzvf ChineseCalendar-20250205.tar.gz
# cd ChineseCalendar-20250205
# ./install.sh
Lunar Calendar 农历
Night Theme Switcher
# 到 Gnome设置、显示器、夜灯 来调整系统 Dark/Light 主题切换的逻辑。使其和 Night Theme Switcher 插件对应一直
# 参考官方解决方案 https://github.com/vinceliuice/WhiteSur-gtk-theme/issues/1059
# 白天执行命令
gsettings set org.gnome.desktop.interface color-scheme 'default'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'
ln -fs $HOME/.config/gtk-4.0/gtk-Light.css $HOME/.config/gtk-4.0/gtk.css
# 夜晚执行命令
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark'
ln -fs $HOME/.config/gtk-4.0/gtk-Dark.css $HOME/.config/gtk-4.0/gtk.css

# 确认它们是否在后台运行？
pgrep -l nautilus
pgrep -l gnome-software
# 彻底关闭 Nautilus
pkill nautilus
nautilus -q  # 完全退出
nautilus &   # 重新启动（可选）
# 彻底关闭 GNOME Software
pkill gnome-software


# 系统扩展插件
sudo dnf install gnome-shell-extension-user-theme 
gnome-shell-extension-dash-to-dock
gnome-shell-extension-blur-my-shell.noarch
gnome-shell-extension-just-perfection.noarch
gnome-shell-extension-drive-menu.noarch
gnome-shell-extension-caffeine.noarch
gnome-shell-extension-disconnect-wifi.noarch
gnome-shell-extension-refresh-wifi.noarch
gnome-shell-extension-no-overview.noarch
gnome-shell-extension-workspace-indicator.noarch

# 卸载自带的无用扩展插件
sudo dnf remove gnome-shell-extension-window-list gnome-shell-extension-launch-new-instance
# 以下是推荐安装的用户扩展插件
Notification Banner Reloaded
Quick Settings Tweaks
Rounded Corners
Rounded Window Corners Reborn
Search Light
SettingsCenter
Top Bar Organizer
Tray Icons: Reloaded
User Avatar In Quick Settings
Window Gestures
VirtualBox applet




### **1. DNF 命令（核心包管理）**
#### **基础操作**
| 命令 | 作用 | 示例 |
|------|------|------|
| `sudo dnf update` | 更新**所有已安装的软件包**（相当于 `upgrade`） | `sudo dnf update` |
| `sudo dnf upgrade` | 同上，与 `update` 完全等价 | `sudo dnf upgrade` |
| `sudo dnf install <包名>` | 安装指定软件包 | `sudo dnf install neovim` |
| `sudo dnf remove <包名>` | 卸载软件包（保留配置文件） | `sudo dnf remove firefox` |
| `sudo dnf autoremove` | 删除无用的依赖包 | `sudo dnf autoremove` |
| `sudo dnf search <关键词>` | 搜索软件包 | `sudo dnf search python3` |
| `sudo dnf info <包名>` | 查看软件包详细信息 | `sudo dnf info git` |

#### **高级操作**
| 命令 | 作用 | 示例 |
|------|------|------|
| `sudo dnf group list` | 查看软件包组（如开发工具组） | `sudo dnf group list` |
| `sudo dnf group install "组名"` | 安装软件包组 | `sudo dnf group install "Development Tools"` |
| `sudo dnf history` | 查看操作历史（可回滚） | `sudo dnf history undo 3` |
| `sudo dnf repoquery <包名>` | 查询仓库中包的依赖关系 | `sudo dnf repoquery --requires httpd` |
| `sudo dnf clean all` | 清理缓存（`/var/cache/dnf`） | `sudo dnf clean all` |

---

### **2. Flatpak 命令（沙盒化应用）**
| 命令 | 作用 | 示例 |
|------|------|------|
| `flatpak install <远程仓库> <应用ID>` | 安装 Flatpak 应用 | `flatpak install flathub com.spotify.Client` |
| `flatpak run <应用ID>` | 运行 Flatpak 应用 | `flatpak run org.telegram.desktop` |
| `flatpak update` | 更新所有 Flatpak 应用 | `flatpak update` |
| `flatpak list` | 列出已安装的 Flatpak 应用 | `flatpak list` |
| `flatpak uninstall <应用ID>` | 卸载 Flatpak 应用 | `flatpak uninstall org.gimp.GIMP` |
| `flatpak search <关键词>` | 搜索 Flatpak 应用 | `flatpak search discord` |

---

### **3. RPM 命令（底层包工具）**
> 注：通常优先用 `dnf`，`rpm` 仅用于特殊情况（如直接安装 `.rpm` 文件）。

| 命令 | 作用 | 示例 |
|------|------|------|
| `rpm -ivh <包名.rpm>` | 安装本地 RPM 包 | `sudo rpm -ivh package.rpm` |
| `rpm -e <包名>` | 卸载 RPM 包 | `sudo rpm -e package` |
| `rpm -qa` | 列出所有已安装的 RPM 包 | `rpm -qa \| grep python` |
| `rpm -qi <包名>` | 查询包信息 | `rpm -qi bash` |
| `rpm -ql <包名>` | 列出包安装的文件 | `rpm -ql httpd` |

---

### **4. 其他实用命令**
#### **COPR（社区仓库）**
```bash
# 启用 COPR 仓库（第三方非官方源）
sudo dnf copr enable user/repo

# 示例：启用 RPM Fusion 的 Steam 支持
sudo dnf copr enable rpmfusion/steam

# 配置清华加速仓库，参考 https://mirrors.tuna.tsinghua.edu.cn/help/fedora/
sed -e 's|^metalink=|#metalink=|g' \
    -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' \
    -i.bak \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo

# 更新本地缓存
sudo dnf makecache


# 安装 RPM Fusion 并更换清华源
# RPM Fusion 为 Fedora/RHEL 提供额外的大量 RPM 软件包的第三方软件源。
sudo dnf install --nogpgcheck https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

```

#### **Toolbox（容器化开发环境）**
```bash
# 创建容器
toolbox create myenv

# 进入容器
toolbox enter myenv
```

---

### **关键场景示例**
1. **安装开发工具链**：
   ```bash
   sudo dnf group install "Development Tools"
   sudo dnf install git gcc cmake
   ```

2. **清理系统**：
   ```bash
   sudo dnf autoremove
   sudo dnf clean all
   ```

3. **安装商业软件（如 VS Code）**：
   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/vscode
   sudo dnf install code
   ```

---

### **总结表**
| **工具**   | **用途**                  | **优势**                          |
|------------|---------------------------|-----------------------------------|
| `dnf`      | 系统级软件管理            | 依赖解决完善，支持事务回滚        |
| `flatpak`  | 沙盒化应用（如Spotify）   | 隔离依赖，避免冲突                |
| `rpm`      | 直接操作 RPM 包           | 底层控制，适合调试                |
| `toolbox`  | 容器化开发环境            | 不污染主机系统                    |

建议优先使用 `dnf` 管理核心软件，`flatpak` 安装桌面应用，`toolbox` 隔离开发环境。


# 配置参考 https://github.com/tsujan/Kvantum/blob/master/Kvantum/INSTALL.md#in-other-des
mkdir -p ~/.config/environment.d && cat <<EOF > ~/.config/environment.d/qt.conf
QT_STYLE_OVERRIDE=kvantum
EOF
cat ~/.config/environment.d/qt.conf
# Fedora 系统中统一 QT 应用使用 GTK 应用。参考 https://discussion.fedoraproject.org/t/mbriza-qt-gtk/10172/1

# COSMIC (Computer Operating System Main Interface Components) 桌面环境 是由 System76 公司（以开发 Pop!_OS 闻名）全新设计的桌面环境，旨在提供现代化、高性能且高度可定制的用户体验。官网 https://system76.com/cosmic/
# System76 为摆脱 GNOME 的限制，基于 Rust 语言和 Iced 框架从头构建，强调性能、可扩展性和用户控制权。
# COSMIC 桌面是 System76 对 Linux 桌面未来的一次大胆重构，适合追求极致性能、定制化和现代设计的用户。若你厌倦了传统桌面的限制，它值得尝试！
# 原生 Wayland 支持：提升图形性能和安全性。相比 GNOME，减少动画卡顿，尤其在老旧硬件上表现更佳。
