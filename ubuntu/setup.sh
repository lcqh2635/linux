#!/bin/bash

# 检查是否为root用户
if [ "$(id -u)" -ne 0 ]; then
    echo "请使用root用户或通过sudo运行此脚本"
    exit 1
fi

echo "开始优化Ubuntu 25.04系统配置..."

# 1. 更新系统
echo "1. 更新系统软件包..."
sudo apt update && sudo apt upgrade -y
apt install -y software-properties-common

# 2. 安装常用工具
echo "2. 安装常用工具..."
apt install -y vim git curl wget htop net-tools tree unzip zip \
    gnupg2 ca-certificates lsb-release ubuntu-restricted-extras \
    ffmpeg neofetch

# 3. 配置时区
echo "3. 配置时区为亚洲/上海..."
timedatectl set-timezone Asia/Shanghai

# 4. 配置中文环境支持
echo "4. 配置中文环境支持..."
apt install -y language-pack-zh-hans
update-locale LANG=zh_CN.UTF-8 LC_MESSAGES=POSIX

# 5. 配置APT镜像源（使用清华源）
echo "5. 配置APT镜像源为清华源..."
SOURCES_LIST="/etc/apt/sources.list"
if [ -f "$SOURCES_LIST" ]; then
    cp "$SOURCES_LIST" "$SOURCES_LIST.bak"
    echo "已备份原sources.list文件"
fi

cat > "$SOURCES_LIST" <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-security main restricted universe multiverse
EOF

# 先安装软件源的许可密钥
sudo apt install debian-archive-keyring
sudo apt install apt-transport-https ca-certificates
# 添加debian12官方软件源，并使用阿里云加速镜像仓库
echo "
Types: deb
URIs: http://mirrors.aliyun.com/debian/
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: http://security.debian.org/debian-security/
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
" | sudo tee -a /etc/apt/sources.list.d/debian.sources

# 替换ubuntu官方的软件仓库，改用阿里云加速镜像仓库
echo "
Types: deb
URIs: http://mirrors.aliyun.com/ubuntu/
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
Types: deb
URIs: http://security.ubuntu.com/ubuntu/
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
" | sudo tee /etc/apt/sources.list.d/ubuntu.sources


echo "" | sudo tee /etc/apt/sources.list.d/ubuntu.sources

sudo sed -i "s@http://.*archive.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list

echo "==========开始安装gnome相关软件=========="
# 下载系统基础工具，安装GNOME插件和扩展
apt search gnome-shell-extension*
sudo apt install -y \
gnome-tweaks gnome-software \
gnome-shell-extension-prefs \
gnome-shell-extension-manager

gnome-shell-extensions/noble
gnome-shell-extension-gsconnect/noble

echo "==========开始安装flatpak相关软件=========="
# 安装并配置 flatpak
sudo apt install -y flatpak gnome-software-plugin-flatpak gnome-software-plugin-snap
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub https://mirrors.ustc.edu.cn/flathub
# 配置 flatpak 上海交大下载加速镜像仓库
flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
# 卸载 snap软件商店和默认snap火狐浏览器
sudo snap remove snap-store firefox


sudo add-apt-repository ppa:papirus/papirus
sudo apt install qt5-style-kvantum qt6-style-kvantum

apt update

# 6. 配置SSH服务
echo "6. 配置SSH服务..."
apt install -y openssh-server
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# 7. 配置防火墙
echo "7. 配置防火墙..."
apt install -y ufw
ufw allow 22
ufw allow 80
ufw allow 443
ufw --force enable

# 8. 优化系统参数
echo "8. 优化系统参数..."
SYSCTL_CONF="/etc/sysctl.conf"
echo "# 优化网络参数" >> "$SYSCTL_CONF"
echo "net.ipv4.tcp_fin_timeout = 30" >> "$SYSCTL_CONF"
echo "net.ipv4.tcp_tw_reuse = 1" >> "$SYSCTL_CONF"
echo "net.ipv4.tcp_tw_recycle = 1" >> "$SYSCTL_CONF"
echo "net.ipv4.tcp_keepalive_time = 1200" >> "$SYSCTL_CONF"
echo "net.ipv4.ip_local_port_range = 10000 65000" >> "$SYSCTL_CONF"
echo "net.core.somaxconn = 8192" >> "$SYSCTL_CONF"
echo "net.core.rmem_max = 16777216" >> "$SYSCTL_CONF"
echo "net.core.wmem_max = 16777216" >> "$SYSCTL_CONF"
sysctl -p

# 9. 配置Bash别名
echo "9. 配置Bash别名..."
ALIASES_FILE="/etc/profile.d/aliases.sh"
cat > "$ALIASES_FILE" <<EOF
# 自定义别名
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias hg='history | grep'
alias df='df -h'
alias du='du -h'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ports='netstat -tulanp'
alias update='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt autoremove -y && sudo apt clean'
EOF

source "$ALIASES_FILE"

# 10. 配置vim
echo "10. 配置vim..."
cat > /etc/vim/vimrc.local <<EOF
" 基本配置
set nocompatible
set backspace=2
set number
set showcmd
set showmode
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
syntax on
EOF

# 11. 安装Docker
echo "11. 安装Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
usermod -aG docker $SUDO_USER

# 12. 配置Swap文件（如果不存在Swap）
echo "12. 配置Swap文件..."
if [ -z "$(swapon --show)" ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    echo "vm.swappiness = 10" >> /etc/sysctl.conf
    sysctl -p
else
    echo "系统已存在Swap，跳过配置"
fi

# 13. 安装常用开发工具
echo "13. 安装常用开发工具..."
apt install -y build-essential cmake gdb python3-dev python3-pip \
    nodejs npm openjdk-17-jdk

# 14. 配置pip镜像源
echo "14. 配置pip镜像源..."
PIP_CONF="/etc/pip.conf"
mkdir -p /etc/
cat > "$PIP_CONF" <<EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
EOF

# 15. 安装zsh和oh-my-zsh
echo "15. 安装zsh和oh-my-zsh..."
apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(which zsh) $SUDO_USER

# 16. 清理系统
echo "16. 清理系统..."
apt autoremove -y
apt clean
rm -rf /var/lib/apt/lists/*

echo "优化配置完成！建议重启系统使所有更改生效。"
echo "请手动执行以下命令切换默认shell为zsh：chsh -s $(which zsh)"
