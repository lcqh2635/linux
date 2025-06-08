#!/bin/bash

# Fedora GNOME 42 初始优化配置脚本
# 功能：自动安装并配置加速镜像、工具、依赖包、开发环境配置
# 使用方法：chmod +x setup.sh && ./setup.sh

# 检查是否为root用户
# if [ "$(id -u)" -ne 0 ]; then
#     echo "请使用root用户或通过sudo运行此脚本"
#     exit 1
# fi

# gsettings 修改的是当前用户的 GNOME 配置，必须由 桌面用户（而非 root）执行。如果脚本通过 sudo 运行，命令会被忽略。
# 设置新窗口居中显示
gsettings set org.gnome.mutter center-new-windows true
# 设置电量百分比
gsettings set org.gnome.desktop.interface show-battery-percentage true
# 设置窗口按钮位置 (右)
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# 系统外观主题和Gnome扩展插件优化
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

## 1. 系统基础配置 ==============================================
# 安装插件
sudo dnf install -y dnf-plugins-core
# 启用自动镜像选择，直接编辑配置文件
echo "
fastestmirror=True
deltarpm=True
max_parallel_downloads=10
" | sudo tee -a /etc/dnf/dnf.conf

# grep "fastestmirror" /etc/dnf/dnf.conf
# cat /etc/dnf/dnf.conf

# 测试下载速度
# time sudo dnf install -y neofetch

# 清华 Fedora 镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/fedora/
# 配置dnf以加快软件下载速度（启用最快的镜像）
echo "使用清华源配置Fedora的加速镜像..."
sudo sed -e 's|^metalink=|#metalink=|g' \
    -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' \
    -i.bak \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo

# 清华 RPMFusion 镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/rpmfusion/
# 1、首先安装提供基础配置文件和 GPG 密钥的 rpmfusion-*.rpm。
echo "使用清华源配置RPM Fusion的加速镜像..."
sudo yum install -y --nogpgcheck https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# 2、安装成功后，修改链接指向镜像站   
sudo sed -e 's!^metalink=!#metalink=!g' \
         -e 's!^mirrorlist=!#mirrorlist=!g' \
         -e 's!^#baseurl=!baseurl=!g' \
         -e 's!https\?://download1\.rpmfusion\.org/!https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/!g' \
         -i.bak /etc/yum.repos.d/rpmfusion*.repo
    
# 最后运行 sudo dnf makecache 生成缓存
dnf clean all && dnf makecache

# 更新系统并升级所有已安装的包
echo "开始更新系统并升级所有已安装的包..."
sudo dnf update -y && sudo dnf upgrade -y
echo "系统更新、升级完成..."

# Fedora默认安装了Flatpak，只要配置Flatpak加速镜像即可
echo "开始配置Flatpak加速镜像..."
# 添加 Flathub 官方仓库
sudo flatpak remote-add --if-not-exists flathub https://mirrors.ustc.edu.cn/flathub
# 修改 Flathub 仓库地址为国内镜像
# 1、上海交大 Flatpak 镜像源 https://mirrors.sjtug.sjtu.edu.cn/docs/flathub
# sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
# 2、中科大 Flatpak 镜像源（处于测试阶段） https://mirrors.ustc.edu.cn/help/flathub.html
# sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub

# 安装多媒体编解码器
echo "安装多媒体编解码器..."
# 安装fedora的多媒体组，以下内容参考 https://rpmfusion.org/Howto/Multimedia
sudo dnf group install -y multimedia

sudo dnf install -y \
mozilla-openh264 \
mozilla-ublock-origin

# 安装必要的多媒体编解码器以支持高效的视频解码	about:support
# dnf list gstreamer1-plugin*
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} \
               gstreamer1-libav \
               gstreamer1-plugin-openh264 \
               gstreamer1-plugins-bad-freeworld
# FFmpeg-Free 是 Fedora 默认提供的一个受限版本，仅包含开源且无专利限制的编解码器。
# FFmpeg 是一个功能强大的多媒体处理工具集，支持视频、音频的编码、解码、转码、流媒体传输等功能。
# 它支持广泛的编解码器（如 H.264、HEVC、AAC 等），包括一些专利保护的编解码器。 
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
# 安装 VA-API 和 VDPAU 驱动，一般默认已安装
# dnf list mesa*		# 查看 Mesa 驱动程序 freeworld 和原始驱动程序
sudo dnf install -y mesa-va-drivers mesa-vdpau-drivers libva-utils
# swap 命令为替换操作
# Mesa 是一个开源的图形驱动框架，提供了对 OpenGL、Vulkan、VA-API 和 VDPAU 等图形 API 的支持。
# Fedora 默认的 Mesa 驱动遵循严格的开源许可证，因此不包含对某些专利保护的编解码器（如 H.264 和 HEVC）的支持。
# Fedora 默认安装的是开源的 mesa-va-drivers 和 mesa-vdpau-drivers，这些驱动完全符合开源社区的标准，但可能缺少对某些专有编解码器（如 H.264 或 HEVC）的支持。
# RPM Fusion 提供了名为 mesa-*-drivers-freeworld 的替代版本，它们是基于 Mesa 的增强版本，支持更多的专有编解码器（如 H.264 和 HEVC）和性能优化
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld --allowerasing
sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld --allowerasing
sudo dnf swap -y mesa-vulkan-drivers mesa-vulkan-drivers-freeworld --allowerasing
sudo dnf install -y libva-utils vulkan-tools		# 提供 vainfo 命令的包
# vainfo | grep -E 'H264|H265'
# vulkaninfo | grep "GPU"

## 5. 开发环境配置 =============================================

# 配置Github访问加速
# 网站国内可用 DNS 测试 ping https://ping.chinaz.com/www.youtube.com
echo "
# GitHub Start
20.205.243.166    github.com
185.199.109.133    raw.githubusercontent.com
103.200.30.143    archive.org
# GitHub End
" | sudo tee -a /etc/hosts

# 安装常用应用
echo "安装常用应用程序..."
sudo dnf install -y \
    git wl-clipboard \
    wget curl htop \
    unzip p7zip \
    fastfetch \
    flatpak \
    timeshift \
    evolution \
    gnome-tweaks \
    gnome-extensions-app \
    libreoffice-langpack-zh-Hans
# evolution配置qq邮箱授权码： embwnsuwkdjrebge

# 安装 Tauri 2 运行环境依赖包
sudo dnf check-update
sudo dnf install -y webkit2gtk4.1-devel \
  openssl-devel \
  curl \
  wget \
  file \
  libappindicator-gtk3-devel \
  librsvg2-devel
sudo dnf group install -y "c-development"
# dnf install -y @c-development
# Development Tools  是一个预定义的软件包组，包含一组常用的开发工具和库，用于支持软件开发工作。
# 它旨在为开发者提供一个基础的开发环境，而无需手动安装每个工具。
# sudo dnf group list		# 查看可用的软件包组
sudo dnf install -y @development-tools


# 配置 Git
# git config --global user.name "龙茶清欢"
# git config --global user.email "2320391937@qq.com"
# ssh-keygen -t rsa -b 4096 -C "2320391937@qq.com"
# 需要安装 wl-clipboard 工具
# cat ~/.ssh/id_rsa.pub | wl-copy
# 配置 Gitee 密钥	https://gitee.com/profile/sshkeys
# 配置 Github 密钥	https://github.com/settings/keys

# 安装Node.js
echo "安装Node.js..."
sudo dnf install -y nodejs npm
echo 你刚安装的 nodejs 版本号为：$(node --version)
echo 你刚安装的 npm 版本号为：$(npm --version)
# 最新地址 淘宝 NPM 镜像站喊你切换新域名啦!
npm config set registry https://registry.npmmirror.com
# 安装 Bun
sudo npm install -g bun
echo 你刚安装的 bun 版本号为：$(bun --version)
# 将 bunfig.toml 作为隐藏文件添加到用户主目录
echo '[install]
# 使用阿里云加速仓库，仓库地址可从阿里云官方获取，地址为 https://developer.aliyun.com/mirror/
registry = "https://registry.npmmirror.com/"
' >> ~/.bunfig.toml

# 安装 Rust
echo 'export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup' >> ~/.bash_profile
echo 'export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.bash_profile
echo "安装rust..."
# 安装 rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# 加载环境变量
source $HOME/.cargo/env
rustup update
# rustup self uninstall
#  配置 Cargo 国内加速镜像源
mkdir -p ~/.cargo && cat >> ~/.cargo/config.toml << 'EOF'
# 配置 Cargo 国内加速镜像源，可选：ustc、tuna、sjtu、aliyun、rsproxy
[source.crates-io]
replace-with = 'ustc'

# 中国科学技术大学镜像
[source.ustc]
registry = "https://mirrors.ustc.edu.cn/crates.io-index"

# 清华大学镜像
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"

# 上海交通大学镜像
[source.sjtu]
registry = "https://mirrors.sjtug.sjtu.edu.cn/git/crates.io-index"

# 阿里云镜像
# 使用稀疏协议（sparse）减少元数据下载量，大幅加速
[source.aliyun]
registry = "sparse+https://mirrors.aliyun.com/crates.io-index/"

# Rust官方中文社区镜像（仅限中国）
[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"
EOF

# 验证安装
echo 你刚安装的 rust 版本号为：$(rustc --version)
echo 你刚安装的 cargo 版本号为：$(cargo --version)

# 安装 SDKMAN!
# echo "安装SDKMAN..."
# curl -s "https://get.sdkman.io" | bash
# source "/home/lcqh/.sdkman/bin/sdkman-init.sh"
# echo 你刚安装的 sdkman 版本号为：$(sdk version)
# sdk install java
# 安装 Maven/Gradle
# sdk install maven
# sdk install mvnd
# sdk install gradle

# 安装 JDK（示例：安装 Temurin JDK 17）https://docs.fedoraproject.org/en-US/quick-docs/installing-java/
sudo dnf install -y java-21-openjdk java-latest-openjdk
# dnf list java-*-openjdk
# 在 Java 版本之间切换
# sudo alternatives --config java
# nautilus admin:/usr/lib/jvm
sudo dnf install -y maven gradle
echo 你刚安装的 java 版本号为：$(java --version)
echo 你刚安装的 mvn 版本号为：$(mvn --version)
echo 你刚安装的 gradle 版本号为：$(gradle --version)

# 安装Docker
echo "安装podman..."
# 安装核心组件（包含 rootless 支持）
sudo dnf install -y podman
# 验证安装
echo 你刚安装的 podman 版本号为：$(podman --version)
# 后台运行 Nginx
# podman run -d --name my_nginx -p 8080:80 nginx
# 查看运行中的容器
# podman ps
# 查看所有容器（包括已停止的）
# podman ps -a
# 查看 Podman 系统服务（适用于 rootful 模式）
# systemctl status podman
# systemctl start podman
# Rootless 用户级 socket
# systemctl --user enable --now podman.socket

# 安装VirtualBox
echo "安装VirtualBox..."
sudo dnf install -y vagrant VirtualBox virtualbox-guest-additions

## 6. 用户个性化设置 ===========================================

# 设置中文locale
echo "设置中文locale..."
sudo dnf install -y langpacks-zh_CN
localectl set-locale LANG=zh_CN.UTF-8

# 安装 TLP 优化续航
echo "设置TLP 优化续航..."
sudo dnf install -y tlp tlp-rdw
sudo systemctl enable --now tlp

# 启用并启动防火墙服务
echo "启用和启动防火墙..."
# 在 Fedora 中，默认的防火墙 firewalld 已安装，但还需要自行安装图形化的防火墙管理工具
sudo dnf install firewall-config -y
sudo systemctl enable --now firewalld
# 配置防火墙规则（例如允许HTTP和HTTPS）
echo "配置防火墙规则..."
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

## 7. 清理和完成 ==============================================

# 清理缓存
echo "清理缓存..."
dnf autoremove -y
dnf clean all

# 完成提示
echo "==================================================="
echo "Fedora GNOME 42 优化配置完成！"
echo "建议操作："
echo "1. 重启系统使所有更改生效"
echo "2. 使用GNOME Tweaks进一步自定义桌面"
echo "3. 检查系统设置中的区域和语言选项"
echo "==================================================="

# sudo dnf install -y zsh zsh-syntax-highlighting zsh-autosuggestions
