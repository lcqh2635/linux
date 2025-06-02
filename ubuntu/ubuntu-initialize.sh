#!/bin/bash

# 配置Github访问加速
echo "
# GitHub Start
20.205.243.166 github.com
# GitHub End
" | sudo tee -a /etc/hosts
# https://search.ecnu.cf/ 	google搜索景象	IPv4	103.150.214.192

# ubuntu 系统订阅 pro
sudo pro attach C1fNYhSKakFcaXf77wgse9XF725K6

# echo "==========开始安装 fcitx5 中文输入法=========="
# 首先卸载旧版输入法，卸载与 fcitx5 冲突的所有依赖
# sudo apt remove --purge fcitx ibus -y
# 安装fcitx5中文拼音输入法
# sudo apt install fcitx5 fcitx5-chinese-addons && sudo apt autoremove -y
sudo pacman -S fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-chinese-addons
# 清理无用的软件包
# sudo apt autoremove && sudo apt autoclean -y

echo "==========开始安装gnome相关软件=========="
# 下载系统基础工具，安装GNOME插件和扩展
gnome-shell-extensions
sudo apt install gnome-tweaks gnome-software gnome-shell-extension-manager chrome-gnome-shell -y
sudo yay -Sy gnome-shell-extension-manager chrome-gnome-shell
echo "==========开始安装flatpak相关软件=========="
# 安装并配置 flatpak
sudo apt install -y flatpak gnome-software-plugin-flatpak gnome-software-plugin-snap
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# 配置 flatpak 上海交大下载加速镜像仓库
flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
# 卸载 snap软件商店和默认snap火狐浏览器
sudo snap remove snap-store firefox

# 目录不在由 XDG_DATA_DIRS 环境变量设置的搜索路径中，因此通过 Flatpak 安装的应用在会话重启前可能不会出现在您的桌面。该问题解决！！！
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/lcqh/.local/share/flatpak/exports/share
source $HOME/.bashrc

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

# 添加 PPA 软件源
# sudo add-apt-repository ppa:dr-akulavich/lighttable
# sudo apt-get update
# sudo apt-get install lighttable-installer

# 更新软件源并升级软件
sudo apt update && sudo apt upgrade -y

# 修复闪烁花屏BUG
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amdgpu.dc=1 amdgpu.dcdebugmask=0x10 amdgpu.sg_display=0"/g' /etc/default/grub
grep "GRUB_CMDLINE_LINUX_DEFAULT" /etc/default/grub
sudo update-grub && sudo update-grub2
