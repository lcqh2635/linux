#!/bin/bash

# Fedora GNOME 42 初始化优化配置脚本
# 功能：自动安装并配置加速镜像、工具、依赖包
# 使用方法：chmod +x software.sh && ./software.sh

# 更新系统并升级所有已安装的包
echo "开始更新系统并升级所有已安装的包..."
sudo dnf update -y && sudo dnf upgrade -y
echo "系统更新、升级完成..."

# 安装一些常用的Flatpak应用（如VSCode, LibreOffice）
echo "安装基础Flatpak应用程序..."
flatpak install -y flathub \
app.drey.Dialect \
com.bitwarden.desktop \
com.github.gmg137.netease-cloud-music-gtk \
com.github.marhkb.Pods \
io.podman_desktop.PodmanDesktop \
com.github.neithern.g4music \
com.github.tchx84.Flatseal \
com.mattjakeman.ExtensionManager \
de.haeckerfelix.Fragments \
io.github.alainm23.planify \
io.github.flattool.Warehouse \
io.github.realmazharhussain.GdmSettings \
io.github.seadve.Kooha \
io.github.vikdevelop.SaveDesktop \
io.gitlab.adhami3310.Impression \
io.typora.Typora \
it.mijorus.gearlever \
md.obsidian.Obsidian \
me.iepure.devtoolbox \
net.nokyan.Resources \
org.gnome.Builder \
org.gnome.Firmware \
org.gnome.Gtranslator \
org.gnome.World.PikaBackup \
org.gnome.gitlab.somas.Apostrophe \
re.sonny.Playhouse \
re.sonny.Workbench \
org.gnome.gitlab.somas.Apostrophe \
org.gnome.seahorse.Application \
io.github.nokse22.inspector \
com.usebottles.bottles \
page.tesk.Refine


flatpak install flathub org.gnome.Polari
flatpak install flathub app.drey.Damask
flatpak install flathub page.codeberg.libre_menu_editor.LibreMenuEditor
flatpak install flathub io.gitlab.gwendalj.package-transporter
# https://www.appimagehub.com
flatpak install flathub io.github.prateekmedia.appimagepool
flatpak install flathub org.dupot.easyflatpak
flatpak install flathub io.github.swordpuffin.wardrobe
flatpak install flathub com.apifox.Apifox
flatpak install flathub com.github.KRTirtho.Spotube
flatpak install flathub com.jeffser.Alpaca
flatpak install flathub io.missioncenter.MissionCenter
flatpak install flathub org.flameshot.Flameshot
flatpak install flathub com.dingtalk.DingTalk


https://github.com/quick123official/quick_redis_blog/releases
https://www.appimagehub.com/p/2292484


# 工作娱乐
flatpak install -y flathub \
com.qq.QQ \
com.tencent.WeChat \
com.tencent.wemeet \
io.github.qier222.YesPlayMusic \
com.baidu.NetDisk \
com.spotify.Client \
com.discordapp.Discord \
com.usebottles.bottles \
com.microsoft.Edge \
com.google.Chrome \
com.obsproject.Studio \
com.visualstudio.code \
org.libreoffice.LibreOffice \
com.protonvpn.www \
com.rustdesk.RustDesk

cn.apipost.apipost
ca.desrt.dconf-editor
flatpak list --app
flatpak list --user  # 查看用户级安装的应用
flatpak list --system  # 查看系统级安装的应用
flatpak search  org.gtk.Gtk3theme

org.gtk.Gtk3theme.Adwaita-dark
sudo flatpak install -y flathub \
org.gtk.Gtk3theme.Adwaita-dark \
org.gtk.Gtk3theme.Mojave-light \
org.gtk.Gtk3theme.adw-gtk3 \
org.gtk.Gtk3theme.adw-gtk3-dark


sudo dnf install -y tabby-terminal

# 游戏
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub io.github.Foldex.AdwSteamGtk -y

# 定期运行 flatpak uninstall --unused 删除旧版本运行时。
flatpak uninstall --unused -y

# 进入到下载目录
cd ~/下载

# 下载 jetbrains-toolbox 应用
echo "准备开始安装jetbrains-toolbox应用..."
if [ ! -d "WhiteSur-wallpapers" ]; then
    echo "正在安装WhiteSur壁纸..."
    # git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
    git clone https://gitee.com/llf2635/linux.git --depth=1
    cd linux
    sudo dnf install -y unzip
    unzip jetbra.zip
    mv jetbra ~/.jetbra
    wget "https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.6.2.41321.tar.gz"
    tar -xzf jetbrains-toolbox-2.6.2.41321.tar.gz
    cd jetbrains-toolbox-2.6.2.41321
    ./jetbrains-toolbox
    cd ..
    rm -rf jetbrains-toolbox-2.6.2.41321 jetbrains-toolbox-2.6.2.41321.tar.gz
fi

# 下载 jetbrains-toolbox
https://www.jetbrains.com/zh-cn/toolbox-app/download/download-thanks.html?platform=linux
https://github.com/Eugeny/tabby/releases/download/v1.0.223/tabby-1.0.223-linux-x64.rpm
# https://gitcode.com/gh_mirrors/ta/tabby
# 参考 https://packagecloud.io/eugeny/tabby/install#bash-rpm
curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.rpm.sh | sudo bash
https://github.com/oldj/SwitchHosts/releases/download/v4.2.0-beta/SwitchHosts_linux_x86_64_4.2.0.6105.AppImage
curl -sSL https://steampp.net/Install/Linux.sh | bash
/home/lcqh/.WattToolkit
curl -sSL https://steampp.net/Install/Linux.sh | INSTALL_DIR="$HOME/.watt-toolkit" bash

# 转换后的包可能因依赖问题无法运行（尤其是依赖 glibc 版本不同的软件）。
# 使用 alien 工具转换 .deb 为 .rpm（推荐）
sudo dnf install -y alien rpm-build
# 将 .deb 转换为 .rpm
sudo alien -r --scripts Apipost_linux_x64_8.1.14.deb  # 保留安装脚本（-r 生成 RPM，--scripts 保留脚本）
sudo alien --to-rpm Apipost_linux_x64_8.1.14.deb
# 安装生成的 .rpm 文件
sudo dnf install package-version.Apipost_linux_x64_8.1.14.rpm

# libadwaita-demos
# https://ftp5.gwdg.de/pub/linux/archlinux/extra/os/x86_64/libadwaita-demos-1:1.7.4-1-x86_64.pkg.tar.zst

# 清理临时文件
echo "正在清理临时文件..."
dnf clean all

echo "主题美化完成！请注销或重启系统以查看全部更改效果。"
echo "您可以使用GNOME Tweaks工具进一步自定义外观。"



flatpak install flathub app.zen_browser.zen -y
flatpak install flathub org.videolan.VLC -y
# 办公软件
flatpak install flathub org.libreoffice.LibreOffice -y
# 快捷、安全的文件传输工具
flatpak install flathub app.drey.Warp -y
# 下载、使用且能自适应的 GTK 应用程序字体
flatpak install flathub org.gustavoperedo.FontDownloader -y
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
