# 强制更新系统，包括所有可更新软件和操作系统内核
sudo pacman -Syyu
# 安装 yay 包管理器，方便安装 aur 中的软件包
sudo pacman -S yay
# 列出未被任何已安装软件包依赖的包（即孤儿包）
yay -Qdtq
# 清理无用的软件包并清除以下载的软件包缓存
yay -Rns $(yay -Qdtq) && yay -Scc


# 用于安装指定软件包
yay -S package_name
# 用于卸载已安装的软件包
yay -R package_name
# 从已安装的软件中搜索软件包，如果不接软件包即 yay -Q 则意味着 用于列出系统中已安装的所有软件包
yay -Q package_name
# 用于在软件仓库搜索与指定关键字匹配的软件包
yay -Ss search_keyword
# 用于更新系统和所有已安装的软件包，如果再加一个 y 组成 yay -Syyu 则意味着强制更新
yay -Syu
# --noconfirm 参数用于在执行操作时禁用确认提示。它用于自动化脚本或批处理中，以避免在执行命令时需要手动确认
yay -S <package_name> --noconfirm







yay -S dconf-editor
yay -S libreoffice-still-zh-cn

# VSCode在设置里搜索找到 titleBarStyle，改成 native

yay -S jetbrains-toolbox visual-studio-code-bin apifox switchhosts

# 点击    帮助 -> 编辑自定义虚拟机选项    这样就可以修改 idea64.vmoptions 配置文件了

yay -S intellij-idea-ultimate-edition
// zed 配置参考官网  https://zed.rust-lang.net.cn/docs/configuring-zed
yay -S zed --noconfirm


# 在 /etc/profile.d/ 下创建 jre.sh

sudo nano /etc/profile.d/jre.sh

# 将配置追加到 /etc/profile.d/jre.sh（适用于 Bash）

echo 'export _JAVA_OPTIONS="-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=3 -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"' >> /etc/profile.d/jre.sh
cat /etc/profile.d/jre.sh

# 重新登录或重启系统

# 或手动加载（仅当前会话生效）

source /etc/profile

# 查看环境变量

echo $_JAVA_OPTIONS

yay -S google-chrome
yay -S microsoft-edge-stable-bin
yay -S firefox firefox-i18n-zh-cn
yay -S linuxqq wechat baidunetdisk-bin typora
yay -S yesplaymusic tabby

# Clash Nyanpasu 最初是从 Clash Verge 1.3.7 分支而来，是在 Clash Verge 1.3.7 的基础上进行二次开发而成的。 

# https://nyanpasu.elaina.moe/zh-CN/

yay -S clash-nyanpasu-bin
# 官方版本，官网 https://www.clashverge.dev/
yay -S clash-verge-rev
yay -S clash-verge-rev-bin
yay -S vagrant virtualbox postgresql
yay -S neofetch evolution popsicle obsidian
evolution配置qq邮箱授权码： embwnsuwkdjrebge

20.205.243.166	github.com
185.199.110.133	raw.githubusercontent.com
104.24.156.12	download.typora.io

# 安装的 rust 自带 cargo 包管理工具    

# 编辑或创建 ~/.bashrc / ~/.zshrc / ~/.profile
echo 'export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static' >> ~/.bashrc
echo 'export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup' >> ~/.bashrc
source ~/.bashrc  # 使配置生效

sudo pacman -S rust
source "$HOME/.cargo/env"



# 安装 nightly 工具链
rustup install nightly
# 在项目目录中设置使用 nightly
rustup override set nightly

# 安装 sdkman 工具

curl -s "https://get.sdkman.io" | bash

# 启动SDKMAN

source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 21.0.4-graal
sdk install java 17.0.11-graal
sdk use java 21.0.4-graal
sdk install maven
sdk install gradle
sdk current

# asdf 多运行时版本管理器，使用一个工具管理所有运行时版本！可以管理 Python、Java、nodejs、golang、rust 等所有常见编程的版本

# 官网 https://asdf-vm.com/zh-hans/



# 安装 bun

# curl -fsSL https://bun.sh/install | bash

# yay -S nodejs npm

# 安装 nvm

sudo pacman -S nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
source ~/.bashrc
nvm --help
nvm --version
nvm ls-remote --lts
nvm install --lts
node --version
npm --version

# 最新地址 淘宝 NPM 镜像站喊你切换新域名啦!

npm config set registry https://registry.npmmirror.com
npm config get registry

sudo npm install -g bun
source ~/.bashrc
echo 你刚安装的 bun 版本号为： $(bun --version)

### 将 bunfig.toml 作为隐藏文件添加到用户主目录

# 使用 bun 创建一个基于 vue-ts 模板的项目，bun即是一个包管理器也是JS运行时

bun create vite bun-vue3-ts --template vue-ts
bun install
bun run dev

# 是用 bun 创建一个 tauri 2.0 项目

bun create tauri-app

# Template created! To get started run:

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
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin:$GOBIN
配置代理
go env -w GOPROXY=https://goproxy.cn,direct
go env
