# 窗口按钮布局
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
# 居中显示新建窗口
gsettings set org.gnome.mutter center-new-windows true
# 显示电量百分比
gsettings set org.gnome.desktop.interface show-battery-percentage true


# 自动自带的系统扩展移除办法
nautilus admin:/usr/share/gnome-shell/extensions
yay -Rcns xxx
# 用户扩展目录
nautilus ~/.local/share/gnome-shell/extensions
cd ~/.local/share/gnome-shell/extensions

# 查询系统中已安装的以 gnome-shell-extension 为前缀的软件包或扩展
pacman -Q | grep '^gnome-shell-extension'
yay -Q | grep '^gnome-shell-extension'
# 查看所有启用的扩展
gnome-extensions list

# 安装 Gnome 扩展，通过 yay 安装的扩展将作为系统扩展而不是用户扩展，系统扩展可以使用 gsettings 命令来操作插件，而用户插件则不行
# 推荐所有 extra 官方仓库的扩展通过命令安装，而 aur 社区仓库的扩展通过 extension manager 软件安装
pacman -Ss gnome-shell-extension
# 安装系统扩展包集合，该集合中的扩展包无法单个删除
yay -S gnome-shell-extensions
extra/gnome-shell-extensions
extra/gnome-shell-extension-dash-to-dock
extra/gnome-shell-extension-caffeine
extra/gnome-shell-extension-vitals
extra/gnome-shell-extension-gtk4-desktop-icons-ng
# 移除不要的系统扩展
yay -Rcns gnome-shell-extension-x11gestures gnome-shell-extension-legacy-theme-auto-switcher
aur/gnome-shell-extension-unite

Alphabetical App Grid
Bing Wallpaper
Bluetooth Quick Connect
Blur my Shell
aur/gnome-shell-extension-blur-my-shell
# 点击标题栏中的铅笔形状的编辑按钮，将 Animaion Type 的值从 Any 改为 Closing Windows 这样就可以关闭窗口打开时的动画效果
Burn My Windows
aur/gnome-shell-extension-burn-my-windows
Clipboard Indicator
Coverflow Alt-Tab
Compiz alike magic lamp effect
Compiz windows effect
Dash2Dock Animated
ddterm
Disconnect Wifi
Hide Top Bar
IBus Tweaker
Just Perfection
Night Theme Switcher
Notification Banner Reloaded
Quick Settings Tweaks
Rounded Corners
Rounded Window Corners Reborn
Search Light
SettingsCenter
Top Bar Organizer
Tray Icons: Reloaded
User Avatar In Quick Settings
Wifi QR Code
Window Gestures

logout

# 通过 yay 安装的扩展将作为系统扩展而不是用户扩展，系统扩展才拥有 Schema 可以使用 gsettings 命令来操作插件，而用户插件则不行
# 列出所有已安装的 Schema
gsettings list-schemas
# 列出某个 Schema 下的所有键
gsettings list-keys org.gnome.desktop.interface
# 查看键的取值类型和描述
gsettings describe org.gnome.desktop.interface font-name
# 递归列出某个 Schema 的键值（例如 org.gnome.desktop.interface）
gsettings list-recursively org.gnome.desktop.interface

sudo pacman -S --noconfirm gnome-shell-extension-dash-to-dock
gsettings list-recursively org.gnome.shell.extensions.dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.5
gsettings set org.gnome.shell.extensions.dash-to-dock height-fraction 0.9
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash true
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DASHES'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(154,153,150)'
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'

yay -S --noconfirm gnome-shell-extension-blur-my-shell
gsettings list-recursively org.gnome.shell.extensions.blur-my-shell
gsettings set org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1

yay -S --noconfirm gnome-shell-extension-hidetopbar
gsettings list-recursively org.gnome.shell.extensions.hidetopbar
gsettings set org.gnome.shell.extensions.hidetopbar mouse-sensitive true
gsettings set org.gnome.shell.extensions.hidetopbar mouse-sensitive-fullscreen-window true
gsettings set org.gnome.shell.extensions.hidetopbar show-in-overview true
gsettings set org.gnome.shell.extensions.hidetopbar hot-corner false
gsettings set org.gnome.shell.extensions.hidetopbar mouse-triggers-overview false
gsettings set org.gnome.shell.extensions.hidetopbar keep-round-corners false
gsettings set org.gnome.shell.extensions.hidetopbar pressure-threshold 500
gsettings set org.gnome.shell.extensions.hidetopbar pressure-timeout 500
gsettings set org.gnome.shell.extensions.hidetopbar animation-time-autohide 0.5
gsettings set org.gnome.shell.extensions.hidetopbar animation-time-overview 0.5
gsettings set org.gnome.shell.extensions.hidetopbar shortcut-keybind ['<Alt>p']
gsettings set org.gnome.shell.extensions.hidetopbar shortcut-delay 3.0
gsettings set org.gnome.shell.extensions.hidetopbar shortcut-toggles true
gsettings set org.gnome.shell.extensions.hidetopbar enable-intellihide false
gsettings set org.gnome.shell.extensions.hidetopbar enable-active-window false

yay -S --noconfirm gnome-shell-extension-gtk4-desktop-icons-ng
gsettings list-recursively org.gnome.shell.extensions.gtk4-ding
org.gnome.shell.extensions.gtk4-ding show-home true
org.gnome.shell.extensions.gtk4-ding show-trash false
Gnome 环境安装常用软件

yay -S --noconfirm gnome-shell-extension-burn-my-windows
gsettings list-recursively org.gnome.shell.extensions.burn-my-windows


# 参考官方解决方案  https://github.com/vinceliuice/WhiteSur-gtk-theme/issues/1059
# Night Theme Switcher 扩展插件配置
# 白天执行命令
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'
gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(154,153,150)'
gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
gsettings set org.gnome.shell.extensions.blur-my-shell.overview style-components 1
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
ln -fs $HOME/.config/gtk-4.0/gtk-Light.css $HOME/.config/gtk-4.0/gtk.css

# 夜晚执行命令
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark'
gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(119,118,123)'
gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 2
gsettings set org.gnome.shell.extensions.blur-my-shell.overview style-components 2
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 3
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 2
ln -fs $HOME/.config/gtk-4.0/gtk-Dark.css $HOME/.config/gtk-4.0/gtk.css


# 字体设置
# 安装思源黑体（简体中文）
sudo pacman -S adobe-source-han-sans-cn-fonts
# 安装思源宋体（简体中文）
sudo pacman -S adobe-source-han-serif-cn-fonts
# 安装 JetBrains Mono 等款字体
sudo pacman -S ttf-jetbrains-mono
# 安装完字体后需要登出才能生效
logout
# 设置界面字体（Inter 或 Noto Sans，字号建议 11-12）（简体中文优先）
gsettings set org.gnome.desktop.interface font-name '思源黑体 CN Medium 12'
# 设置文档字体（Noto Serif，字号建议 12）
gsettings set org.gnome.desktop.interface document-font-name '思源宋体 CN Medium 12'
# 设置等宽字体（编程/终端）（JetBrains Mono，字号建议 13-14）专为开发者设计，连字特性优秀
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 13'
# 设置窗口标题字体（加粗 Inter，字号稍大）
gsettings set org.gnome.desktop.wm.preferences titlebar-font '思源黑体 CN Bold 12'
gsettings get org.gnome.desktop.wm.preferences titlebar-font

# 抗锯齿与渲染
# 启用抗锯齿（推荐 subpixel RGB 次像素渲染）
# 为 LCD 屏幕启用次像素渲染（RGB 顺序）
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
# 为 OLED 屏幕使用灰度抗锯齿
gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
# 微调模式（slight 平衡清晰度与渲染速度）
gsettings set org.gnome.desktop.interface font-hinting 'slight'
# 禁用字体缩放（依赖全局缩放比例，见下文）
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0

# 高分屏适配优化，全局缩放比例。对于 16 英寸 2.5K（2560x1600），推荐缩放比例：125% (1.25x) 平衡空间利用和可读性。
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
通过 GNOME 设置 → 显示器/缩放，直接选择 125%

gsettings get org.gnome.desktop.wm.preferences button-layout
gsettings list-keys org.gnome.mutter
gsettings list-recursively org.gnome.mutter
gsettings list-recursively org.gnome.desktop.interface
gsettings list-recursively org.gnome.desktop.wm.preferences


# 查看当前BIOS信息，
sudo dmidecode -t bios
# 使用 -s 参数查看 bios 的某一项信息
# 查看 bios 版本
sudo dmidecode -s bios-version

# fwupd 是一个开源的 固件更新工具，专为 Linux 系统设计，由 GNOME 开发者 Richard Hughes 主导开发。
# 它的核心目标是简化硬件固件的升级流程，让用户无需依赖 Windows 或厂商专用工具，直接在 Linux 环境下安全更新设备固件。
# 并非所有设备都支持 fwupd，需在 LVFS 官网 https://fwupd.org/lvfs/vendors/ 查询具体型号。
# 进入 LVFS 设备列表，搜索你的笔记本型号（如 MECHREVO Code01 Ver2.0）。若厂商未在此列出，则 fwupd 无法直接更新。
# 在 fwupd 中，搜索和匹配固件更新的依据是电脑厂商（如 Dell、Lenovo、HP 等），而不是 BIOS 供应商（如 Insyde、Phoenix、AMI 等）。
# 机械革命暂未加入 LVFS 合作厂商列表，因此 fwupd 无法直接更新其 BIOS。
# 安装（Manjaro/Arch）
sudo pacman -S fwupd
# 刷新固件数据库
sudo fwupdmgr refresh
# 检查可用更新，列出所有支持固件升级的设备
sudo fwupdmgr get-updates
# 执行更新（需确认）
sudo fwupdmgr update
# 查看固件更新历史记录
sudo fwupdmgr get-history

# 调整AMD CPU核显的显存，可以解决笔记本风扇经常高速转动导致的机身发热和噪音
重启开机快按Esc进入BIOS，选到第5个Setup Utility，进入后选第4个AMD CBS，来到右侧的NBIO Common Options，
再进入第1个GFX Configuration，进入后看到UMA Frame buffer Size。
默认情况它设置的是1G，我们按右方向键修改为最大的4G。 按F10保存并退出，重启后专用GPU内存变为4G了，常规内存为27G。
