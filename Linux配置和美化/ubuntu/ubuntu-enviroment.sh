#!/bin/bash

echo "==========开始安装配置开发环境=========="

# 更新系统
sudo apt update
# 安装tuari相关的依赖，都是一些系统基础工具
sudo apt install libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    wget \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev
sudo apt install git nodejs npm vim zip neofetch -y
yay -Sy nodejs npm vim zip

# 安装的 rust 自带 cargo 包管理工具
echo "==========开始安装 Rust=========="
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"
echo 你刚安装的 Rust 版本号为： $(rustc --version)

echo "==========开始安装 sdkman=========="
sdkman_dir="$HOME/.sdkman"
# 如果目录存在
if [ -d "$sdkman_dir" ]; then
    cd $HOME
    rm -rf .sdkman		
fi
# 安装 sdkman 工具
curl -s "https://get.sdkman.io" | bash
# 启动SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"
# 验证SDKMAN是否成功安装
echo 你刚安装的 sdkman 版本号为： $(sdk version)
# 这将安装指定版本的Java。
echo "==========开始安装 Java=========="
sdk install java 21.0.3-graal
sdk install java 17.0.11-graal
sdk use java 21.0.3-graal
sdk install kotlin

# 这将安装指定版本的Maven
echo "==========开始安装 Maven=========="
sdk install maven
sdk install gradle
sdk current

echo "==========开始安装 Bun=========="
# 安装 bun
# curl -fsSL https://bun.sh/install | bash
npm install -g bun
source ~/.bashrc
echo 你刚安装的 bun 版本号为： $(bun --version)

echo "==========开发环境安装配置完成，需要重启才能生效！！！=========="
# 询问用户是否立刻重启
read -p "是否立即重启系统？(y/n): " answer
if [[ $answer == "y" || $answer == "Y" ]]; then
    sudo reboot
else
    echo "已取消立即重启，但系统将在5分钟后自动重启，请保存您的工作！！！"
fi
