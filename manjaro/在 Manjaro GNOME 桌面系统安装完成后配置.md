在 Manjaro GNOME 桌面系统安装完成后，可以通过以下配置优化使用体验。根据需求选择部分或全部步骤：

---

### **一、系统更新与基础配置**
1. **更新系统**  
   ```bash
   # 会自动寻找可与你连接的国内节点，选第一个延迟最低的就可，当然你可以选两三个，多了拖慢速度。
   # -i	交互式选择镜像（弹出GUI或TUI界面）
   # -c China	只显示中国的镜像服务器
   # -m rank	按响应速度（ping 延迟）自动排序镜像
   # 优先选择单个镜像（推荐）更新时只连接一个服务器，避免因多个镜像同步延迟导致依赖问题。
   # 推荐选择 中科大（USTC）延迟低，同步快，IPv6 支持好
   # 选择后，记得运行 sudo pacman -Syu 测试更新速度！ 🚀
   sudo pacman-mirrors -i -c China -m rank
   # 查看镜像文件
   cat /etc/pacman.d/mirrorlist
   
   # -Syu：同步仓库数据并升级所有包（包括 AUR 包）。
   # -Syua：升级所有包，并清理无用依赖（-a 表示清理）。
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
   # 默认情况下，pacman -S 会重新安装所有指定的软件包，即使它们已经是最新版本。加上 --needed 后，      # pacman 会检查软件包是否已安装且是最新版，如果是，则跳过重新安装，只安装那些缺失或需要更新的包。
   # --needed	跳过已安装且最新的软件包
   # --noconfirm	跳过所有确认提示（自动化脚本常用）
   # --overwrite	强制覆盖冲突文件（慎用）
   sudo pacman -Syu
   sudo pacman -S --needed \
     webkit2gtk-4.1 \
     base-devel \
     curl \
     wget \
     file \
     openssl \
     appmenu-gtk-module \
     libappindicator-gtk3 \
     librsvg
     
   # 卸载游戏和不用的软件
   yay -Rcns gnome-chess gnome-mines iagno quadrapassel thunderbird
   ```
   - 确保系统和软件包为最新版本。
   
1. **启用 AUR（Arch User Repository）和 Flatpak 软件仓库**  
   
   - 打开 **Pamac**，选择 **Preferences**（首选项），在首选项窗口中，切换到 **Third-Party**（第三方）选项卡， 然后勾选 **Enable AUR Support**（启用 AUR 支持）和**Enable Flatpak Support**（启用 Flatpak 支持）：
   - 安装 AUR 助手（如 `yay`）：
     ```bash
     # 如果软件包在 官方仓库 中，yay 会直接调用 pacman 安装。
     # 如果软件包在 AUR 中，yay 会自动下载 PKGBUILD 并编译安装。
     sudo pacman -S --needed yay flatpak
     
     flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
     # 修改 Flatpak 远程官方仓库，改用加速仓库
     sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
     # 查看 Flatpak 配置详情
     flatpak remotes --show-details
     
     # 升级所有软件包（包括 AUR 包、 Flatpak 包）。
     yay -Syu && flatpak update
     
     # -Syu：同步仓库数据并升级所有包（包括 AUR 包）。
     # -Syua：升级所有包，并清理无用依赖（-a 表示清理）。
     yay -Syu
     yay -Syua
     yay -S 包名			   # 安装包，自动选择官方/AUR 源
     yay 关键词				  # 搜索包，交互式搜索
     yay -R 软件包名          # 删除包，保留依赖
     yay -Rns 软件包名        # 删除包及无用依赖（推荐）
     yay -S 软件包名 --noconfirm		# 自动跳过所有提示
     yay -Sc      # 清理未安装的缓存包
     yay -Scc     # 清理所有缓存（包括已安装包的缓存）
     yay -Yc      # 清理不再需要的依赖（类似 pacman -Qdtq）
     # 清理无用的软件包并清除以下载的软件包缓存
     yay -Rns $(yay -Qdtq) && yay -Scc
     ```

---

### **二、GNOME 桌面个性化**
1. **安装 GNOME 优化工具**  
   
   ```bash
   sudo pacman -S --needed gnome-tweaks gnome-shell-extensions
   ```
   - 通过 **GNOME Tweaks** 调整：
     - 主题、图标、光标（推荐主题：`WhiteSur-gtk-theme`、`Adwaita-dark`）。
     
     - 窗口控制按钮位置（如最小化/最大化）。
     
     - 字体和缩放比例（高分辨率屏建议启用 `Fractional Scaling`）。
     
       ```bash
       yay -S --noconfirm whitesur-gtk-theme whitesur-icon-theme whitesur-cursor-theme
       
       cd $HOME/下载
       git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
       cd WhiteSur-gtk-theme
       # 将文件管理 nautilus 的侧边栏透明度调整为不透明
       # 参考官网issues https://github.com/vinceliuice/WhiteSur-gtk-theme/issues/1127
       # 可以直接使用 sed 命令精确修改目标文件，无需递归查找。
       # -i：直接修改文件（原地替换）。
       # s/旧内容/新内容/g：全局替换。
       # 使用 \' 转义单引号（因为整个命令用单引号包裹）。
       # 对 $、. 等特殊字符用 \ 转义。
       # 直接替换（精确匹配原字符串）
       sed -i 's/\$opacity: if(\$gnome_version == '\''new'\'', 0\.92, 0\.95);/\$opacity: 1;/g' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss
       # 简化版（匹配任意条件内容）
       sed -i 's/\$opacity: if([^;]*);/\$opacity: 1;/g' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss
       # 在 WhiteSur-gtk-theme 主题中提到的 “Fix for libadwaita (not perfect)” 是指该主题对基于 libadwaita 的应用程序（如 GNOME 42+ 的默认应用）的视觉兼容性调整，但尚未达到完美适配的状态。
       ./install.sh -l                # Default is the normal dark theme
       ./install.sh -l -c light       # install light theme for libadwaita
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
       
       # 列出所有已安装的 Schema
       gsettings list-schemas
       # 列出某个 Schema 下的所有键
       gsettings list-keys org.gnome.desktop.interface
       # 查看键的取值类型和描述
       gsettings describe org.gnome.desktop.interface font-name
       # 递归列出某个 Schema 的键值（例如 org.gnome.desktop.interface）
       gsettings list-recursively org.gnome.desktop.interface
       
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
       echo 'export QT_STYLE_OVERRIDE=kvantum' >> ~/.profile
       echo 'export QT_QPA_PLATFORMTHEME=gtk3' >> ~/.profile
       echo 'export QT_WAYLAND_DECORATION=whitesur-gtk' >> ~/.profile
       echo 'export GTK_USE_PORTAL=1' >> ~/.profile
       echo 'export GTK_THEME=WhiteSur-Light' >> ~/.profile
       source ~/.profile
       cat ~/.profile
       
       kvantummanager
       yay -S libadwaita-demos
       ```
   
2. **GNOME 扩展推荐**  
   
   - 浏览器安装 [GNOME Shell 扩展插件](https://extensions.gnome.org/)，常用扩展：
     - **Dash to Dock**：自定义 Dock 栏。
     
     - **ArcMenu**：增强开始菜单。
     
     - **Blur My Shell**：透明/模糊效果。
     
     - **GSConnect**：与 Android 设备互联。
     
     - **User Themes**：支持用户自定义主题。
     
       ```bash
       # 一组官方的 Gnome Shell 扩展插件
       # 官方仓库地址 https://gitlab.gnome.org/GNOME/gnome-shell-extensions
       yay -S gnome-shell-extensions
       yay -S gnome-shell-extension-dash-to-dock
       yay -S gnome-shell-extension-caffeine
       yay -S gnome-shell-extension-vitals
       yay -S gnome-shell-extension-gtk4-desktop-icons-ng
       
       # 以下扩展来自 AUR 仓库
       yay -S --noconfirm gnome-shell-extension-blur-my-shell
       yay -S gnome-shell-extension-hidetopbar
       
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
       gsettings set org.gnome.shell.extensions.hidetopbar mouse-sensitive-fullscreen-window false
       gsettings set org.gnome.shell.extensions.hidetopbar show-in-overview false
       gsettings set org.gnome.shell.extensions.hidetopbar hot-corner false
       gsettings set org.gnome.shell.extensions.hidetopbar mouse-triggers-overview false
       gsettings set org.gnome.shell.extensions.hidetopbar keep-round-corners false
       gsettings set org.gnome.shell.extensions.hidetopbar pressure-threshold 500
       gsettings set org.gnome.shell.extensions.hidetopbar pressure-timeout 2000
       gsettings set org.gnome.shell.extensions.hidetopbar animation-time-autohide 0.5
       gsettings set org.gnome.shell.extensions.hidetopbar animation-time-overview 0.5
       gsettings set org.gnome.shell.extensions.hidetopbar shortcut-keybind ['<Alt>p']
       gsettings set org.gnome.shell.extensions.hidetopbar shortcut-delay 3.0
       gsettings set org.gnome.shell.extensions.hidetopbar shortcut-toggles true
       gsettings set org.gnome.shell.extensions.hidetopbar enable-intellihide false
       gsettings set org.gnome.shell.extensions.hidetopbar enable-active-window false
       
       # blur-my-shell 插件初始化配置
       gsettings set org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
       gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
       gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
       gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
       gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
       
       
       Alphabetical App Grid
       Bluetooth Quick Connect
       # 点击标题栏中的铅笔形状的编辑按钮，将 Animaion Type 的值从 Any 改为 Closing Windows 这样就可以关闭窗口打开时的动画效果
       Burn My Windows
       Clipboard Indicator
       Compiz alike magic lamp effect
       ddterm
       Just Perfection
       # 安装 Lunar Calendar 农历 扩展插件需要如下内容
       # yay -S cpio
       #https://gitlab.gnome.org/Nei/ChineseCalendar/-/archive/20250205/ChineseCalendar-20250205.tar.gz
       # tar -xzvf ChineseCalendar-20250205.tar.gz
       # cd ChineseCalendar-20250205
       # ./install.sh
       Lunar Calendar 农历
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
       Window Gestures
       VirtualBox applet
       
       logout
       ```

---

### **三、软件安装与配置**
1. **基础工具**  
   ```bash
   yay -S --needed firefox firefox-i18n-zh-cn	# 浏览器          
   yay -S --noconfirm microsoft-edge-stable-bin
   yay -S google-chrome
   yay -S libreoffice-fresh-zh-cn		# 办公套件
   yay -S clash-verge-rev
   
   # 绑定全局快捷键：在 GNOME 设置 → 键盘 中添加自定义快捷键，命令为 flameshot gui
   # flameshot 火焰截图，grim 为 flameshot 在 wayland 环境提供支持
   yay -S --needed --noconfirm flameshot grim
   yay -S --needed --noconfirm neofetch evolution popsicle
   # evolution配置qq邮箱授权码： embwnsuwkdjrebge
   
   yay -S typora-cn obsidian
   yay -S linuxqq wechat baidunetdisk-bin
   yay -S yesplaymusic
   ```
   
2. **输入法配置（中文用户）**  
   
   - 安装 `ibus`：
     ```bash
     # IBus 和 GNOME 原生集成较好，在 Wayland 会话 下运行（IBus 与 GNOME Wayland 兼容性更好）。
     sudo pacman -S manjaro-asian-input-support-ibus
     
     # 添加中文输入法
     # 打开 GNOME 设置 → 键盘 → 输入源：
     # 点击 + 添加输入源，搜索并选择「汉语（中国）」或「Chinese (China)」。
     # 然后点击旁边的三个 ... 进行拼音输入法配置，效果等同于下面的 ibus-setup 配置方式
     
     # 通过终端启动 IBus 设置界面
     ibus-setup
     # 在 IBus 设置界面中的输入法选项中添加 中文-智能拼音 并点击旁边的首选项配置，启用云输入和词典
     ```

---

### **四、系统优化**
1. **调整AMD CPU核显的显存**  
   
   ```bash
   # 调整AMD CPU核显的显存，可以解决笔记本风扇经常高速转动导致的机身发热和噪音
   
   重启开机快按Esc进入BIOS，选到第5个Setup Utility，进入后选第4个AMD CBS，来到右侧的NBIO Common Options，
   再进入第1个GFX Configuration，进入后看到UMA Frame buffer Size。
   默认情况它设置的是1G，我们按右方向键修改为最大的4G。 按F10保存并退出，重启后专用GPU内存变为4G了，常规内存为27G。
   ```
   
3. **ZRAM 配置（内存不足时启用）**  
   
   ```bash
   
   ```

---

### **六、网络与安全**
1. **防火墙配置**  
   ```bash
   sudo pacman -S ufw
   sudo ufw enable
   sudo ufw status
   ```
   
2. **VPN 支持**  

   ```bash
   yay -S clash-verge-rev
   # 官网 https://account.protonvpn.com/dashboard
   # 可以使用 lcqh2635@gmail.com 谷歌邮箱登录
   yay -S proton-vpn-gtk-app
   ```

---

### **七、开发环境（可选）**
1. **基础开发工具**  
   
   ```bash
   sudo pacman -S git base-devel code wl-clipboard
   git config --global user.name "龙茶清欢"
   git config --global user.email "2320391937@qq.com"
   ssh-keygen -t rsa -b 4096 -C "2320391937@qq.com"
   # 需要安装 wl-clipboard 工具
   cat ~/.ssh/id_rsa.pub | wl-copy
   # https://gitee.com/profile/sshkeys
   # https://github.com/settings/keys
   
   yay -S jetbrains-toolbox visual-studio-code-bin apifox switchhosts tabby
   yay -S vagrant virtualbox
   ```
   
2. **编程语言支持**  
   
   ```bash
   # 添加 Rust 下载加速
   echo 'export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static' >> ~/.profile
   echo 'export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup' >> ~/.profile
   # 使配置生效
   source ~/.profile
   # 安装的 rust 
   sudo pacman -S rust
   # 安装 nightly 工具链
   rustup install nightly
   # 在项目目录中设置使用 nightly
   rustup override set nightly
   
   # 安装 sdkman 工具，官网 https://sdkman.io/install
   curl -s "https://get.sdkman.io" | bash
   # 启动 sdkman
   source "$HOME/.sdkman/bin/sdkman-init.sh"
   sdk version
   sdk help
   # Temurin 是 Eclipse Adoptium 项目维护的 高质量 OpenJDK 发行版，完全兼容 Oracle JDK，且通过 严格兼容性测试（TCK 认证）。完全免费
   # 标准的 OpenJDK 发行版，提供常规 JVM 运行时
   sdk install java 21.0.6-tem  	# 默认
   # 基于 OpenJDK 的增强版，支持原生镜像编译（AOT）和多语言互操作
   sdk install java 21.0.6-graal
   # 设置默认的
   sdk default java 21.0.6-tem
   sdk use java 21.0.6-graal
   # 检查可更新的候选版本
   sdk update
   # 升级所有已安装工具
   sdk upgrade
   # 升级 SDKMAN! 自身到最新版本
   sdk selfupdate
   sdk install maven
   sdk install gradle
   sdk current
   # 查看某版本的安装路径
   sdk home java 21.0.6-tem
   # 检查可更新的候选版本并升级所有已安装工具
   sdk update && sdk upgrade
   echo $JAVA_HOME
   
   # 安装 nvm，参考官方文档 https://nvm.p6p.net/
   # nodejs 官网 https://nodejs.cn/
   yay -S --needed --noconfirm nvm
   # 1. 添加到 ~/.zshrc
   echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
   # 2. 立即生效
   source ~/.zshrc
   nvm --help
   nvm --version
   nvm ls-remote --lts
   nvm install --lts
   nvm install v18.20.8
   node --version
   npm --version
   
   # 最新地址 淘宝 NPM 镜像站喊你切换新域名啦!
   npm config set registry https://registry.npmmirror.com
   npm config get registry
   
   yay -S bun-bin
   npm install -g bun
   # 确认你当前使用的 shell，默认是 /bin/zsh 
   # 如果执行 source ~/.bashrc 会 shopt 报错（因为 shopt 是 Bash 特有，Zsh 不支持）
   echo $SHELL
   # 进入纯 Bash 环境
   bash
   source ~/.bashrc
   source ~/.zshrc
   echo 你刚安装的 bun 版本号为： $(bun --version)
   # 将 bunfig.toml 作为隐藏文件添加到用户主目录
   echo '[install]
   # 使用阿里云加速仓库，仓库地址可从阿里云官方获取，地址为 https://developer.aliyun.com/mirror/
   registry = "https://registry.npmmirror.com/"
   ' >> ~/.bunfig.toml
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
   # For Android development, run: 需要提前安装并配置好 Android Studio  参考 https://tauri.app/zh-cn/start/prerequisites/#android
   bun run tauri android dev
   
   # 安装 go 直接打开 manjaro自带的应用商城搜索 go 并安装即可
   sudo pacman -S go
   go version
   # 配置加速代理
   go env -w GOPROXY=https://goproxy.cn,direct
   go env
   
   # 安装数据库
   yay -S mariadb postgresql redis chat2db-bin
   yay -S --needed docker docker-compose
   docker --version
   docker-compose --version
   # 启用并立即启动服务
   sudo systemctl enable --now docker
   # 将当前用户加入 docker 组（避免每次用 sudo）
   sudo usermod -aG docker $USER
   newgrp docker  # 立即生效（或重新登录）
   # 检查 Docker 服务是否运行
   systemctl status docker
   docker info  # 显示 Docker 系统信息（版本、容器数、镜像数等）
   docker stats # 实时监控所有运行中容器的资源占用（CPU/内存）
   sudo systemctl start docker
   sudo systemctl stop docker
   sudo systemctl restart docker
   sudo systemctl enable docker
   sudo systemctl disable docker
   # 停止所有容器后再停止服务（谨慎操作）
   docker stop $(docker ps -aq)  # 停止所有容器
   sudo systemctl stop docker    # 再停止 Docker 服务
   # 如果文件不存在或不需要保留原有配置，直接覆盖写入（推荐）
   sudo bash -c 'mkdir -p /etc/docker && cat > /etc/docker/daemon.json <<EOF
   {
     "registry-mirrors": [
       "https://docker.1ms.run",
       "https://registry.cn-hangzhou.aliyuncs.com",
       "https://docker.mirrors.ustc.edu.cn",
       "https://hub-mirror.c.163.com"
     ]
   }
   EOF'
   cat /etc/docker/daemon.json
   sudo systemctl restart docker
   
   nvm install lts/hydrogen
   nvm use lts/hydrogen
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



##  环境变量的配置可以放在多个文件中（如 `~/.bashrc`、`~/.zshrc`、`~/.profile`），但它们的加载顺序和作用范围不同

在 Linux/macOS 系统中，环境变量的配置可以放在多个文件中（如 `~/.bashrc`、`~/.zshrc`、`~/.profile`），但它们的加载顺序和作用范围不同。以下是 **最佳实践建议**：

---

## **1. 推荐位置（根据 Shell 类型）**
| 文件             | 适用 Shell                          | 加载时机                       | 推荐用途                                             |
| ---------------- | ----------------------------------- | ------------------------------ | ---------------------------------------------------- |
| **`~/.profile`** | **所有登录 Shell**（Bash、Zsh、Sh） | 用户登录时（图形界面或 `ssh`） | **全局环境变量**（如 `PATH`、`JAVA_HOME`、`EDITOR`） |
| **`~/.bashrc`**  | **仅 Bash**（交互式非登录 Shell）   | 每次打开新终端（非登录）       | **Bash 专属配置**（别名、函数、提示符等）            |
| **`~/.zshrc`**   | **仅 Zsh**（交互式非登录 Shell）    | 每次打开新终端（非登录）       | **Zsh 专属配置**（插件、主题、补全等）               |

---

### **关键区别**
- **`~/.profile`（或 `~/.bash_profile`/`~/.zprofile`）**  
  - **适合存放环境变量**（如 `PATH`、`LANG`、`GOPATH`），因为：
    - 只在登录时加载一次，避免重复添加路径。
    - 兼容所有 Shell（Bash、Zsh、Sh），适合共享配置。
  - 如果同时存在 `~/.profile` 和 `~/.bash_profile`，Bash 会优先加载后者（Zsh 同理）。

- **`~/.bashrc` 或 `~/.zshrc`**  
  - **适合存放 Shell 特有的交互式配置**，如：
    - 别名（`alias ll='ls -al'`）
    - 函数、提示符（`PS1`）、插件（Oh My Zsh）
    - 每次打开终端都会加载，不适合修改 `PATH`（可能导致重复添加）。

---

## **2. 最佳实践**
### **（1）环境变量（如 `PATH`、`JAVA_HOME`）**
✅ **推荐放在 `~/.profile`**（或 `~/.bash_profile`/`~/.zprofile`）  
```bash
# ~/.profile
export PATH="$HOME/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
```
- **为什么？**  
  - 只需在登录时加载一次，避免重复修改 `PATH`。
  - 兼容所有 Shell（包括图形界面启动的应用）。

---

### **（2）Shell 专属配置（别名、插件等）**
- **Bash 用户 → `~/.bashrc`**  
  ```bash
  # ~/.bashrc
  alias ll='ls -al'
  export PS1='\u@\h:\w\$ '  # 仅影响 Bash 的提示符
  ```

- **Zsh 用户 → `~/.zshrc`**  
  ```zsh
  # ~/.zshrc
  alias gst='git status'
  source ~/.oh-my-zsh/oh-my-zsh.sh  # Oh My Zsh 插件
  ```

---

### **（3）特殊情况处理**
#### **图形界面应用（如 VS Code、IDE）读取环境变量**
- 如果图形应用启动时找不到 `PATH`，可能是因为它们不读取 `~/.bashrc` 或 `~/.zshrc`。  
- **解决方案**：确保变量在 `~/.profile` 中定义，并在图形界面登录时加载它。

#### **MacOS 注意事项**
- Mac 的终端默认以 **登录 Shell** 启动，会加载 `~/.bash_profile`（Bash）或 `~/.zprofile`（Zsh）。  
- 建议将环境变量放在 `~/.bash_profile` 或 `~/.zprofile`，并在文件末尾加上：
  ```bash
  # ~/.bash_profile
  [ -f ~/.bashrc ] && source ~/.bashrc  # 同时加载 .bashrc
  ```

---

## **3. 配置加载顺序**
### **Bash**
1. 登录 Shell（如 `ssh`、图形界面登录）：
   ```
   /etc/profile → ~/.bash_profile → ~/.profile
   ```
2. 非登录交互式 Shell（如终端新标签页）：
   ```
   ~/.bashrc
   ```

### **Zsh**
1. 登录 Shell：
   ```
   /etc/zprofile → ~/.zprofile
   ```
2. 非登录交互式 Shell：
   ```
   ~/.zshrc
   ```

---

## **总结**
| 配置类型                            | 推荐文件                                           | 示例                               |
| ----------------------------------- | -------------------------------------------------- | ---------------------------------- |
| **环境变量**（`PATH`、`JAVA_HOME`） | `~/.profile`（或 `~/.bash_profile`/`~/.zprofile`） | `export PATH="$HOME/bin:$PATH"`    |
| **Bash 专属配置**（别名、提示符）   | `~/.bashrc`                                        | `alias ll='ls -al'`                |
| **Zsh 专属配置**（插件、主题）      | `~/.zshrc`                                         | `source ~/.oh-my-zsh/oh-my-zsh.sh` |

### **一句话原则**
- **所有 Shell 共享的配置 → `~/.profile`**  
- **Shell 特有的交互式配置 → `~/.bashrc` 或 `~/.zshrc`**  
- **Mac 用户 → 优先用 `~/.bash_profile` 或 `~/.zprofile`**  

这样可以确保环境变量在所有场景（终端、图形应用、SSH）中生效，同时避免配置冲突。