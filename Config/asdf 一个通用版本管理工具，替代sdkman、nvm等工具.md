---

### **asdf 是什么？**
**asdf** 是一个 **通用版本管理工具**，支持通过插件管理 **300+ 种编程语言、运行时和工具**（如 Node.js、Python、Java、MySQL、PostgreSQL、Redis 等）。它的核心作用是通过统一界面管理多个工具的版本，解决开发环境中多版本共存和切换的问题。  
与单一工具（如 `nvm`、`rbenv`）不同，**asdf 是跨语言的**，只需一个工具即可管理几乎所有开发依赖。
Github 主页 https://github.com/asdf-vm/asdf
中文官方主页 https://asdf-vm.com/zh-hans/
---

### **asdf 的核心作用**
1. **多版本共存**：同一工具的不同版本可并行安装（如同时安装 Python 3.8 和 3.11）。
2. **按项目切换版本**：为不同项目指定不同版本（通过 `.tool-versions` 文件）。
3. **统一管理**：用一个工具管理编程语言、数据库、CLI 工具等。
4. **轻量级**：依赖少，仅需 Bash 或 Zsh 环境。

---

### **在 Manjaro 中安装 asdf**
#### **步骤 1：安装依赖**
确保已安装 `git` 和 `curl`：
```bash
sudo pacman -S git curl
```

#### **步骤 2：通过 AUR 安装 asdf**
Manjaro 推荐使用 AUR 包管理器（如 `yay`）：
```bash
# 安装 yay（如未安装）
sudo pacman -S --needed base-devel
sudo pacman -S yay

# 通过 yay 安装 asdf
yay -S asdf-vm
```

#### **步骤 3：配置 Shell**
将 asdf 初始化脚本添加到 Shell 配置文件（根据 Shell 类型选择）：
```bash
# Bash（~/.bashrc 或 ~/.bash_profile）
echo -e "\n. /opt/asdf-vm/asdf.sh" >> ~/.bashrc

# Zsh（~/.zshrc）
echo -e "\n. /opt/asdf-vm/asdf.sh" >> ~/.zshrc

# 重新加载配置
source ~/.bashrc  # 或 source ~/.zshrc


# 打印所有可用命令的列表
asdf help
# 用于打印操作系统、Shell 和 asdf 调试信息的辅助命令。
asdf info
```

---

### **基本使用示例**
#### **1. 添加插件**
以 Node.js 和 Python 为例：
```bash
# 所有可选插件列表参考 https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
https://github.com/topics/asdf-plugin
# 目前 asdf 官方插件只有 4 个，非常少，主要还是依赖社区插件
# 所有社区插件参考 https://github.com/asdf-community

# 添加 Node.js 插件
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# 添加 Python 插件
asdf plugin-add python

asdf plugin add bun         参考 https://github.com/cometkim/asdf-bun
asdf plugin add maven       参考 https://github.com/halcyon/asdf-maven
asdf plugin add mysql       参考 https://github.com/iroddis/asdf-mysql
asdf plugin add postgres    参考 https://github.com/smashedtoatoms/asdf-postgres
asdf plugin add sqlite      参考 https://github.com/cLupus/asdf-sqlite

asdf plugin add redis https://github.com/smashedtoatoms/asdf-redis.git
asdf plugin add mongodb https://github.com/sylph01/asdf-mongodb.git
asdf plugin add rabbitmq https://github.com/w-sanches/asdf-rabbitmq.git

asdf plugin add rust https://github.com/asdf-community/asdf-rust.git
asdf plugin add graalvm https://github.com/asdf-community/asdf-graalvm.git
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin add kotlin
# or
asdf plugin add kotlin https://github.com/asdf-community/asdf-kotlin.git


asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf list all java

# 列举已安装的插件
asdf plugin list
asdf plugin list --urls
asdf plugin list all

# 更新插件
asdf plugin update --all
asdf plugin update <name>
asdf plugin update java
asdf plugin update python

# 移除插件
asdf plugin remove <name>
asdf plugin remove java
asdf plugin remove python
```

#### **2. 安装指定版本**
```bash
参考中文官方文档 https://asdf-vm.com/zh-hans/manage/versions.html

# 安装命令格式
asdf install <name> <version>
# 安装最新稳定版本
asdf install <name> latest
asdf install java latest
# 安装给定字符串开头的最新稳定版本。
asdf install <name> latest:<version>
asdf install java latest:17
# 列举已安装版本
asdf list <name>
asdf list java
# 筛选出以给定字符串开头的版本。
asdf list <name> <version>
asdf list java 17
# 列举所有可用版本
asdf list all <name>
asdf list all java
# 筛选出以给定字符串开头的可用版本。
asdf list all <name> <version>
asdf list all java 17
# 显示最新稳定版本
asdf latest <name>
asdf latest java
# 显示以给定字符串开头的最新稳定版本。
asdf latest <name> <version>
# asdf latest java 17

# 安装 Node.js 18.16.0
asdf install nodejs 18.16.0

# 安装 Python 3.11.4
asdf install python 3.11.4
```

#### **3. 设置全局或项目级版本**
```bash
# 全局默认使用 Node.js 18.16.0
asdf global nodejs 18.16.0

# 在当前目录设置 Python 3.11.4（自动生成 .tool-versions 文件）
asdf local python 3.11.4
```

#### **4. 验证版本**
```bash
node -v  # 输出 v18.16.0
python --version  # 输出 3.11.4
```

---

### **管理数据库版本（以 MySQL 为例）**
#### **1. 添加 MySQL 插件**
```bash
asdf plugin add mysql https://github.com/iroqwa/asdf-mysql.git
```

#### **2. 安装指定版本**
```bash
asdf install mysql 8.0.33
```

#### **3. 初始化 MySQL 服务**
```bash
# 设置数据目录
mkdir -p ~/mysql_data
asdf shell mysql 8.0.33
mysqld --initialize-insecure --user=$USER --datadir=~/mysql_data

# 启动 MySQL
mysqld --datadir=~/mysql_data --socket=/tmp/mysql.sock &
```

---

### **注意事项**
1. **依赖处理**：某些插件需要额外依赖（如编译工具），需提前安装（如 MySQL 需要 `libssl`、`ncurses`）。
2. **服务管理**：asdf 仅管理版本，服务启停需手动操作或结合 Systemd。
3. **插件更新**：定期运行 `asdf plugin update --all` 更新插件。

---

### **总结**
- **适用场景**：开发环境、多项目版本隔离、快速切换工具链。
- **优势**：统一管理、轻量灵活、跨语言支持。
- **劣势**：生产环境建议使用包管理器或容器化方案。
