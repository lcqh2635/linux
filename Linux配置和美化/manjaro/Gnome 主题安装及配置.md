# 安装系统主题
yay -S whitesur-gtk-theme whitesur-icon-theme whitesur-cursor-theme
# WhiteSur GTK 主题
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
# 主题在部分 GTK4 应用中无法生效问题解决，
# 参考  https://github.com/vinceliuice/WhiteSur-gtk-theme?tab=readme-ov-file#fix-for-libadwaita-not-perfect   但无法实现主题切换了
# 修复 libadwaita (不完美)
./install.sh
./install.sh -l -c light
# 安装的 flat Firefox 主题
./tweaks.sh -f flat
# 安装 GDM 主题，使用默认的背景
sudo ./tweaks.sh -g    # use the default background
sudo ./tweaks.sh -g -b "/home/lcqh/图片/BingWallpaper/47482bcb3a294e868546d6c73f1e7ca8.jpg"
sudo ./tweaks.sh -g -b default          

sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0


# 安装 WhiteSur 壁纸
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git
sudo ./install-gnome-backgrounds.sh
./install-wallpapers.sh


# 全局统一GTK主题样式
cat /etc/profile
sudo vim /etc/profile

# 统一将 QT 应用为 GTK 主题。参考 https://wiki.archlinuxcn.org/wiki/统一_Qt_和_GTK_应用程序的外观 文章中的 3.2、3.4 章节
https://wiki.archlinuxcn.org/wiki/GTK
# 参考 github 仓库 QWhiteSurGtkDecorations 文档  https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations
# 安装Kvantum主题引擎参考 https://cn.linux-terminal.com/?p=7569

https://oo-infty.netlify.app/posts/unify-look-of-linux-gui-frameworks/

# QWhiteSurGtkDecorations是一个 Qt 装饰插件，可以在Gnome wayland上实现类似 GNOME WhiteSur-gtk 主题风格的客户端装饰，适用于Qt 6 和 QT 5 平台。 
# https://wiki.archlinuxcn.org/wiki/%E7%BB%9F%E4%B8%80_Qt_%E5%92%8C_GTK_%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E7%9A%84%E5%A4%96%E8%A7%82#QWhiteSurGtkDecorations
yay -S qwhitesurgtkdecorations-qt5 qwhitesurgtkdecorations-qt6
# 将以下配置添加到用户的环境变量文件（如 ~/.bashrc 或 ~/.profile）：	
echo 'export QT_WAYLAND_DECORATION=whitesur-gtk' >> ~/.profile
echo 'export QT_STYLE_OVERRIDE=kvantum' >> ~/.profile
source ~/.profile
cat ~/.profile

# /etc/profile 为系统环境变量
# sudo vim /etc/profile
# export QT_WAYLAND_DECORATION=whitesur-gtk
# echo 'export QT_WAYLAND_DECORATION=whitesur-gtk' >> /etc/profile


# Manjaro 官方文档，设置所有Qt应用程序使用GTK字体和主题。参考
# https://wiki.manjaro.org/index.php/Set_all_Qt_app%27s_to_use_GTK%2B_font_%26_theme_settings#Overview
pamac install qt5ct 
echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> ~/.profile
source ~/.profile
echo '[[ -f ~/.profile ]] && . ~/.profile' >> ~/.bash_profile
source ~/.bash_profile
reboot

sudo pacman -S xdg-desktop-portal


# 加入全局环境变量
echo "
export GTK_THEME=WhiteSur-Dark
export QT_WAYLAND_DECORATION=whitesur-gtk
export GTK_USE_PORTAL=1
" | sudo tee -a /etc/profile

# 强制 GTK 应用使用主题
# 在 ~/.profile 或 ~/.xprofile 中设置环境变量
echo 'export GTK_THEME=WhiteSur-Dark' >> ~/.profile
source ~/.profile

# 安装 Qt 主题引擎和配置工具（Manjaro/Arch）
sudo pacman -S qt5ct qt6ct kvantum kvantum-theme-whitesur
#打开 qt5 配置器
qt5ct
# 打开 Kvantum 管理器
kvantummanager
