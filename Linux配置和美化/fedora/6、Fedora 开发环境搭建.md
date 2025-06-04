以下是针对 Fedora 41 的 **开发环境搭建指南**，涵盖 **SDKMAN!、Rust、Golang、Node.js、Bun** 等工具的安装与配置，并附上优化建议：

---

### **1. 基础准备**
#### **更新系统 & 安装依赖**
```bash
sudo dnf update -y
sudo dnf install -y curl wget git tar gzip openssl-devel zlib-devel make gcc-c++ 

sudo dnf install vagrant VirtualBox virtualbox-guest-additions
```

#### **启用 RPM Fusion（可选）**
```bash
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

---

### **2. 安装开发工具链**
#### **🔹 SDKMAN!（Java/Kotlin/Scala 等）**
```bash
# 参考 https://docs.fedoraproject.org/zh_Hans/quick-docs/installing-java/
dnf search openjdk
sudo dnf install java-latest-openjdk.x86_64
sudo dnf install openjdk maven

# 安装 SDKMAN!
curl -s "https://get.sdkman.io" | bash
source "/home/lcqh/.sdkman/bin/sdkman-init.sh"

# 安装 JDK（示例：安装 Temurin JDK 17）
sdk install java 21.0.6-tem

# 安装 Maven/Gradle
sdk install maven
sdk install gradle
```

#### **🔹 Rust**
```bash


sudo dnf install -y rust
# 通过 rustup 安装
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# 验证安装
rustc --version
cargo --version

# 安装常用工具
rustup component add rustfmt clippy
```

#### **🔹 Golang**
```bash
# 通过官方仓库安装（版本可能较旧）
sudo dnf install -y golang

# 或手动安装最新版
wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# 验证安装
go version
```

#### **🔹 Node.js & Bun**
```bash
sudo dnf install -y nodejs



# 最新地址 淘宝 NPM 镜像站喊你切换新域名啦!
npm config set registry https://registry.npmmirror.com
npm config get registry
   
sudo npm install -g bun
echo 你刚安装的 bun 版本号为： $(bun --version)
# 将 bunfig.toml 作为隐藏文件添加到用户主目录
echo '[install]
# 使用阿里云加速仓库，仓库地址可从阿里云官方获取，地址为 https://developer.aliyun.com/mirror/
registry = "https://registry.npmmirror.com/"
' >> ~/.bunfig.toml

cat ~/.bunfig.toml

# 验证安装
node --version
bun --version


# 使用 bun 创建一个基于 vue-ts 模板的项目，bun即是一个包管理器也是JS运行时
bun create vite bun-vue3-router --template vue-ts
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


dnf search chat2db
```

---

### **3. 开发工具推荐**
#### **🔸 IDE & 编辑器**
- **VS Code**  
  ```bash
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=VS Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  sudo dnf install -y code
  ```

- **IntelliJ IDEA**  
  ```bash
  flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community
  ```

#### **🔸 数据库工具**
- **DBeaver**  
  ```bash
  sudo dnf install -y dbeaver
  ```

#### **🔸 容器化工具**
- **Docker**  
  ```bash
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install -y docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
  ```

---

### **4. 环境配置优化**
#### **Shell 配置（~/.bashrc 或 ~/.zshrc）**
```bash
# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
```

#### **Git 全局配置**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "code --wait"
```

---

### **5. 验证安装**
```bash
# 检查各工具版本
java -version
rustc --version
go version
node --version
bun --version
docker --version
```

---

### **6. 常见问题解决**
#### **问题1：SDKMAN! 安装失败**
- **原因**：网络问题或缺少 `zip/unzip`。  
- **解决**：  
  ```bash
  sudo dnf install -y zip unzip
  curl -s "https://get.sdkman.io" | bash
  ```

#### **问题2：Bun 权限错误**
- **原因**：未正确设置 PATH。  
- **解决**：  
  ```bash
  chmod +x $HOME/.bun/bin/bun
  source ~/.bashrc
  ```

#### **问题3：Rust 工具链下载慢**
- **解决**：更换国内镜像源  
  ```bash
  echo '[source.crates-io]
  replace-with = "ustc"
  [source.ustc]
  registry = "https://mirrors.ustc.edu.cn/crates.io-index"' > ~/.cargo/config
  ```

---

### **7. 推荐工具组合**
| **开发场景**     | **推荐工具**                     |
| ---------------- | -------------------------------- |
| **Java/Kotlin**  | SDKMAN! + IntelliJ IDEA + Maven  |
| **Rust**         | rustup + VS Code + Rust Analyzer |
| **Golang**       | Go (官方包) + VS Code + Delve    |
| **Node.js/前端** | nvm + Bun + VS Code              |
| **全栈开发**     | Docker + DBeaver + 上述所有      |

---

按此流程配置后，Fedora 41 将具备完整的开发生态，支持多语言高效协作！ 🚀