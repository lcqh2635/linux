#!/bin/bash

# 更新系统并升级所有已安装的包
echo "开始系统..."
sudo dnf update -y && sudo dnf upgrade -y

Logo Menu
Alphabetical App Grid
# 用户比装 Gnome 扩展
Hide Top Bar
# 修复 Hide Top Bar 闪跳 BUG
Disable unredirect
Rounded Corners
Rounded Window Corners Reborn
Coverflow Alt-Tab
User Avatar In Quick Settings
# 数值设置为 5
Status Area Horizontal Spacing
No overview at start-up
Show Desktop Button
Impatience
App menu is back
IBus Tweaker
# 右键点击 panel 上的输入法，点击“首选项”，将“候选词排列方向”改为竖直


# 优质推荐 Gnome 扩展
Add to Desktop
Bluetooth Quick Connect
Clipboard Indicator
Compiz windows effect
Compiz alike magic lamp effect
Desktop Cube
# Open Bar
# Dash2Dock Animated
# Extension List
Gtk4 Desktop Icons NG (DING)
# 安装 Lunar Calendar 农历 扩展插件需要如下内容
#https://gitlab.gnome.org/Nei/ChineseCalendar/-/archive/20250205/ChineseCalendar-20250205.tar.gz
# tar -xzvf ChineseCalendar-20250205.tar.gz
# cd ChineseCalendar-20250205
# ./install.sh
Lunar Calendar 农历
IBus Tweaker
Night Theme Switcher
Notification Banner Reloaded
Quick Settings Tweaks
Search Light
SettingsCenter
Top Bar Organizer
# Tray Icons: Reloaded
Quick Settings Audio Panel
Fedora Linux Update Indicator
Window Gestures
VirtualBox applet
# https://github.com/Sominemo/Fildem-Gnome-45
App menu is back
Custom Window Controls
# https://extensions.gnome.org/extension/6300/custom-window-controls/
# https://github.com/icedman/custom-window-controls
Custom Command Toggle
Color Picker
Show Desktop Button
Bluetooth Battery Meter


# 解决用户 Gnome 扩展无法使用 gsettings 的问题
for EXT_DIR in ~/.local/share/gnome-shell/extensions/*/; do
    EXT_ID=$(basename "$EXT_DIR")
    echo "处理扩展: $EXT_ID"

    if [ -d "$EXT_DIR/schemas" ]; then
        glib-compile-schemas "$EXT_DIR/schemas"

        mkdir -p ~/.local/share/glib-2.0/schemas/
        cp "$EXT_DIR/schemas"/*.xml ~/.local/share/glib-2.0/schemas/
    fi
done

glib-compile-schemas ~/.local/share/glib-2.0/schemas/


# 系统外观主题和Gnome扩展插件优化
# 在 Github 发现一个好项目 adw-gtk3	https://github.com/lassekongo83/adw-gtk3
sudo dnf install -y adw-gtk3-theme la-capitaine-cursor-theme
# 系统外观优化
gsettings set org.gnome.desktop.interface color-scheme 'default'
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.shell.extensions.user-theme name 'Adwaita'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
# dash-to-dock 扩展优化
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DASHES'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
# blur-my-shell 扩展优化
gsettings set org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
gsettings set org.gnome.shell.extensions.blur-my-shell.applications blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.applications dynamic-opacity false
gsettings set org.gnome.shell.extensions.blur-my-shell.applications whitelist ['org.gnome.Settings', 'org.gnome.Software', 'org.gnome.TextEditor', 'org.gnome.SystemMonitor', 'org.gnome.tweaks', 'org.gnome.Extensions', 'org.gnome.Shell.Extensions', 'com.mattjakeman.ExtensionManager', 'org.gnome.Builder', 'org.gnome.Loupe', 'org.gnome.gitlab.somas.Apostrophe', 'io.github.alainm23.planify', 'com.github.tchx84.Flatseal', 'io.github.flattool.Warehouse']
gsettings set org.gnome.shell.extensions.blur-my-shell.coverflow-alt-tab blur false
# just-perfection 扩展优化
gsettings set org.gnome.shell.extensions.just-perfection accessibility-menu false
gsettings set org.gnome.shell.extensions.just-perfection world-clock false
gsettings set org.gnome.shell.extensions.just-perfection weather false
gsettings set org.gnome.shell.extensions.just-perfection events-button false
gsettings set org.gnome.shell.extensions.just-perfection window-demands-attention-focus true
gsettings set org.gnome.shell.extensions.just-perfection startup-status 0


# 自定义快捷键优化，Super-管理窗口、Alt-管理工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Alt>End']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Alt>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>3']"
# 当前工作区内的窗口切换
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>T']"
# 窗口在工作区移动
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "['<Alt><Super>End']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Alt><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Alt><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Alt><Super>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Alt><Super>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Alt><Super>3']"
# 隐藏/显示当前工作区的所有窗口
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Alt><Super>h']"
# 键盘 F 功能键
# gsettings list-recursively org.gnome.settings-daemon.plugins.media-keys
# 媒体声音控制
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute "['F2']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['F3']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['F4']"
# 弹出 U 盘
gsettings set org.gnome.settings-daemon.plugins.media-keys eject "['F5']"
# 播放器控制
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['F8']"
gsettings set org.gnome.settings-daemon.plugins.media-keys play "['F9']"
gsettings set org.gnome.settings-daemon.plugins.media-keys previous "['F10']"



# 清理无用的包和缓存
echo "清理未使用的软件包和缓存..."
sudo dnf autoremove -y
sudo dnf clean all

echo "系统配置成功完成!"
