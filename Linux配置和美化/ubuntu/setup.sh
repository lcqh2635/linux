打开 “软件和更新” 将中的软件源设置为 “阿里云 aliyun” 提供的加速镜像，
不要直接选 “直接位于中国的服务器” 这可能会导致一些异常

https://cn.ubuntu.com/pro
sudo pro attach C1fNYhSKakFcaXf77wgse9XF725K6
sudo pro enable esm-apps esm-infra livepatch
# pro status --all

# 更新 APT 包列表、升级 APT 包、 删除无用依赖、清理无效缓存
sudo apt update -y && sudo apt upgrade -y && sudo snap refresh && sudo apt autoremove -y && sudo apt autoclean -y
# 一些软件源配置可被改进为现代化的配置方法。请运行“apt modernize-sources”来进行此操作
sudo apt modernize-sources -y

sudo apt install -y \
git vlc fastfetch dconf-editor evolution \
obs-studio synaptic flameshot timeshift \
software-properties-gtk \
celluloid goldendict qalculate-gtk \
baobab bleachbit libadwaita-1-examples libadwaita-1-doc

sudo apt install -y \
gnome-control-center gnome-system-monitor \
gnome-boxes gnome-browser-connector \
gnome-weather gnome-tour gnome-usage \
gnome-sound-recorder gnome-power-manager \
gnome-builder gnome-calendar

sudo apt install -y adwaita-qt adwaita-qt6

# 安装并配置 flatpak
sudo apt install -y \
gnome-tweaks \
gnome-shell-extension-manager \
gnome-software flatpak \
gnome-software-plugin-flatpak \
gnome-software-plugin-snap \
gnome-software-plugin-fwupd
# 设置 flatpak 加速镜像源
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
# 将 WhiteSur 主题包连接到 Flatpak 仓库，可以解决部分应用无法使用 WhiteSur 主题问题，例如：Chrome、Edge
# xdg-data/themes 是 ~/.local/share/themes 的标准化路径别名（Flatpak 优先识别）
# :ro 表示只读权限，避免应用误修改主题文件。
sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
sudo flatpak override --filesystem=xdg-data/themes:ro
sudo flatpak override --filesystem=xdg-data/icons:ro
sudo flatpak override --filesystem=$HOME/.themes:ro
sudo flatpak override --filesystem=$HOME/.icons:ro

# 更新 Flatpak 应用、更新 Snap 应用
sudo flatpak update -y && sudo snap refresh
# apt list --installed | grep program_name
# 🏆 最佳实践，完美组合
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo flatpak update -y && sudo snap refresh


Launchpad 主页：https://launchpad.net/
包搜索：https://packages.ubuntu.com/
PPA 列表：https://launchpad.net/ubuntu/+ppas
特定 PPA：https://launchpad.net/~gnome-shell-extensions/+archive/ubuntu/ppa
1. GNOME Shell Extensions 官方 PPA
Launchpad 主页：https://launchpad.net/~gnome-shell-extensions/+archive/ubuntu/ppa
Extensions 包列表：https://launchpad.net/~gnome-shell-extensions/+archive/ubuntu/ppa/+packages
直接下载 URL：https://ppa.launchpadcontent.net/gnome-shell-extensions/ppa/ubuntu/pool/main/

# 查看所有启用的软件源，包括 PPA
apt policy
# 或过滤只显示 PPA
apt policy | grep -A2 -B2 ppa
# 查看特定包来自哪个 PPA
apt policy 包名


cd ~/下载
git clone https://gitee.com/lcqh2635/linux.git
git config --global user.name 'lcqh2635' 
git config --global user.email '2320391937@qq.com'

https://ubuntu.com/toolchains
sudo apt install -y \
default-jdk maven gradle \
nodejs npm \
podman podman-compose

sudo apt install -y \
postgresql postgresql-contrib \
mysql-server mysql-client \
redis-server
# sudo apt install -y default-jdk
# sudo apt install -y openjdk-21-jdk
# sudo apt install -y openjdk-25-jdk

snap install --help
# 列出所有已安装的 Snap
snap list
# 更新所有 Snap 包
sudo snap refresh
# 查看哪些 Snap 有更新
sudo snap refresh --list
# 安装 snap 软件包
sudo snap install adw-gtk3-theme qualia-gtk-theme icon-browser-adw gtk-theme-adw-gtk3
sudo snap install linsticky forecast resonance halftone cavasik mission-center
sudo snap install icon-theme-fluent gtk-theme-fluent vault
sudo snap install steam chromium telegram-desktop discord spotify
sudo snap install graalvm-jdk
sudo snap install --classic rustup go gradle
sudo snap install --classic intellij-idea webstorm rustrover goland pycharm datagrip clion code android-studio
snap find intellij-idea
snap find adw-gtk3
snap list intellij-idea

# 安装 build-essential（C/C++ 开发基础）
# 包含：gcc, g++, make, libc6-dev, dpkg-dev 等
sudo apt install -y \
build-essential \
git curl wget file net-tools \
libxdo-dev libssl-dev \
libwebkit2gtk-4.1-dev \
libayatana-appindicator3-dev \
librsvg2-dev

# https://geek-blogs.com/blog/linux-ubuntu-chrome/
sudo apt install -y wget apt-transport-https gnupg
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/google-chrome.gpg
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update -y && sudo apt install -y google-chrome-stable
# 彻底清除 google-chrome-stable 这个软件包及其所有的配置文件
# 它们的区别主要在于是否保留配置文件，sudo apt purge 会在 sudo apt remove 的基础上彻底清除所有配置文件
sudo apt purge -y google-chrome-stable

cd ~/下载 && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# 使用 apt 安装（自动解决依赖）
sudo apt install -y ./google-chrome-stable_current_amd64.deb
wget https://file-assets.apifox.com/download/Apifox-linux-deb-latest.zip

# apt list gnome-shell-extension*
# apt list gnome-shell-ubuntu-extensions*
sudo apt install -y \
gnome-shell-extension-user-theme \
gnome-shell-extension-alphabetical-grid \
gnome-shell-extension-apps-menu \
gnome-shell-extension-places-menu \
gnome-shell-extension-auto-move-windows \
gnome-shell-extension-drive-menu \
gnome-shell-extension-light-style \
gnome-shell-extension-workspace-indicator \
gnome-shell-extension-gsconnect \
gnome-shell-extension-gsconnect-browsers \
gnome-shell-extension-prefs


# Add to Desktop
# Applications Overview Tooltip
# App menu is back
# ArcMenu
# Battery Health Charging
# Bing Wallpape
# Bluetooth Battery Meter
# Blur my Shell
# Burn My Windows
# Caffeine
# CHC-E (Custom Hot Corners - Extended)
# Clipboard Indicator
# Compiz alike magic lamp effect
# Compiz windows effect
# Coverflow Alt-Tab
# ddterm
# Dash to Dock
# Debian Linux Update Indicator
# Disable Unredirect
# Do Not Disturb While Screen Sharing Or Recording
# Extension List
# Fly-Pie
# GNOME Fuzzy App Search
# gTile
# Gtk4 Desktop Icons NG (DING)
# Hide Top Bar
# In Picture
# Lock Keys
# Lunar Calendar 农历
# Night Theme Switcher
# Privacy Quick Settings
# Quick Settings Tweaks
# Rounded Corners
# Rounded Window Corners Reborn
# Screencast extra Feature
# Screen word translate
# Search Light
# Show Desktop Button
# Status Area Horizontal Spacing
# Top Bar Organizer
# User Avatar In Quick Settings
# Weather O'Clock
# Wifi QR Code


# 安装字体、图标、主题
sudo apt install -y \
adobe-source-han-sans-cn-fonts \
adobe-source-han-serif-cn-fonts \
jetbrains-mono-fonts
# 设置系统字体
# 设置 GNOME 桌面的默认界面字体，影响范围：应用程序菜单、按钮、标签、对话框等 UI 元素的字体
gsettings set org.gnome.desktop.interface font-name '思源黑体 CN Medium 12'
# 设置文档类内容的默认字体，影响范围：文本编辑器、帮助文档、网页内容（某些应用中）等以“文档”形式展示的内容
gsettings set org.gnome.desktop.interface document-font-name '思源宋体 CN Medium 12'
# 设置等宽字体，影响范围：终端、代码编辑器
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 12'
# 设置窗口标题栏字体，影响范围：所有应用程序窗口顶部的标题文字
gsettings set org.gnome.desktop.wm.preferences titlebar-font '思源黑体 CN Bold 12'

cd ~/下载
git clone https://gh-proxy.com/https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1
git clone https://gh-proxy.com/https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
git clone https://gh-proxy.com/https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
# 修改 Nautilus 侧边栏不透明度，参考 https://github.com/vinceliuice/WhiteSur-gtk-theme/issues/1127
# grep '$opacity: ' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss
sed -i 's/\$opacity: 0\.96/\$opacity: 1/g' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss

cd ~/下载/WhiteSur-cursors && ./install.sh
cd ~/下载/WhiteSur-icon-theme && ./install.sh
# Default is the normal dark theme
cd ~/下载/WhiteSur-gtk-theme && ./install.sh -l -o solid && ./tweaks.sh -f flat -F -o solid
# install light theme for libadwaita
cd ~/下载/WhiteSur-gtk-theme && ./install.sh -l -c light -o solid && ./tweaks.sh -f flat -F -o solid

gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
# 设置系统 GTK 主题
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-solid'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark-solid'

./install.sh -r && ./tweaks.sh -f -r && ./tweaks.sh -F -r

# 如果文件都在当前目录
cd ~/下载 && rm -rf WhiteSur-*
# 最简洁的方式
cd ~/下载 && rm -rf WhiteSur-{cursors,icon-theme,gtk-theme}
# 或指定特定前缀
cd ~/下载 && rm -rf WhiteSur-cursors WhiteSur-icon-theme WhiteSur-gtk-theme

flatpak -h
flatpak install -h
flatpak uninstall -h
# 更新已安装的应用程序或运行时
flatpak update
# 列出已安装的应用
flatpak list --app
# 卸载未使用的依赖
flatpak uninstall --unused -y
# flatpak search *theme*
# 为 Linux 上的 Flathub 提供支持的 Flatpak 应用商店
sudo flatpak install -y flathub io.github.kolunmi.Bazaar
# Flatseal 是一种图形工具，用于审查和修改 Flatpak 应用程序中的权限
sudo flatpak install -y flathub com.github.tchx84.Flatseal
sudo flatpak install -y flathub io.github.flattool.Warehouse
sudo flatpak install -y flathub io.github.giantpinkrobots.flatsweep
sudo flatpak install -y flathub io.github.realmazharhussain.GdmSettings
sudo flatpak install -y flathub io.gitlab.adhami3310.Impression
sudo flatpak install -y flathub de.haeckerfelix.Fragments
sudo flatpak install -y flathub org.gnome.Firmware
sudo flatpak install -y flathub org.gnome.baobab
sudo flatpak install -y flathub ca.desrt.dconf-editor
sudo flatpak install -y flathub fr.arnaudmichel.launcherstudio
sudo flatpak install -y io.github.shonubot.Spruce
sudo flatpak install -y flathub com.geekbench.Geekbench6
# 一款用 GTK4 编写的轻量级音乐播放器，专注于大型音乐收藏
sudo flatpak install -y flathub com.github.neithern.g4music
# 忘记忘记事情
sudo flatpak install -y flathub io.github.alainm23.planify
sudo flatpak install -y flathub org.gnome.gitlab.somas.Apostrophe
sudo flatpak install -y flathub md.obsidian.Obsidian
# 以最高质量播放曲目，使用发现混音或探索标签探索新曲目，或者只是享受你已知喜爱的收藏中的歌曲
sudo flatpak install -y flathub dev.dergs.Tonearm
sudo flatpak install -y flathub io.github.qier222.YesPlayMusic
sudo flatpak install -y flathub com.github.gmg137.netease-cloud-music-gtk
# 备份用最简单的方法。插上你的U盘，让Pika帮你完成剩下的
sudo flatpak install -y flathub org.gnome.World.PikaBackup
sudo flatpak install -y flathub com.github.marhkb.Pods
sudo flatpak install -y flathub org.mozilla.firefox
sudo flatpak install -y flathub com.google.Chrome
sudo flatpak install -y flathub com.microsoft.Edge
sudo flatpak install -y flathub com.brave.Browser
sudo flatpak install -y flathub com.usebottles.bottles
sudo flatpak install -y flathub org.gnome.Boxes
sudo flatpak install -y flathub com.ranfdev.DistroShelf
sudo flatpak install -y flathub io.github.dvlv.boxbuddyrs
sudo flatpak install -y flathub io.missioncenter.MissionCenter
sudo flatpak install -y flathub org.localsend.localsend_app
sudo flatpak install -y flathub it.mijorus.gearlever
sudo flatpak install -y flathub org.gnome.Evolution
sudo flatpak install -y flathub org.gnome.Extensions
sudo flatpak install -y flathub com.mattjakeman.ExtensionManager
sudo flatpak install -y flathub page.tesk.Refine
sudo flatpak install -y flathub io.github.seadve.Kooha
sudo flatpak install -y flathub re.sonny.Playhouse
sudo flatpak install -y flathub me.iepure.devtoolbox
sudo flatpak install -y flathub re.sonny.Workbench
sudo flatpak install -y flathub io.github.debasish_patra_1987.linuxthemestore
sudo flatpak install -y flathub com.github.cassidyjames.dippi
sudo flatpak install -y flathub io.github.zarestia_dev.rclone-manager
sudo flatpak install -y flathub io.github.zaedus.spider
sudo flatpak install -y flathub com.github.emmanueltouzery.projectpad
sudo flatpak install -y flathub me.spaceinbox.actioneer
sudo flatpak install -y flathub io.github.jeffshee.Hidamari
sudo flatpak install -y flathub info.febvre.Komikku
sudo flatpak install -y flathub dev.skynomads.Seabird
sudo flatpak install -y flathub app.drey.Dialect
sudo flatpak install -y flathub xyz.ketok.Speedtest
sudo flatpak install -y flathub org.gnome.FileRoller
sudo flatpak install -y flathub com.her01n.BatteryInfo
sudo flatpak install -y flathub io.github.swordpuffin.rewaita
sudo flatpak install -y flathub io.github.swordpuffin.wardrobe
sudo flatpak install -y flathub io.github.radiolamp.mangojuice
sudo flatpak install -y flathub io.github.sitraorg.sitra
sudo flatpak install -y flathub io.github.getnf.embellish
sudo flatpak install -y flathub io.gitlab.theevilskeleton.Upscaler
sudo flatpak install -y flathub io.github.davidoc26.wallpaper_selector
sudo flatpak install -y flathub io.github.tobagin.keysmith
sudo flatpak install -y flathub io.github.fastrizwaan.WineCharm
sudo flatpak install -y flathub dev.mufeed.Wordbook
sudo flatpak install -y flathub com.belmoussaoui.Authenticator
sudo flatpak install -y flathub io.github.plrigaux.sysd-manager
sudo flatpak install -y flathub moe.launcher.an-anime-game-launcher
sudo flatpak install -y flathub org.gabmus.whatip
sudo flatpak install -y flathub org.gabmus.hydrapaper
sudo flatpak install -y flathub io.github.amit9838.mousam
sudo flatpak install -y flathub com.github.PintaProject.Pinta
sudo flatpak install -y flathub io.github.vikdevelop.SaveDesktop
sudo flatpak install -y flathub org.pvermeer.WebAppHub
sudo flatpak install -y flathub io.github.qwersyk.Newelle
sudo flatpak install -y flathub io.github.ronniedroid.concessio
sudo flatpak install -y flathub com.bitwarden.desktop
sudo flatpak install -y flathub com.calibre_ebook.calibre
sudo flatpak install -y flathub org.gnome.Builder
sudo flatpak install -y flathub org.gnome.dspy
sudo flatpak install -y flathub io.github.mightycreak.Diffuse
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
sudo flatpak install -y flathub com.stremio.Stremio
sudo flatpak install -y flathub org.mozilla.vpn

sudo flatpak install -y flathub org.vinegarhq.Sober
sudo flatpak install -y flathub com.heroicgameslauncher.hgl
sudo flatpak install -y flathub com.vysp3r.ProtonPlus
sudo flatpak install -y flathub com.valvesoftware.Steam

# Discord 是一个免费的一体化消息、语音和视频客户端，可以在你的电脑和手机上使用
sudo flatpak install -y flathub com.discordapp.Discord
sudo flatpak install -y flathub org.telegram.desktop

sudo flatpak install -y flathub org.onlyoffice.desktopeditors
sudo flatpak install -y flathub com.rustdesk.RustDesk
sudo flatpak install -y flathub org.flameshot.Flameshot

sudo flatpak install -y flathub io.httpie.Httpie
sudo flatpak install -y flathub es.danirod.Cartero
sudo flatpak install -y flathub com.apifox.Apifox
sudo flatpak install -y flathub com.usebruno.Bruno
sudo flatpak install -y flathub rest.insomnia.Insomnia

sudo flatpak install -y flathub com.tencent.WeChat
sudo flatpak install -y flathub com.qq.QQ





    
