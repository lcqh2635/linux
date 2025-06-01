#!/bin/bash

# Fedora GNOME 42 主题美化脚本
# 功能：自动安装并配置常用主题、图标、光标和扩展
# 使用方法：chmod +x beautify.sh && ./beautify.sh

# gsettings 修改的是当前用户的 GNOME 配置，必须由 桌面用户（而非 root）执行。如果脚本通过 sudo 运行，命令会被忽略。
# 设置窗口按钮位置 (右)
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
# 设置新窗口居中显示
gsettings set org.gnome.mutter center-new-windows true
# 设置电量百分比
gsettings set org.gnome.desktop.interface show-battery-percentage true

# 更新系统并升级所有已安装的包
echo "开始更新系统并升级所有已安装的包..."
sudo dnf update -y && sudo dnf upgrade -y

# 安装必要依赖
echo "正在安装图形界面优化工具..."
# 图形界面工具: gnome-tweaks, gnome-extensions-app
sudo dnf install -y gnome-tweaks gnome-extensions-app
flatpak install -y flathub com.mattjakeman.ExtensionManager

# 安装常用GNOME扩展
# dnf list gnome-shell-extension*
echo "正在安装常用GNOME扩展..."
sudo dnf install -y \
gnome-shell-extension-user-theme \
gnome-shell-extension-dash-to-dock \
gnome-shell-extension-blur-my-shell \
gnome-shell-extension-just-perfection \
gnome-shell-extension-drive-menu \
gnome-shell-extension-appindicator \
gnome-shell-extension-forge \
gnome-shell-extension-caffeine \
gnome-shell-extension-gsconnect \
gnome-shell-extension-workspace-indicator \
gnome-shell-extension-auto-move-windows \
gnome-shell-extension-no-overview \
gnome-shell-extension-netspeed

# 启用已安装的扩展
# gnome-extensions list
echo "启用已安装的扩展..."
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable blur-my-shell@aunetx
gnome-extensions enable just-perfection-desktop@just-perfection
gnome-extensions enable drive-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable caffeine@patapon.info
gnome-extensions enable gsconnect@andyholmes.github.io
gnome-extensions enable workspace-indicator@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable auto-move-windows@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable no-overview@fthx
gnome-extensions enable netspeed@hedayaty.gmail.com

# 配置 Dash to Dock (自定义Dock栏)
echo "正在配置Dash to Dock..."
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.5
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DASHES'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true

# 配置 Blur My Shell (透明模糊效果)
echo "正在配置Blur My Shell..."
# 恢复默认设置 gsettings reset-recursively org.gnome.shell.extensions.blur-my-shell
gsettings set org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
gsettings set org.gnome.shell.extensions.blur-my-shell.applications blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.applications dynamic-opacity false
gsettings set org.gnome.shell.extensions.blur-my-shell.applications whitelist "['org.gnome.Nautilus', 'org.gnome.Settings', 'org.gnome.Software', 'org.gnome.TextEditor', 'org.gnome.Ptyxis', 'org.gnome.SystemMonitor', 'org.gnome.tweaks', 'org.gnome.Extensions', 'org.gnome.Shell.Extensions', 'com.mattjakeman.ExtensionManager', 'com.github.tchx84.Flatseal']"
gsettings set org.gnome.shell.extensions.blur-my-shell.coverflow-alt-tab blur false

# Just Perfection（微调 GNOME Shell 的细节，隐藏冗余元素、调整动画速度等）
echo "正在配置Just Perfection..."
gsettings set org.gnome.shell.extensions.just-perfection accessibility-menu false
gsettings set org.gnome.shell.extensions.just-perfection world-clock false
gsettings set org.gnome.shell.extensions.just-perfection weather false
gsettings set org.gnome.shell.extensions.just-perfection events-button false
gsettings set org.gnome.shell.extensions.just-perfection window-demands-attention-focus true
gsettings set org.gnome.shell.extensions.just-perfection startup-status 0

# auto-move-windows
echo "正在配置auto-move-windows..."
# gsettings list-recursively org.gnome.shell.extensions.auto-move-windows
gsettings set org.gnome.shell.extensions.auto-move-windows application-list "['com.github.gmg137.netease-cloud-music-gtk.desktop:1', 'jetbrains-idea-1e43afa8-7b74-4314-97e3-6dc2fcd19338.desktop:2']"

# 进入到下载目录
cd ~/下载

# 安装 WhiteSur 壁纸
echo "准备开始安装WhiteSur-wallpapers壁纸..."
if [ ! -d "WhiteSur-wallpapers" ]; then
    echo "正在安装WhiteSur壁纸..."
    # git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
    git clone https://gitcode.com/gh_mirrors/wh/WhiteSur-wallpapers.git --depth=1
    cd WhiteSur-wallpapers
    # 安装静态壁纸
    ./install-wallpapers.sh
    # 安装随时间变化的动态壁纸
    sudo ./install-gnome-backgrounds.sh
    # gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/WhiteSur/WhiteSur-timed.xml'
    gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Ventura/Ventura-timed.xml'
    cd ..
    rm -rf WhiteSur-wallpapers
fi
# ls ~/.local/share/backgrounds
# ls /usr/share/backgrounds

# 安装 WhiteSur 光标主题
echo "准备开始安装WhiteSur-cursors光标主题..."
sudo dnf install -y la-capitaine-cursor-theme
# 安装WhiteSur光标
if [ ! -d "WhiteSur-cursors" ]; then
    echo "正在安装WhiteSur光标..."
    # git clone https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1
    git clone https://gitcode.com/gh_mirrors/wh/WhiteSur-cursors.git --depth=1
    cd WhiteSur-cursors
    ./install.sh
    cd ..
    rm -rf WhiteSur-cursors
fi

# 下载并安装 WhiteSur 图标主题
echo "准备开始安装WhiteSur-icon-theme图标主题..."
# 安装WhiteSur图标主题 (macOS风格)
if [ ! -d "WhiteSur-icon-theme" ]; then
    echo "正在安装WhiteSur图标主题..."
    # git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
    git clone https://gitcode.com/gh_mirrors/wh/WhiteSur-icon-theme.git --depth=1
    cd WhiteSur-icon-theme
    ./install.sh
    cd ..
    rm -rf WhiteSur-icon-theme
fi

# 下载并安装主题
echo "准备开始安装WhiteSur-gtk-theme应用主题..."
sudo dnf install -y adw-gtk3-theme
# https://github.com/FedoraQt
# https://packages.fedoraproject.org/pkgs/qadwaitadecorations/
# https://discussion.fedoraproject.org/t/qt-app-theme-in-gnome/102649
# https://pkgs.org/search/?q=QGnomePlatform
# https://pkgs.org/search/?q=Qadwaitadecorations
sudo dnf install -y \
qgnomeplatform-qt5 \
qgnomeplatform-qt6 \
qadwaitadecorations-qt5 \
qadwaitadecorations-qt6
# 安装WhiteSur主题 (macOS风格)
if [ ! -d "WhiteSur-gtk-theme" ]; then   # 检查目录是否存在
    echo "正在安装WhiteSur GTK主题..."
    # git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
    git clone https://gitcode.com/gh_mirrors/wh/WhiteSur-gtk-theme.git --depth=1
    cd WhiteSur-gtk-theme
    # 安装 GTK 主题
    ./install.sh
    # ./install.sh -l --shell -i fedora --round
    ./install.sh -l -c light --shell -i fedora --round
    # 安装 Firefox 主题
    firefox & sleep 1 && pkill firefox	# 初始化 firefox 配置
    ./tweaks.sh -f flat
    # 安装 GDM 主题
    # 修改文件权限
    # chmod 644 /home/lcqh/.local/share/backgrounds/Ventura-light.jpg
    sudo ./tweaks.sh -g -b '/home/lcqh/.local/share/backgrounds/Ventura-light.jpg'
    # 将 WhiteSur 主题包连接到 Flatpak 仓库，可以解决部分应用无法使用 WhiteSur 主题问题，例如：Chrome、Edge
    sudo ./tweaks.sh -F
    # 修复 Dash to Dock 主题的问题  ./tweaks.sh -d -r
    # ./tweaks.sh -d
    cd ..
    rm -rf WhiteSur-gtk-theme
fi

# 授予全局访问 GTK 配置和主题文件的权限
# 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-3.0 目录。该目录包含 GTK 3 的配置文件（如主题、图标、字体设置等）。
# 系统主题（/usr/share/themes）需 sudo 配置，影响所有用户。
# 用户主题（~/.themes）需用 --user 参数，仅限当前用户。建议统一使用 sudo
# 允许Flatpak应用读取主题和配置,共享 GTK3/GTK4 设置
# 同步 GTK3 配置（主题/字体/缩放）
sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
# 同步 GTK4 配置（Libadwaita 应用）
sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
# 仅当前用户生效（推荐）
# xdg-data/themes 是 ~/.local/share/themes 的标准化路径别名（Flatpak 优先识别）
# :ro 表示只读权限，避免应用误修改主题文件。
sudo flatpak override --filesystem=xdg-data/themes:ro
sudo flatpak override --filesystem=xdg-data/icons:ro
sudo flatpak override --filesystem=$HOME/.themes:ro
sudo flatpak override --filesystem=$HOME/.icons:ro
# 共享系统GTK主题文件
sudo flatpak override --filesystem=/usr/share/themes:ro
# 共享系统图标主题文件
sudo flatpak override --filesystem=/usr/share/icons:ro
# sudo flatpak override --help
# sudo flatpak override --reset
# sudo flatpak override --show
# sudo flatpak override --system --show
# flatpak override --user --show
# flatpak override --user --reset


# 应用主题设置
echo "正在应用主题设置..."
# 设置光标主题
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'
# 设置图标主题
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur'
# 设置Shell主题
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
# 设置GTK主题
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'

# 安装字体
echo "正在安装额外字体..."
sudo dnf install -y \
adobe-source-han-sans-cn-fonts \
adobe-source-han-serif-cn-fonts \
jetbrains-mono-fonts
# 设置系统字体
gsettings set org.gnome.desktop.interface font-name '思源黑体 CN Medium 12'
gsettings set org.gnome.desktop.interface document-font-name '思源宋体 CN Medium 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font '思源黑体 CN Bold 12'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'slight'

# 清理临时文件
echo "正在清理临时文件..."
dnf clean all

echo "主题美化完成！请注销或重启系统以查看全部更改效果。"
echo "您可以使用GNOME Tweaks工具进一步自定义外观。"



