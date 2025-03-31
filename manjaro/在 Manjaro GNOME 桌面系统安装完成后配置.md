在 Manjaro GNOME 桌面系统安装完成后，可以通过以下配置优化使用体验。根据需求选择部分或全部步骤：

---

### **一、系统更新与基础配置**
1. **更新系统**  
   ```bash
   sudo pacman -Syu
   
   # 高分屏适配优化，全局缩放比例。对于 16 英寸 2.5K（2560x1600），推荐缩放比例：125% (1.25x) 平衡空间利用和可读性。
   gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
   # 通过 GNOME 设置 → 显示器/缩放，直接选择 125%
   
   # 启用抗锯齿（推荐 subpixel RGB 次像素渲染）为 LCD 屏幕启用次像素渲染（RGB 顺序）
   gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
   # 微调模式（slight 平衡清晰度与渲染速度）
   gsettings set org.gnome.desktop.interface font-hinting 'slight'
   # 窗口按钮布局
   gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
   # 居中显示新建窗口
   gsettings set org.gnome.mutter center-new-windows true
   # 显示电量百分比
   gsettings set org.gnome.desktop.interface show-battery-percentage true
   
   # 安装基础依赖
   sudo pacman -Syu
   sudo pacman -S --needed \
     webkit2gtk \
     base-devel \
     curl \
     wget \
     file \
     openssl \
     appmenu-gtk-module \
     gtk3 \
     libappindicator-gtk3 \
     librsvg
     
   # 卸载游戏和不用的软件
   yay -Rcns gnome-chess gnome-mines iagno quadrapassel thunderbird
   
   
   ```
   - 确保系统和软件包为最新版本。
   
1. **启用 AUR（Arch User Repository）** 和 Flatpak 
   - 打开 **Pamac**，选择 **Preferences**（首选项），在首选项窗口中，切换到 **Third-Party**（第三方）选项卡， 然后勾选 **Enable AUR Support**（启用 AUR 支持）和**Enable Flatpak Support**（启用 Flatpak 支持）：
   - 安装 AUR 助手（如 `yay`）：
     ```bash
     sudo pacman -S yay
     ```

---

### **二、GNOME 桌面个性化**
1. **安装 GNOME 优化工具**  
   ```bash
   sudo pacman -S gnome-tweaks gnome-shell-extensions
   ```
   - 通过 **GNOME Tweaks** 调整：
     - 主题、图标、光标（推荐主题：`WhiteSur-gtk-theme`、`Adwaita-dark`）。
     
     - 窗口控制按钮位置（如最小化/最大化）。
     
     - 字体和缩放比例（高分辨率屏建议启用 `Fractional Scaling`）。
     
       ```bash
       yay -S whitesur-gtk-theme whitesur-icon-theme whitesur-cursor-theme
       
       cd $HOME/下载
       git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
       cd WhiteSur-gtk-theme
       # 安装 Firefox 主题
       ./tweaks.sh -f flat
       # 安装 GDM 主题
       sudo ./tweaks.sh -g
       # 修复 Flatpak 的应用主题问题
       sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
       
       cd $HOME/下载
       git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git
       cd WhiteSur-wallpapers
       # 安装静态壁纸
       ./install-wallpapers.sh
       # 安装动态壁纸，壁纸随时间变化
       sudo ./install-gnome-backgrounds.sh
       
       # dash-to-dock 插件初始化配置
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
       # hide-top-bar 插件初始化配置，参考官网 https://gitlab.gnome.org/tuxor1337/hidetopbar
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
       gsettings set org.gnome.shell.extensions.hidetopbar enable-intellihide true
       gsettings set org.gnome.shell.extensions.hidetopbar enable-active-window false
       # blur-my-shell 插件初始化配置
       gsettings set org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
       gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
       gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
       gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
       gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
       
       # 应用主题
       gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
       gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
       gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
       gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
       gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'
       
       # 安装配置系统字体
       sudo pacman -S adobe-source-han-sans-cn-fonts
       sudo pacman -S adobe-source-han-serif-cn-fonts
       sudo pacman -S ttf-jetbrains-mono
       logout
       gsettings set org.gnome.desktop.interface font-name '思源黑体 CN Medium 12'
       gsettings set org.gnome.desktop.interface document-font-name '思源宋体 CN Medium 12'
       gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 13'
       gsettings set org.gnome.desktop.wm.preferences titlebar-font '思源黑体 CN Bold 12'
       
       # 统一将 QT 应用为 GTK 主题。参考 https://wiki.archlinuxcn.org/wiki/统一_Qt_和_GTK_应用程序的外观 文章中的 3.2、3.4 章节
       yay -S qt5ct qt6ct kvantum kvantum-theme-whitesur
       yay -S qwhitesurgtkdecorations-qt5 qwhitesurgtkdecorations-qt6
       # 将以下配置添加到用户的环境变量文件（如 ~/.bashrc 或 ~/.profile）：	
       echo 'export QT_WAYLAND_DECORATION=whitesur-gtk' >> ~/.profile
       echo 'export QT_STYLE_OVERRIDE=kvantum' >> ~/.profile
       source ~/.profile
       cat ~/.profile
       ```
   
2. **GNOME 扩展推荐**  
   - 浏览器安装 [GNOME Shell 扩展插件](https://extensions.gnome.org/)，常用扩展：
     - **Dash to Dock**：自定义 Dock 栏。
     - **ArcMenu**：增强开始菜单。
     - **Blur My Shell**：透明/模糊效果。
     - **GSConnect**：与 Android 设备互联。
     - **User Themes**：支持用户自定义主题。

3. **启用夜间模式与电源优化**  
   - 在 **Settings → Power** 中调整节能选项。
   - 通过 **GNOME Tweaks → Appearance** 启用深色模式。

---

### **三、软件安装与配置**
1. **基础工具**  
   ```bash
   yay -S firefox chromium             # 浏览器
   yay -S vlc gimp inkscape            # 多媒体与图形工具
   yay -S libreoffice-fresh            # 办公套件
   yay -S file-roller unrar p7zip      # 压缩工具
   yay -S libreoffice-still-zh-cn
   yay -S jetbrains-toolbox visual-studio-code-bin apifox switchhosts
   yay -S clash-verge-rev
   yay -S clash-verge-rev-bin
   yay -S vagrant virtualbox postgresql
   yay -S neofetch evolution popsicle obsidian
   evolution配置qq邮箱授权码： embwnsuwkdjrebge
   
   
   echo 'export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static' >> ~/.bashrc
   echo 'export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup' >> ~/.bashrc
   source ~/.bashrc  # 使配置生效
   # 安装的 rust 
   sudo pacman -S rust
   # 安装 nightly 工具链
   rustup install nightly
   # 在项目目录中设置使用 nightly
   rustup override set nightly
   ```
   
2. **输入法配置（中文用户）**  
   - 安装 `fcitx5` 或 `ibus`：
     ```bash
     sudo pacman -S manjaro-asian-input-support-ibus
     
     # 添加中文输入法
     # 打开 GNOME Settings → Keyboard → Input Sources：
     # 点击 + 添加输入源，搜索并选择「汉语（中国）」或「Chinese (China)」。
     
     # 通过终端启动 IBus 设置界面
     ibus-setup
     ```
     
   - 重启后通过 `Fcitx5 Configuration` 添加拼音输入法。

---

### **四、驱动与硬件支持**
1. **显卡驱动**  
   - NVIDIA 显卡：
     ```bash
     sudo mhwd -a pci nonfree 0300
     ```
   - AMD/Intel 显卡驱动通常已集成，无需额外配置。

2. **蓝牙与打印服务**  
   ```bash
   sudo pacman -S bluez bluez-utils cups
   sudo systemctl enable --now bluetooth cups
   ```

3. **触控板优化**  
   - 在 **Settings → Mouse & Touchpad** 中启用自然滚动、点击手势。

---

### **五、系统优化**
1. **启用 TRIM（SSD 用户）**  
   ```bash
   sudo systemctl enable fstrim.timer
   ```

2. **电源管理（笔记本用户）**  
   ```bash
   yay -S tlp
   sudo systemctl enable tlp
   ```

3. **ZRAM 配置（内存不足时启用）**  
   ```bash
   sudo pacman -S zram-generator
   sudo systemctl enable systemd-zram-setup@zram0
   ```

---

### **六、网络与安全**
1. **防火墙配置**  
   ```bash
   sudo pacman -S ufw
   sudo ufw enable
   ```

2. **VPN 支持**  
   ```bash
   yay -S networkmanager-openvpn networkmanager-strongswan
   ```

---

### **七、开发环境（可选）**
1. **基础开发工具**  
   ```bash
   sudo pacman -S git base-devel docker code
   ```

2. **编程语言支持**  
   ```bash
   yay -S python nodejs npm jdk-openjdk
   ```

---

### **八、备份与恢复**
- 安装 `timeshift` 定期备份系统：
  ```bash
  yay -S timeshift
  ```

---

### **附：常见问题解决**
- **AUR 安装失败**：检查网络或更换 AUR 镜像。
- **GNOME 扩展不兼容**：尝试回退扩展版本或更新 GNOME。
- **声音问题**：安装 `pipewire` 或检查音频设备设置。

根据实际需求调整配置，逐步完善系统即可。