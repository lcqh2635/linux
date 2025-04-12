以下是为 Fedora Workstation 41 初次安装后的推荐配置步骤，按优先级和常见需求分类整理：

---

### **一、系统更新与基础配置**
1. **更新系统**  
   ```bash
   sudo dnf update -y && sudo dnf upgrade -y
   
   # 如果想使用 Gnome 软件升级到预发布版本
   gsettings set org.gnome.software show-upgrade-prerelease true
   # 升级完成后，强烈建议禁用该功能，这样您就不会收到不需要的未来预发布版。
   gsettings set org.gnome.software show-upgrade-prerelease false
   
   # 从预发布版（beta）升级到最终公开版（stable）
   如果您使用的是 Fedora Linux 的预发行版，则无需执行任何操作来获取最终的公开发行版，只需在软件包可用时对其进行更新即可。您可以使用 sudo dnf upgrade 或等待桌面通知。当预发布版本作为最终版本发布时，fedora-repos 软件包将被更新，并且您的 updates-testing 仓库将被禁用。一旦发生这种情况（在发布当天），强烈建议运行 sudo dnf distro-sync，以便使软件包版本与当前版本保持一致。
   ```
   
2. **启用 RPM Fusion 仓库**（提供非自由软件支持）  
   ```bash
   # 国内加速仓库
   清华   https://mirrors.tuna.tsinghua.edu.cn
   中科大 https://mirrors.ustc.edu.cn
   腾讯云 https://mirrors.cloud.tencent.com
   华为云 https://mirrors.huaweicloud.com
   阿里云 https://mirrors.aliyun.com
   
   https://developer.aliyun.com/mirror/fedora
   https://developer.aliyun.com/mirror/rustup
   
   
   # 中科大 Fedora 镜像源 https://mirrors.ustc.edu.cn/help/fedora.html
   sudo sed -e 's|^metalink=|#metalink=|g' \
            -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
            -i.bak \
            /etc/yum.repos.d/fedora.repo \
            /etc/yum.repos.d/fedora-updates.repo
   # 清华 Fedora 镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/fedora/
   sed -e 's|^metalink=|#metalink=|g' \
       -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' \
       -i.bak \
       /etc/yum.repos.d/fedora.repo \
       /etc/yum.repos.d/fedora-updates.repo
   # 清华 RPMFusion 镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/rpmfusion/
   # 1、安装基础包。首先安装提供基础配置文件和 GPG 密钥的 rpmfusion-*.rpm。
   sudo yum install --nogpgcheck https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
   # 2、修改链接指向镜像站
   sudo sed -e 's!^metalink=!#metalink=!g' \
            -e 's!^mirrorlist=!#mirrorlist=!g' \
            -e 's!^#baseurl=!baseurl=!g' \
            -e 's!https\?://download1\.rpmfusion\.org/!https://mirrors.aliyun.com/rpmfusion/!g' \
            -i.bak /etc/yum.repos.d/rpmfusion*.repo
   
   https://mirrors.aliyun.com/mirror/rpmfusion
   # 阿里云 RPMFusion 镜像源 https://developer.aliyun.com/mirror/rpmfusion
   sudo yum install --nogpgcheck https://mirrors.aliyun.com/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            
   sudo sed -e 's!^metalink=!#metalink=!g' \
            -e 's!^mirrorlist=!#mirrorlist=!g' \
            -e 's!^#baseurl=!baseurl=!g' \
            -e 's!https\?://download1\.rpmfusion\.org/!https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/!g' \
            -i.bak /etc/yum.repos.d/rpmfusion*.repo         
   # 查看配置结果
   cat /etc/yum.repos.d/rpmfusion-free.repo
   
   # 最后运行 sudo dnf makecache 生成缓存
   sudo dnf makecache
   # 中科大 Flatpak 镜像源 https://mirrors.ustc.edu.cn/help/flathub.html
   sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
   # 上海交大 Flatpak 镜像源 https://mirrors.sjtug.sjtu.edu.cn/docs/flathub
   sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
   
   # 恢复默认值
   sudo flatpak remote-modify flathub --url=https://dl.flathub.org/repo
   
   sudo dnf update -y && sudo dnf upgrade -y && flatpak update -y
   
   
   # 网站国内可用 DNS 测试 ping https://ping.chinaz.com/www.youtube.com
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
   # 验证是否添加成功
   grep 'github.com' /etc/hosts
   grep 'raw.githubusercontent.com' /etc/hosts
   # 检查是否解析为新IP
   ping github.com
   ping raw.githubusercontent.com
   cat /etc/hosts
   nautilus admin:/etc/hosts
   
   # 安装基础依赖包 https://v2.tauri.app/zh-cn/start/prerequisites/#linux
   sudo dnf install -y git wl-clipboard
   git config --global user.name "龙茶清欢"
   git config --global user.email "2320391937@qq.com"
   ssh-keygen -t rsa -b 4096 -C "2320391937@qq.com"
   # 需要安装 wl-clipboard 工具
   cat ~/.ssh/id_rsa.pub | wl-copy
   # https://gitee.com/profile/sshkeys
   # https://github.com/settings/keys
   ```
   
3. 配置

4. **安装多媒体编解码器**  

   ```bash
   # 作为 Fedora 用户和系统管理员，您可以使用这些步骤来安装额外的多媒体插件，使您能够播放各种视频和音频类型。参考 https://docs.fedoraproject.org/zh_Hans/quick-docs/installing-plugins-for-playing-movies-and-music/
   sudo dnf group install multimedia
   
   dnf list installed
   sudo dnf install gnome-terminal
   sudo dnf install dnf-plugins-core
   # 参考 https://docs.fedoraproject.org/zh_CN/quick-docs/openh264/#_firefox_config_changes
   sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264 mozilla-ublock-origin
   # 配置 Firefox
   在 Firefox 地址栏中键入 about:config 并接受警告。
   在搜索字段中，输入 264，将出现一些选项。通过双击 false，为以下 Preference Names 指定 true 值：
   media.gmp-gmpopenh264.autoupdate
   media.gmp-gmpopenh264.enabled
   media.gmp-gmpopenh264.provider.enabled
   media.peerconnection.video.h264_enabled
   
   
   sudo dnf install \
   ffmpeg \                    # 通用音视频处理框架（支持多种格式）
   gstreamer1-plugins-bad-* \  # "Bad"插件集（非自由/实验性编解码器，如MPEG-2、DTS）
   gstreamer1-plugins-good-* \ # "Good"插件集（高质量自由编解码器，如MP3、H.264）
   gstreamer1-plugins-base \   # GStreamer 基础插件（必须依赖项）
   gstreamer1-plugin-openh264 \ # 开源H.264编解码器（用于WebRTC视频通话）
   gstreamer1-libav \          # 基于FFmpeg的编解码器扩展（补充格式支持）
   --exclude=gstreamer1-plugins-bad-free-devel  # 排除开发头文件（避免冲突）
   ```

---

### **二、硬件驱动优化**
1. **显卡驱动**  
   - **NVIDIA 显卡**（需先启用 RPM Fusion）：  
     ```bash
     sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
     sudo reboot
     ```
   - **AMD/Intel 集成显卡**：默认已启用开源驱动，无需额外操作。

2. **触控板/鼠标优化**  
   ```bash
   sudo dnf install libinput-gestures  # 支持多指触控手势
   ```

---

### **三、软件管理**
1. **启用 Flathub 软件仓库**  
   
   ```bash
   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```
   
2. **安装常用工具**  
   ```bash
   sudo dnf install -y \                 
   git unzip p7zip \   
   gnome-tweaks \          
   gnome-extensions-app \ 
   timeshift \ 
   
   
   
   sudo dnf install google-chrome-stable
   sudo dnf install libreoffice-langpack-zh-Hans
   sudo dnf install evolution obs-studio
   # evolution配置qq邮箱授权码： embwnsuwkdjrebge
   sudo dnf install fastfetch
   fastfetch
   sudo dnf install vagrant VirtualBox virtualbox-guest-additions
   
   
   # 安装常用 Flathub 软件
   # 自定义 GNOME 的方方面面，类似 gnome-tweaks
   flatpak install flathub page.tesk.Refine -y
   # GDM 设置
   flatpak install flathub io.github.realmazharhussain.GdmSettings -y
   flatpak install flathub org.gnome.Evolution -y
   flatpak install flathub io.typora.Typora -y
   flatpak install flathub md.obsidian.Obsidian -y
   flatpak install flathub com.baidu.NetDisk -y
   flatpak install flathub io.github.qier222.YesPlayMusic -y
   flatpak install flathub com.microsoft.Edge -y
   flatpak install flathub com.google.Chrome -y
   flatpak install flathub org.videolan.VLC -y
   # 管理 Flatpak 权限
   flatpak install flathub com.github.tchx84.Flatseal -y
   # 管理 Flatpak 的所有内容
   flatpak install flathub io.github.flattool.Warehouse -y
   # Flatpak残留清理器
   flatpak install flathub io.github.giantpinkrobots.flatsweep -y
   # 管理 AppImages 应用
   flatpak install flathub it.mijorus.gearlever -y
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
   # 在设备上安装固件管理
   flatpak install flathub org.gnome.Firmware -y
   # 种子下载器
   flatpak install flathub com.transmissionbt.Transmission -y
   # 保存您的桌面环境配置
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
   # 屏幕录制
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
   flatpak install flathub com.valvesoftware.Steam -y
   flatpak install flathub io.github.Foldex.AdwSteamGtk -y
   
   
   # 开发常用软件
   flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate -y
   flatpak install flathub com.google.AndroidStudio -y
   flatpak install flathub dev.zed.Zed -y
   flatpak install flathub io.github.shiftey.Desktop -y
   flatpak install flathub com.visualstudio.code -y
   # 触手可及的开发工具箱
   flatpak install flathub me.iepure.devtoolbox -y
   # 下载 jetbrains-toolbox
   https://www.jetbrains.com/zh-cn/toolbox-app/download/download-thanks.html?platform=linux
   
   
   # 一键安装 Watt Toolkit 软件脚本，参考 https://steampp.net/
   # 安装后还需要额外处理一些问题 https://steampp.net/liunxSetupCer
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
   
3. **推荐通过 Flatpak 安装的软件**  
   
   ```bash
   flatpak install -y flathub \
   com.spotify.Client \    # 音乐
   com.discordapp.Discord \
   com.slack.Slack \
   com.visualstudio.code   # VS Code
   
   
   
   ```

---

### **四、开发环境配置**
1. **基础开发工具**  
   ```bash
   sudo dnf groupinstall "Development Tools"
   sudo dnf install git python3 nodejs java-latest-openjdk
   
   # dnf 安装编程语言和数据库 https://developer.fedoraproject.org/tech.html
   # 参考 https://developer.fedoraproject.org/tech/languages/rust/rust-installation.html
   sudo dnf install rust cargo
   sudo dnf install rustup
   
   # https://developer.fedoraproject.org/tech/languages/go/go-installation.html
   sudo dnf install golang
   
   
   # PostgreSQL 数据库 https://developer.fedoraproject.org/tech/database/postgresql/about.html
   sudo dnf install postgresql postgresql-server    # install client/server
   sudo postgresql-setup --initdb --unit postgresql # initialize PG cluster
   sudo systemctl start postgresql                  # start cluster
   sudo su - postgres                               # login as DB admin
   
   # MariaDB 数据库 https://developer.fedoraproject.org/tech/database/mariadb/about.html
   sudo dnf install mariadb
   sudo dnf install mariadb-server
   sudo systemctl start mariadb
   sudo systemctl enable mariadb
   sudo mysql_secure_installation
   sudo mysql -u root -p
   
   # Redis 数据库 https://developer.fedoraproject.org/tech/database/redis/about.html
   sudo dnf install redis     # Install redis cli and server
   sudo systemctl start redis # Initialize redis server
   sudo systemctl enable redis
   
   # QEMU 安装 https://developer.fedoraproject.org/tools/virtualization/installing-qemu-on-fedora-linux.html
   sudo dnf install qemu -y
   sudo dnf install libvirt -y
   sudo dnf install virt-install -y
   # 安装组件
   sudo dnf install qemu-kvm libvirt virt-manager
   sudo systemctl enable --now libvirtd
   
   # 使用图形界面
   virt-manager
   # 使用 QEMU 浏览 DBus 的虚拟化查看器
   # QEMU的虚拟化查看器. 应用程序在 DBus 上与运行的QEMU 实例进行通信 。 它支持键盘,鼠标和多触摸手势.
   flatpak install flathub com.belmoussaoui.snowglobe -y
   
   # Waydroid 基于 Linux 容器（LXC）运行完整的 Android 系统，性能接近原生。
   # 与主机 Fedora 共享内核但隔离用户空间，类似 Docker。
   sudo dnf install -y waydroid android-tools
   waydroid --help
   waydroid --version
   adb --version
   adb kill-server
   adb start-server
   # 查看确保 Waydroid 正在运行
   waydroid status
   sudo systemctl status waydroid-container
   sudo systemctl restart waydroid-container
   waydroid first-launch
   # 如果显示 Session: STOPPED，先启动 Waydroid：
   waydroid session start
   # 启动图形界面：
   waydroid show-full-ui
   # 检查设备连接
   adb devices
   # 打开 设置 → 应用 → 选择需要权限的应用（如文件管理器）。
   # 点击 权限 → 存储，确保已授予 读写存储空间 权限。
   adb shell mount | grep sdcard
   adb shell chmod -R 777 /sdcard/Download/
   adb push ~/下载/3VPN-release.apk /sdcard/Download/
   adb push ~/下载/Steam _android_v2.8.3.apk /sdcard/
   
   # 手动绑定 ADB 到 Waydroid 容器
   adb connect 192.168.240.112:5555
   System OTA	https://ota.waydro.id/system
   Vendor OTA	https://ota.waydro.id/vendor
   VANILLA	纯净版 Android，不包含 Google 服务（GMS/GApps）选这个！
   GAPPS	预装了 Google 移动服务（Google Play 商店、框架等） 的 Android
   
   sudo firewall-cmd --zone=public --add-port=5555/tcp --permanent
   sudo firewall-cmd --reload
   
   # 初始化环境：
   sudo waydroid init
   sudo systemctl enable --now waydroid-container
   sudo waydroid container start
   sudo waydroid session start
   # 启动 Waydroid：
   waydroid session start &  # 后台运行会话
   waydroid show-full-ui     # 显示安卓界面
   # 安装 VPN https://steampp.net/download
   https://gitee.com/rmbgame/SteamTools/releases/download/2.8.3/Steam%20%20_android_v2.8.3.apk
   # https://raw.githubusercontent.com/sharmajv/vpn/main/3VPN-release.apk
   # 设置 - 关于手机 - 版本号（最后一个菜单，快速点击启用开发者模式）
   # 设置 - 系统 - 高级 - 开发者选项
   waydroid app install ~/下载/3VPN-release.apk
   waydroid app install 3VPN-release.apk
   waydroid app list
   
   sudo systemctl restart waydroid-container
   # 重装系统
   sudo systemctl stop waydroid-container
   # /var/lib/waydroid：存放系统镜像（system.img、vendor.img）和用户数据。
   # /home/.waydroid：用户配置文件（可选删除以彻底重置）。
   sudo rm -rf /var/lib/waydroid /home/.waydroid ~/waydroid ~/.share/waydroid ~/.local/share/waydroid
   # Android 类型：选 VANILLA（无 GApps）
   sudo waydroid init
   
   
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
   ```
   
2. **Docker 安装**  
   
   ```bash
   sudo dnf install podman
   
   sudo dnf install dnf-plugins-core
   sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
   sudo dnf install docker-ce docker-ce-cli containerd.io
   sudo systemctl enable --now docker
   sudo usermod -aG docker $USER  # 将当前用户加入 docker 组（需注销后生效）
   ```

---

### **五、系统优化与美化**
1. **Gnome 扩展管理**  
   - 浏览器安装插件 [GNOME Shell Integration](https://extensions.gnome.org/)
   - 安装优化和扩展：  
     ```bash
     sudo dnf install -y gnome-tweaks gnome-extensions-app
     
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
     gsettings list-recursively org.gnome.shell.extensions.blur-my-shell
     gsettings list-recursively org.gnome.shell.extensions.just-perfection
     
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
     
     dnf search gnome-shell-extension
     # 卸载自带的无用扩展插件
     sudo dnf remove -y \
     gnome-shell-extension-window-list \
     gnome-shell-extension-launch-new-instance \
     gnome-shell-extension-apps-menu \
     gnome-shell-extension-places-menu \
     
     # 系统扩展插件
     sudo dnf install -y \
     gnome-shell-extension-user-theme \
     gnome-shell-extension-dash-to-dock \
     gnome-shell-extension-blur-my-shell \
     gnome-shell-extension-just-perfection \
     gnome-shell-extension-drive-menu \
     gnome-shell-extension-caffeine \
     gnome-shell-extension-workspace-indicator \
     gnome-shell-extension-auto-move-windows \
     gnome-shell-extension-appindicator
     
     gnome-shell-extension-forge.noarch
     gnome-shell-extension-gsconnect.x86_64
     gnome-shell-extension-unite.noarch
     # 这两个可以安装，不建议启用
     gnome-shell-extension-apps-menu
     gnome-shell-extension-places-menu
     
     # 请务必在使用 SaveDesktop 备份所有配置
     nautilus ~/.local/share/gnome-shell/extensions
     ls ~/.local/share/gnome-shell/extensions
     # 扩展在 metadata.json 中声明 schema 和 Gnome 版本信息
     # 用户安装的Gnome扩展有 settings-schema 但无法显示和使用，未自动注册到全局 GSettings 数据库
     # 进入扩展目录（示例扩展名：hidetopbar@mathieu.bidon.ca）
     cd ~/.local/share/gnome-shell/extensions/hidetopbar@mathieu.bidon.ca/
     # 1. 检查是否存在 schemas 文件
     ls schemas/
     # 2. 编译 schemas（需 glib2 工具）
     glib-compile-schemas schemas/
     # 3. 将 schemas 注册到用户数据库
     mkdir -p ~/.local/share/glib-2.0/schemas/
     cp schemas/*.gschema.xml ~/.local/share/glib-2.0/schemas/
     glib-compile-schemas ~/.local/share/glib-2.0/schemas/
     ls ~/.local/share/glib-2.0/schemas/
     # 列出所有可用的 schema
     gsettings list-schemas | grep hidetopbar
     # 系统级扩展的 Schemas 目录
     ls /usr/share/glib-2.0/schemas/
     
     
     quick-settings-avatar@d-go
     
     
     
     Add to Desktop
     Alphabetical App Grid
     Bluetooth Quick Connect
     Clipboard Indicator
     Coverflow Alt-Tab
     Compiz windows effect
     Compiz alike magic lamp effect
     Desktop Cube
     Dynamic Panel
     Dash2Dock Animated
     Extension List
     Gtk4 Desktop Icons NG (DING)
     # 安装 Lunar Calendar 农历 扩展插件需要如下内容
     #https://gitlab.gnome.org/Nei/ChineseCalendar/-/archive/20250205/ChineseCalendar-20250205.tar.gz
     # tar -xzvf ChineseCalendar-20250205.tar.gz
     # cd ChineseCalendar-20250205
     # ./install.sh
     Lunar Calendar 农历
     Logo Menu
     Hide Top Bar
     # 修复 Hide Top Bar 闪跳 BUG
     Disable unredirect fullscreen windows
     Night Theme Switcher
     Notification Banner Reloaded
     Quick Settings Tweaks
     Rounded Corners
     Rounded Window Corners Reborn
     Search Light
     SettingsCenter
     # 数值设置为 4
     Status Area Horizontal Spacing
     Top Bar Organizer
     Tray Icons: Reloaded
     User Avatar In Quick Settings
     Window Gestures
     VirtualBox applet
     # https://github.com/Sominemo/Fildem-Gnome-45
     
     
     # 应用主题
     gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
     gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
     gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
     gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
     gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'
     gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/WhiteSur/WhiteSur-timed.xml'
     org.gnome.shell.extensions.just-perfection events-button false
     gsettings set org.gnome.shell.extensions.just-perfection world-clock false
     gsettings set org.gnome.shell.extensions.just-perfection weather false
     gsettings set org.gnome.shell.extensions.just-perfection window-demands-attention-focus true
     gsettings set org.gnome.shell.extensions.just-perfection startup-status 0
     gsettings set org.gnome.desktop.interface show-battery-percentage true
     gsettings set org.gnome.mutter center-new-windows true
     gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
     gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
     gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
     gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DASHES'
     gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
     gsettings set org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
     gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
     gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
     gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
     gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
     
     # dash-to-dock
     gsettings list-recursively org.gnome.shell.extensions.dash-to-dock
     gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
     gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.5
     gsettings set org.gnome.shell.extensions.dash-to-dock show-trash true
     gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
     gsettings set org.gnome.shell.extensions.dash-to-dock shift-click-action 'minimize'
     gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
     gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DASHES'
     gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
     gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true
     gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
     gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.6
     gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(255,255,255)'
     
     gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(119,118,123)'
     
     # blur-my-shell
     gsettings list-recursively org.gnome.shell.extensions.blur-my-shell
     org.gnome.shell.extensions.blur-my-shell.panel force-light-text true
     gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 1
     gsettings set org.gnome.shell.extensions.blur-my-shell.hidetopbar compatibility true
     gsettings set org.gnome.shell.extensions.blur-my-shell.overview style-components 1
     gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 2
     gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 1
     gsettings set org.gnome.shell.extensions.blur-my-shell.applications blur true
     gsettings set org.gnome.shell.extensions.blur-my-shell.applications dynamic-opacity false
     gsettings set org.gnome.shell.extensions.blur-my-shell.applications enable-all true
     gsettings set org.gnome.shell.extensions.blur-my-shell hacks-level 2
     
     gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 2
     gsettings set org.gnome.shell.extensions.blur-my-shell.overview style-components 2
     gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder style-dialogs 3
     gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 2
     
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
     ```
   
2. **主题与图标**  
   
   - 下载主题（如 [Arc](https://github.com/NicoHood/arc-theme)）：  
     ```bash
     sudo dnf install arc-theme
     
     yaru-gtk4-theme.noarch
     yaru-gtksourceview-theme.noarch
     yaru-icon-theme.noarch
     yaru-sound-theme.noarch
     
     
     # 主题美化，参考 https://www.gnome-look.org/browse?ord=rating
     git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
     sed -i 's/\$opacity: if([^;]*);/\$opacity: 1;/g' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss
     ./install.sh       # 同时安装Dark/Light两种主题
     ./tweaks.sh -f flat
     sudo ./tweaks.sh -g
     sudo ./tweaks.sh -g -b "my picture.jpg"
     # 授予全局访问 GTK 配置和主题文件的权限
     # 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-3.0 目录。该目录包含 GTK 3 的配置文件（如主题、图标、字体设置等）。
     sudo flatpak override --filesystem=xdg-config/gtk-3.0
     # 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-4.0 目录。
     sudo flatpak override --filesystem=xdg-config/gtk-4.0
     # 将 WhiteSur 主题包连接到 Flatpak 仓库
     ./tweaks.sh -F
     
     git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
     ./install.sh
     git clone https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1
     ./install.sh
     git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
     sudo ./install-gnome-backgrounds.sh
     
     # https://github.com/lassekongo83/adw-gtk3
     dnf install adw-gtk3-theme
     sudo flatpak override --filesystem=xdg-data/themes
     sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3 && sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3-dark
     
     
     # MacOS 3D 作者 https://m.youtube.com/watch?v=2-uPje43Zg8&pp=ygUJZmVkb3JhIDQy
     使用 Evolve-core 应用程序应用主题：https://github.com/arcnations-united/evolve-core
     GTK Theme: https://www.pling.com/p/2278127/
     ICONS Theme: https://www.pling.com/p/2023325/
     SHELL Theme: https://www.pling.com/p/2278187/
     https://github.com/Macintosh98/MacOS-3D-Cursor
     git clone https://github.com/Macintosh98/MacOS-3D-Cursor.git
     图标放在 	~/.icons/
     Shell 和 GTK主题放在		~/.themes/
     
     
     /usr/share/themes/
     /usr/local/share/themes/  # 本地安装的第三方主题
     ~/.themes/  # 传统路径（部分旧版GNOME使用）
     ~/.local/share/themes/  # 新版GNOME推荐路径
     gsettings set org.gnome.desktop.interface cursor-theme 'MacOS-3D-Cursor-Light'
     gsettings set org.gnome.desktop.interface icon-theme 'MacOS-3D'
     gsettings set org.gnome.shell.extensions.user-theme name 'MacOS-3D-Shell'
     gsettings set org.gnome.desktop.interface gtk-theme 'MacOS-3D-Gtk'
     gsettings set org.gnome.desktop.wm.preferences theme 'MacOS-3D-Gtk'
     
     gsettings set org.gnome.desktop.interface cursor-theme 'MacOS-3D-Cursor-Dark'
     gsettings set org.gnome.desktop.interface icon-theme 'MacOS-3D'
     gsettings set org.gnome.shell.extensions.user-theme name 'MacOS-3D-Shell'
     gsettings set org.gnome.desktop.interface gtk-theme 'MacOS-3D-Gtk-Dark'
     gsettings set org.gnome.desktop.wm.preferences theme 'MacOS-3D-Shell'
     
     
     sudo flatpak override --filesystem=~/.themes
     sudo flatpak override --filesystem=~/.icons
     sudo flatpak override --filesystem=~/.local/share/icons
     ls ~/.themes
     ls ~/.icons
     ls ~/.local/share/icons
     # sudo flatpak override --env=GTK_THEME=WhiteSur-Dark
     # sudo flatpak override --env=ICON_THEME=WhiteSur-Dark
     # 列出所有应用，获取 <应用ID>
     flatpak list --app
     # 对于单个应用程序
     sudo flatpak override org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
     sudo flatpak override org.fedoraproject.MediaWriter --env=ICON_THEME=WhiteSur-dark
     # 若需更深度适配（如 Kvantum）
     flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
     # 允许读写取系统主题，默认权限为 读写（Read-Write），应用可以读取和修改目录中的文件。
     # ro 表示 只读（Read-Only）。它的作用是限制 Flatpak 应用对指定目录的访问权限，仅允许 读取 文件，而 禁止写入或修改。
     flatpak override --user --filesystem=~/.themes:ro  # 若使用用户级主题
     # 指定主题名称（如 WhiteSur-Light）
     flatpak override --user --env=GTK_THEME=WhiteSur-Light
     # 例如强制 Media Writer 使用 GTK 主题
     flatpak override --user org.fedoraproject.MediaWriter --env=QT_STYLE_OVERRIDE=kvantum
     
     flatpak override --user org.fedoraproject.MediaWriter --env=ICON_THEME=WhiteSur-dark
     flatpak override --user org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
     flatpak override --user org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
     
     flatpak override --user cn.apipost.apipost --env=ICON_THEME=WhiteSur-dark
     flatpak override --user cn.apipost.apipost --env=GTK_THEME=WhiteSur-Dark
     
     flatpak run --env=GTK_THEME=WhiteSur-Light org.fedoraproject.MediaWriter
     flatpak run org.fedoraproject.MediaWriter
     # Breeze, Windows, Fusion
     flatpak run --env=QT_STYLE_OVERRIDE=Breeze org.fedoraproject.MediaWriter
     
     flatpak run --env=GTK_THEME=WhiteSur-Dark cn.apipost.apipost
     flatpak run cn.apipost.apipost
     
     flatpak run --env=QT_STYLE_OVERRIDE=gtk3 com.obsproject.Studio
     # 安装主机依赖
     locate libcanberra-gtk-module
     sudo dnf install libcanberra-gtk3 PackageKit-gtk3-module
     sudo dnf -y install libcanberra-gtk3
     
     flatpak run --command=gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark' org.fedoraproject.MediaWriter
     # 列出所有已安装的 Flatpak 应用和运行时
     flatpak list
     # 查看应用使用的运行时等信息
     flatpak list --app
     # 查看所有应用的全局覆盖配置
     flatpak override --show
     flatpak override org.fedoraproject.MediaWriter --show
     sudo flatpak override --reset
     sudo flatpak override org.fedoraproject.MediaWriter --reset
     flatpak run --env=GTK_DEBUG=all <应用ID>
     flatpak run --env=GTK_DEBUG=all org.fedoraproject.MediaWriter
     
     flatpak info org.fedoraproject.MediaWriter
     flatpak info com.obsproject.Studio
     flatpak info org.videolan.VLC
     flatpak info cn.apipost.apipost
     flatpak search org.gtk.Gtk3theme
     flatpak search QAdwaitaDecorations
     dnf search QAdwaitaDecorations
     dnf search Decorations
     sudo dnf install -y qadwaitadecorations-qt5 qadwaitadecorations-qt6
     
     # 在 Linux 中的 Flatpak 应用程序上应用 GTK 系统主题，参考 https://cn.linux-console.net/?p=18267
     # 安装 Kvantum 软件
     sudo dnf install -y qt5ct qt6ct kvantum
     flatpak install -y org.kde.KStyle.Kvantum
     # 参考 https://wiki.archlinuxcn.org/wiki/%E7%BB%9F%E4%B8%80_Qt_%E5%92%8C_GTK_%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E7%9A%84%E5%A4%96%E8%A7%82
     flatpak install flathub org.kde.KStyle.Adwaita
     kvantummanager  # 在 "Change/Delete Theme" 中微调 WhiteSur 参数
     sudo flatpak override --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro org.fedoraproject.MediaWriter
     ```
     
   - 图标包（如 [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)）：  
     ```bash
     sudo dnf install papirus-icon-theme
     ```
     
   - 在 `Gnome Tweaks` 中启用主题和图标。
   
     ```bash
     # 应用主题
     gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
     gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
     gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
     gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
     gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'
     gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/WhiteSur/WhiteSur-timed.xml'
     gsettings get org.gnome.desktop.background picture-uri
     ```

---

### **六、安全与网络**
1. **防火墙配置**  
   ```bash
   # Fedora Workstation 默认已启用 firewalld（动态防火墙守护进程），无需额外安装防火墙，但可能需要根据需求调整配置。
   
   # 检查状态
   sudo firewall-cmd --state  # 查看是否运行
   sudo firewall-cmd --list-all  # 查看当前规则
   # 启用/禁用
   sudo systemctl enable --now firewalld  # 启用并立即启动
   sudo systemctl disable --now firewalld  # 禁用（不推荐）
   # 开放端口（例如 HTTP）
   sudo firewall-cmd --add-service=http --permanent  # 永久允许 HTTP
   sudo firewall-cmd --add-port=8080/tcp --permanent # 或直接指定端口
   sudo firewall-cmd --reload  # 重载配置
   # 阻止端口
   sudo firewall-cmd --remove-service=ssh --permanent  # 阻止 SSH
   sudo firewall-cmd --reload
   # 图形化工具
   sudo dnf install firewall-config  # 安装图形界面
   firewall-config  # 运行（需 root 权限）
   ```
   
2. **SSH 服务**  
   ```bash
   sudo dnf install openssh-server
   sudo systemctl enable --now sshd
   ```

---

### **七、其他实用调整**
1. **DNF 提速**  
   编辑 `/etc/dnf/dnf.conf`，添加：  
   
   ```ini
   # 择网络延迟最低的镜像。但 延迟低 ≠ 下载速度快，还需要镜像带宽高
   cat /etc/dnf/dnf.conf
   # 查看当前 DNF 配置
   # 如果已手动配置高质量镜像（如国内清华、阿里源）。则不建议配置。延迟和带宽均最优
   
   fastestmirror=True
   max_parallel_downloads=10
   
   
   # 测试默认配置的下载速度
   time sudo dnf update --downloadonly
   # 测试启用优化后的速度
   time sudo dnf update --downloadonly
   ```
   
2. **电源管理**  
   ```bash
   sudo dnf install tlp tlp-rdw  # 笔记本续航优化，默认已安装，但没有启用
   systemctl status tlp
   sudo systemctl enable tlp
   sudo systemctl start tlp
   ```

---

### **注意事项**
- 如果使用 Secure Boot，部分内核模块（如 NVIDIA 驱动）需手动签名。
- 游戏用户可安装 `Proton-GE` 和 `Lutris` 优化兼容性。
- 虚拟机用户建议安装 `VirtualBox` 或配置 `KVM/QEMU`。

根据实际需求选择配置项，建议操作前备份重要数据。







在 Fedora 中查看系统配置（硬件和软件信息）可以通过多种方式实现。以下是常用方法整理：

---

### **一、查看系统基本信息**
#### 1. **操作系统和内核版本**
```bash
# 显示系统名称、版本、内核和架构
hostnamectl

# 或仅查看内核版本
uname -a
```

#### 2. **系统运行时间与负载**
```bash
uptime            # 查看运行时间和平均负载
cat /proc/loadavg # 查看系统负载详情
```

---

### **二、查看硬件信息**
#### 1. **CPU 信息**
```bash
lscpu                 # 显示 CPU 架构、核心数、线程等
```

#### 2. **内存信息**
```bash
free -h               # 内存和交换分区使用情况（人类可读格式）
```

#### 3. **硬盘和存储**
```bash
lsblk                 # 列出所有块设备（硬盘、分区、挂载点）
df -h                 # 查看磁盘空间使用情况
sudo fdisk -l         # 显示分区表详细信息（需 root 权限）
```

#### 4. **显卡信息**
```bash
lspci | grep -i vga   # 查看显卡型号
# 
sudo dnf install lshw
sudo lshw -C display  # 显示显卡详细信息（需安装 `lshw`）
```

---

### **三、查看软件配置**
#### 1. **已安装软件包**
```bash
# 列出所有已安装的 RPM 包
dnf list installed

# 检查某个软件是否安装（如查看是否安装 Docker）
dnf list installed | grep docker
```

#### 2. **系统服务**
```bash
systemctl list-unit-files --type=service  # 所有服务状态
systemctl status sshd                    # 查看指定服务（如 SSH）
```

#### 3. **环境变量**
```bash
printenv          # 显示所有环境变量
echo $PATH        # 查看特定变量（如 PATH）
```

---

### **四、查看网络配置**
#### 1. **IP 地址和网络接口**
```bash
ip a              # 显示所有网络接口的 IP 和状态
ifconfig          # 传统方式（需安装 `net-tools`）
```

#### 2. **路由表**
```bash
ip route          # 查看路由表
route -n          # 传统方式（需 `net-tools`）
```

#### 3. **DNS 配置**
```bash
cat /etc/resolv.conf   # 查看 DNS 服务器
nmcli device show      # 显示 NetworkManager 管理的网络详情
```

---

### **五、图形化工具**
#### 1. **GNOME 系统监控**
   - 打开 `gnome-system-monitor`（资源选项卡可查看 CPU、内存、磁盘使用率）

#### 2. **系统设置**
   - 进入 `Settings` → `About`，查看系统版本、内存、CPU 等基本信息。

#### 3. **硬件信息工具**
```bash
# 安装图形化硬件检测工具
sudo dnf install hardinfo
hardinfo           # 启动工具查看详细硬件报告
```

---

### **六、高级工具**
#### 1. **DMI 信息（主板、BIOS）**
```bash
sudo dmidecode -t bios    # 查看 BIOS 信息
sudo dmidecode -t system  # 查看主板和系统型号
```

#### 2. **内核日志**
```bash
dmesg | less      # 查看内核启动和硬件检测日志
journalctl -k     # 通过 systemd 查看内核日志
```

---

### **总结**
- **快速查看基础信息**：`hostnamectl` + `lscpu` + `free -h`  
- **详细硬件报告**：`lshw` 或 `hardinfo`（图形化）  
- **网络诊断**：`ip a` + `ip route` + `nmcli`  
- **软件管理**：`dnf list installed` + `rpm -qa`  

根据需求选择对应命令，如需保存配置信息，可将输出重定向到文件：
```bash
hostnamectl > system-info.txt
lscpu >> system-info.txt
```







以下是查看 Fedora 仓库配置（repo 源）的详细方法，帮助你识别需要替换为国内镜像的仓库：

---

### **一、查看当前启用的仓库列表**
```bash
# 列出所有已启用的仓库（名称和状态）
sudo dnf repolist

# 查看所有仓库（包括已禁用）
sudo dnf repolist all

# 示例输出：
# repo-id        repo-name                          status
# fedora         Fedora 41 - x86_64                 enabled
# rpmfusion-free RPM Fusion for Fedora 41 - Free    enabled
```

---

### **二、查看仓库详细配置**
仓库配置文件存储在 `/etc/yum.repos.d/` 目录中，每个仓库对应一个 `.repo` 文件：

#### 1. **直接查看配置文件**
```bash
# 列出所有仓库配置文件
ls /etc/yum.repos.d/

# 查看具体仓库配置（例如官方 fedora.repo）
cat /etc/yum.repos.d/fedora.repo
```

#### 2. **关键配置字段**
在 `.repo` 文件中，重点关注以下字段：
- `baseurl`：仓库的直接地址（若未注释，优先级高于 `metalink`）
- `metalink`：动态镜像列表地址（自动选择最佳镜像）
- `mirrorlist`：旧版镜像列表地址（Fedora 已逐步用 `metalink` 替代）
- `enabled`：是否启用仓库（1/0 或 true/false）

---

### **三、判断是否需要替换为国内镜像**
#### **场景 1：使用 `metalink`（默认配置）**
- **现状**：默认配置使用 `metalink`，理论上会自动选择最近的镜像。
- **问题**：自动选择可能不准确，或国内镜像未被正确识别。
- **解决方案**：  
  替换 `metalink` 为国内镜像的 `baseurl`（见下文）。

#### **场景 2：已配置 `baseurl`**
- **现状**：如果 `baseurl` 指向国外服务器（如 `http://download.fedoraproject.org`），需替换为国内镜像地址。
- **检查命令**：
  ```bash
  grep -E "baseurl|metalink" /etc/yum.repos.d/*.repo
  ```

---

### **四、国内镜像替换参考**
#### 1. **主流国内镜像站地址**
| 镜像站   | Fedora 仓库地址（替换 `$releasever` 为版本号）               |
| -------- | ------------------------------------------------------------ |
| 清华大学 | `https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/$releasever/Everything/x86_64/os/` |
| 阿里云   | `https://mirrors.aliyun.com/fedora/releases/$releasever/Everything/x86_64/os/` |
| 中科大   | `https://mirrors.ustc.edu.cn/fedora/releases/$releasever/Everything/x86_64/os/` |

#### 2. **替换方法**
以 **清华大学镜像** 为例，修改 `fedora.repo` 和 `fedora-updates.repo`：
```bash
# 备份原文件
sudo cp /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.bak

# 编辑文件，注释原有 metalink，添加 baseurl
sudo nano /etc/yum.repos.d/fedora.repo
```
修改内容示例：
```ini
[fedora]
name=Fedora $releasever - $basearch
# 注释原 metalink
#metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/$releasever/Everything/$basearch/os/
enabled=1
...
```

---

### **五、测试镜像速度**
#### 1. **手动测试**
```bash
# 选择镜像 URL（例如测试清华镜像速度）
curl -I https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/41/Everything/x86_64/os/repodata/repomd.xml

# 观察响应时间和状态码（200 表示正常）
```

#### 2. **自动选择最佳镜像（推荐）**
安装插件并自动生成最快镜像配置：
```bash
# 安装 fastestmirror 插件
sudo dnf install dnf-plugin-fastestmirror

# 从 Fedora 29 开始，fastestmirror 功能已直接集成到 dnf 核心中，无需单独安装插件。
sudo nano /etc/dnf/dnf.conf


# 清理缓存并测试
sudo dnf clean all
sudo dnf makecache
```

---

### **六、其他注意事项**
1. **第三方仓库**（如 RPM Fusion）：
   - 同样需要替换其 `baseurl` 或 `metalink`（参考镜像站提供的非官方仓库地址）。
2. **Flatpak 镜像**：
   - 若使用 Flatpak，需单独配置 Flathub 国内镜像（例如清华 Flathub 镜像）。
3. **版本变量**：
   - `$releasever` 会自动解析为 Fedora 版本号（如 41），`$basearch` 为架构（如 x86_64）。

---

### **总结步骤**
1. 通过 `dnf repolist` 和 `cat /etc/yum.repos.d/*.repo` 确认当前仓库配置。
2. 替换 `metalink` 为国内镜像的 `baseurl`。
3. 使用 `dnf makecache` 测试新配置是否生效。
4. 对第三方仓库（如 RPM Fusion）重复上述操作。









您的问题非常关键——**在 Fedora 41 中，`dnf-plugin-fastestmirror` 这个包确实不存在**。感谢您指出这个错误！以下是更准确的解决方案和背景说明：

---

### **错误原因**
- **历史变化**：在旧版 Fedora 中（如 Fedora 28 之前），`fastestmirror` 是一个独立插件（包名为 `dnf-plugin-fastestmirror`）。
- **现状**：从 Fedora 29 开始，`fastestmirror` 功能已直接集成到 `dnf` 核心中，**无需单独安装插件**。

---

### **如何启用自动选择最快镜像**
#### 1. **编辑 DNF 全局配置**
```bash
sudo nano /etc/dnf/dnf.conf
```

#### 2. **添加以下配置项**
```ini
# 在 [main] 部分下面添加如下内容
fastestmirror=True       # 启用自动选择最快镜像
max_parallel_downloads=10 # 加速下载（根据网络调整数值）
```

#### 3. **清理缓存并测试**
```bash
sudo dnf clean all
sudo dnf makecache       # 强制刷新仓库元数据
sudo dnf update          # 测试下载速度
```

---

### **验证 fastestmirror 是否生效**
```bash
# 查看 DNF 调试日志中的镜像选择过程
sudo dnf --verbose update | grep -i "fastestmirror"
```

输出中应包含类似以下内容：
```
DEBUG: Using fastest mirror from https://mirrors.fedoraproject.org/metalink?...
```

---

### **手动指定镜像（备选方案）**
如果自动选择不理想，可手动替换仓库配置（以清华镜像为例）：
```bash
# 修改官方仓库配置
sudo sed -i 's|^metalink=|#metalink=|g' /etc/yum.repos.d/fedora*.repo
sudo sed -i 's|^#baseurl=|baseurl=|g' /etc/yum.repos.d/fedora*.repo
sudo sed -i 's|http://download.example/pub/fedora/|https://mirrors.tuna.tsinghua.edu.cn/fedora/|g' /etc/yum.repos.d/fedora*.repo
```

