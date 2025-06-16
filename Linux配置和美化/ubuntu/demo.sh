#!/bin/bash

# =============================================
# Ubuntu 25 初次安装后一键配置脚本
# 功能：系统优化 + 必备软件安装 + 个性化设置
# 适用版本：Ubuntu 25.04 LTS
# 最后更新：2024年6月
# =============================================

# 检查是否为root用户，建议用普通用户运行
if [ "$(id -u)" -eq 0 ]; then
    echo "请勿使用root用户运行此脚本！建议用普通用户执行，部分命令会主动请求sudo权限"
    exit 1
fi

# 5. 配置APT镜像源（使用中国国内源）
# 点击并打开 “软件和更新” 将下载自的内容设置为 “位于中国的服务器” 这是ubuntu官方在中国的镜像源，地址为 http://cn.archive.ubuntu.com/ubuntu/
# 或者我们可以点击 “位于中国的服务器” 下方的 “其他” 选择 “中国” 然后点击右侧的 “选择最佳服务器” 这将会执行一系列的测试找到一个最好的镜像地址，
# 通常是 aliyun 或者 ustc
echo "点击并打开 '软件和更新' 将 '下载自' 的内容设置为 '其他' 选择 ‘中国’ 然后点击右侧的 ‘选择最佳服务器’ 这将会执行一系列的测试找到一个最好的镜像地址"
# 主服务器 的地址为 http://archive.ubuntu.com/ubuntu
# 位于中国的服务器 的地址为 http://cn.archive.ubuntu.com/ubuntu/
sudo apt modernize-sources -y
# cat /etc/apt/sources.list
# cat /etc/apt/sources.list.d/ubuntu.sources

# 第一部分：系统更新与基础配置
echo "➊ 系统更新与基础配置..."
sudo apt update -y && sudo apt upgrade -y      # 更新所有软件包
sudo apt install -y software-properties-common # 确保add-apt-repository可用
sudo apt install -y apt-transport-https curl git wget

# 第五部分：安装常用软件
echo "➎ 安装常用软件..."
# 通过APT安装
sudo apt install -y \
vim git build-essential \               # 开发工具
gimp inkscape \                         # 图形设计
ffmpeg vlc \                           # 多媒体
zsh fish \                             # 高级Shell
fonts-noto-cjk fonts-noto-color-emoji   # 优化字体

echo "➎ 安装Tauri依赖..."
sudo apt update
sudo apt install -y 
  libwebkit2gtk-4.1-dev \
  build-essential \
  curl \
  wget \
  file \
  libxdo-dev \
  libssl-dev \
  libayatana-appindicator3-dev \
  librsvg2-dev

# 设置时区为上海（可根据需要修改）
sudo timedatectl set-timezone Asia/Shanghai

echo "==========开始安装flatpak相关软件=========="
# 安装并配置 flatpak
sudo apt install -y flatpak gnome-software-plugin-flatpak
echo "开始配置Flatpak加速镜像..."
# flatpak remotes --show-details
# 添加 Flathub 官方仓库#
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# 修改 Flathub 仓库地址为国内镜像
# 1、上海交大 Flatpak 镜像源 https://mirrors.sjtug.sjtu.edu.cn/docs/flathub
# flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
# 2、中科大 Flatpak 镜像源 https://mirrors.ustc.edu.cn/help/flathub.html
flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
# flatpak uninstall --unused --all
# 如果 flatpak 安装应用报错可以尝试先移除现有仓库（如果已添加）
# flatpak remote-delete flathub
# 重新添加 Flathub 仓库并强制更新密钥
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "==========开始安装gnome相关软件=========="
# 下载系统基础工具，安装GNOME插件和扩展
# apt list gnome-shell-extension*
sudo apt install -y \
gnome-tweaks gnome-software \
gnome-shell-extension-manager \
gnome-shell-extension-user-theme \
gnome-shell-extension-alphabetical-grid \
gnome-shell-extension-appindicator \
gnome-shell-extension-auto-move-windows \
gnome-shell-extension-drive-menu \
gnome-shell-extension-gsconnect



gnome-shell-extension-dashtodock
git clone https://github.com/micheleg/dash-to-dock.git
make -C dash-to-dock install

git clone https://github.com/aunetx/blur-my-shell
cd blur-my-shell
make install

gnome-shell-extension-autohidetopbar
git clone https://gitlab.gnome.org/tuxor1337/hidetopbar.git
cd hidetopbar
make
gnome-extensions install ./hidetopbar.zip



# 第三部分：图形驱动（如果是NVIDIA显卡）
read -p "是否安装NVIDIA驱动？(y/n): " nvidia_choice
if [ "$nvidia_choice" = "y" ]; then
    echo "➌ 安装NVIDIA驱动..."
    sudo ubuntu-drivers autoinstall
    echo "安装完成后需要重启生效！"
fi



# 通过Flatpak安装推荐应用
flatpak install -y flathub \
    com.spotify.Client \                   # Spotify音乐
    org.telegram.desktop \                 # Telegram
    com.visualstudio.code \                # VS Code
    io.github.mimbrero.WhatsAppDesktop     # WhatsApp

# 第六部分：系统美化
echo "➏ 系统美化配置..."
# 安装图标和主题
sudo apt install -y \
    arc-theme \                           # Arc主题
    papirus-icon-theme \                  # Papirus图标
    materia-gtk-theme                     # Materia主题


sudo apt install -y adwaita-qt adwaita-qt6

sudo apt remove -y yaru-theme-icon yaru-theme-gnome-shell yaru-theme-gtk

# 设置默认主题（需要用户手动选择）
echo "请在GNOME Tweaks中手动选择："
echo "- 外观 > 主题：选择 Materia-dark"
echo "- 外观 > 图标：选择 Papirus-Dark"

# 第七部分：开发环境配置
echo "➐ 开发环境配置..."
# 安装Docker
sudo apt install -y docker.io
sudo usermod -aG docker $USER            # 将当前用户加入docker组


# 安装Node.js
echo "安装Node.js..."
sudo apt install -y nodejs npm
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


# 第八部分：清理系统
echo "➑ 清理系统..."
sudo apt autoremove -y                   # 删除无用包
sudo apt clean                           # 清理下载缓存

# 最终提示
echo "✅ 所有配置已完成！"
echo "建议操作："
echo "1. 重启系统使所有更改生效"
echo "2. 打开 GNOME Tweaks 进一步个性化设置"
echo "3. 访问 https://extensions.gnome.org/ 安装更多扩展"

# 可选：设置Zsh为默认Shell
read -p "是否将Zsh设为默认Shell？(需要手动配置oh-my-zsh)(y/n): " zsh_choice
if [ "$zsh_choice" = "y" ]; then
    sudo apt install -y zsh
    chsh -s $(which zsh)
    echo "请手动运行以下命令安装oh-my-zsh："
    echo 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
fi
