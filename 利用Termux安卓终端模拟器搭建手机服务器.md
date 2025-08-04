

**Termux** 是一款运行在 **Android** 系统上的 **终端模拟器** 和 **Linux 环境**，它可以在不 root 手机的情况下，提供一个近乎完整的 **Linux 命令行环境**，允许用户安装和使用许多常见的 Linux 工具和软件（如 Python、Node.js、Git、SSH 等）。  

---

## **🔹 Termux 的主要作用**
1. **运行 Linux 命令行工具**（如 `gcc`、`python`、`vim`、`git`、`wget` 等）。  
2. **搭建轻量级服务器**（如 Web 服务器、SSH 服务器、数据库等）。  
3. **编程开发**（支持 Python、C/C++、Java、Node.js、Ruby、Go 等）。  
4. **网络工具**（如 `nmap`、`curl`、`tcpdump` 进行网络测试）。  
5. **文件管理**（支持 `rsync`、`tar`、`zip` 等压缩和解压工具）。  
6. **渗透测试**（可安装 Metasploit、Hydra 等安全工具）。  

---

## **🔹 如何安装 Termux？**
### **1. 官方安装方式（推荐）**
- **F-Droid（无 Google 服务版）**（推荐，更新更快）  
  - 下载 [F-Droid](https://f-droid.org/)，搜索 **Termux** 安装。  
- **Google Play（可能版本较旧）**  
  - 搜索 **Termux** 安装（但 Google Play 版本可能停止更新）。  

### **2. 手动安装 APK**
- 从 [Termux GitHub](https://github.com/termux/termux-app/releases) 下载最新 APK 安装。  

ZeroTermux实用教程： https://www.bilibili.com/read/cv29993331/
首先，安装 Termux 或者魔改版本 ZeroTermux 终端工具，下载的地址为：
Termux： https://github.com/termux/termux-app
ZeroTermux（推荐使用）： https://github.com/hanxinhao000/ZeroTermux

---

## **🔹 Termux 基本使用**
### **1. 基础命令**
| 命令 | 作用 |
|------|------|
| `pkg update` | 更新软件包列表 |
| `pkg upgrade` | 升级所有已安装的软件 |
| `pkg install <软件名>` | 安装软件（如 `pkg install python`） |
| `pkg search <关键词>` | 搜索软件包 |
| `pkg remove <软件名>` | 卸载软件 |
| `apt` | 类似 `pkg`，也可以管理软件包 |

### **2. 访问手机存储**
默认情况下，Termux 不能直接访问手机存储，需要授权：  
```bash
pkg update -y && pkg upgrade -y
pkg install -y fastfetch
termux-setup-storage
```
授权后，Termux 会在 `~/storage/` 下创建以下目录：
- `shared` → 手机内部存储（`/sdcard/`）  
- `downloads` → 下载目录  
- `dcim` → 相册目录  
- `music` → 音乐目录  

---

## **🔹 Termux 进阶用法**
### **1. 搭建 SSH 服务器（远程登录 Termux）**
```bash
# 设置加速镜像仓库
termux-change-repo
# 它的核心作用是在 已 Root 的 Android 设备 上提供类似 Linux 中 sudo 的临时 root 权限管理功能。
# pkg install tsu
pkg install root-repo   	# 先安装 root 源
pkg install x11-repo		# 启用 X11 图形界面软件源，从而允许安装和运行带有图形界面（GUI）的 Linux 软件。
pkg install openssh
sshd                  		# 启动 SSH 服务
whoami  			  		# 查看用户名（如 `u0_a123`）
ifconfig | grep "inet"  	# 查看手机 IP 地址
passwd                		# 设置密码（用于 SSH 登录）
# 设置ssh自动开启，不用手动输入 sshd 命令启动
# echo "sshd" >> ~/.bashrc

ssh u0_a267@192.168.1.3 -p 8022
netstat -tulnp | grep 8022


# 管理 Termux 后台服务（如 sshd）
pkg install termux-services
# 启用 SSH 密钥管理守护进程
sv-enable ssh-agent
# 启用 SSH 服务端，允许远程连接。
sv-enable sshd
# 立即启动
sv up sshd
# 检查状态
sv status sshd
```
然后在电脑上使用：
```bash
ssh u0_a267@手机IP -p 8022
ssh u0_a267@192.168.1.3 -p 8022
ssh u0_a0@192.168.1.4 -p 8022
```
（默认端口 `8022`，用户名是 `whoami` 输出的名字）

### **2. 安装 Git 并克隆仓库**
```bash
pkg install git
git clone https://github.com/用户名/仓库.git
```

### **3. 运行 MySQL 或 PostgreSQL**

```bash
apt install postgresql
psql --version
psql -U postgres
pkg install mariadb   # 安装 MySQL 替代品
mysqld_safe &         # 启动 MySQL 服务
mysql -u root         # 登录 MySQL
```

### **4. 安装完整 Linux 发行版（如 Ubuntu）**

使用 `proot-distro` 安装 Ubuntu/Debian：

```bash
pkg install proot-distro
proot-distro list          # 查看支持的发行版
proot-distro install debian  # 安装 debian
proot-distro login debian  # 进入 debian

# 配置 debian 中科大加速镜像 https://mirrors.ustc.edu.cn/help/debian.html#__tabbed_3_2
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sed -i -e 's|security.debian.org/\? |security.debian.org/debian-security |g' \
            -e 's|security.debian.org|mirrors.ustc.edu.cn|g' \
            -e 's|deb.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' \
            /etc/apt/sources.list

# sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
# cat /etc/apt/sources.list.d/debian.sources
# echo "" | tee /etc/apt/sources.list.d/debian.sources

# 更新系统
apt update -y && apt upgrade -y
sudo apt update -y && sudo apt upgrade -y
# 安装必要依赖
apt install -y git wget curl sudo

# 配置 SSH 服务
apt install -y openssh-server
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh  # 或 /etc/init.d/ssh restart


# 开源内网穿透工具 https://github.com/fatedier/frp/releases
# Frp服务端一键配置脚本，脚本默認获取Frp最新版本
wget https://gitee.com/mvscode/frps-onekey/raw/master/install-frps.sh -O ./install-frps.sh
chmod 700 ./install-frps.sh
./install-frps.sh install
```

在 Ubuntu 里可以运行 `apt` 安装更多软件（如 `nginx`、`mysql`）。

### **3. 运行 MySQL 或 PostgreSQL**

```bash
apt install -y postgresql
psql --version
sudo postgresql-setup --initdb --unit postgresql
psql -U postgres
pkg install mariadb   # 安装 MySQL 替代品
mysqld_safe &         # 启动 MySQL 服务
mysql -u root         # 登录 MySQL
```

安装常用软件

---

## **🔹 注意事项**

1. **Termux 不是真正的 root 环境**，部分系统级操作（如修改 `/system`）需要 root 权限。  
2. **Android 重启后，Termux 的服务会停止**，需要重新启动（可以用 `termux-boot` 实现开机自启）。  
3. **长时间高负载运行可能导致手机发热**，建议优化程序或限制 CPU 使用率。  

---

## **🔹 总结**
- **Termux = Android 上的 Linux 终端**，适合运行命令行工具、开发、搭建轻量服务器。  
- **基本使用**：`pkg` 安装软件、`termux-setup-storage` 访问存储、`sshd` 远程登录。  
- **进阶玩法**：安装 Ubuntu、运行 Web 服务器、数据库等。  

如果你有具体的需求（如搭建 Web 服务器、运行爬虫、开发 App），可以进一步深入探索！ 🚀







## 安装 `openssh` 后提示信息的作用

你安装 `openssh` 后，Termux 提示你安装 `termux-services` 并运行 `sv-enable` 命令，这些是用于 **管理 Termux 后台服务** 的。下面详细解释它们的作用：

---

## **🔹 1. `pkg install termux-services` 的作用**
### **📌 功能**
- **`termux-services`** 是一个 Termux 插件，用于管理**后台守护进程（daemon）**，类似于 Linux 的 `systemd` 或 `init.d`。
- 它允许你在 Termux 中**持久化运行服务**（如 `sshd`、`nginx`、`mysql` 等），即使关闭终端也不会停止。

### **📌 为什么需要它？**
- 默认情况下，Termux 的 `sshd` 等服务在退出 Termux 后会自动关闭。
- 安装 `termux-services` 后，可以让 `sshd` 等**保持后台运行**，并支持开机自启（需额外配置）。

---

## **🔹 2. `sv-enable ssh-agent` 的作用**
### **📌 功能**
- **`ssh-agent`** 是一个用于**管理 SSH 密钥**的守护进程。
- 启用后，它可以缓存你的 SSH 私钥密码，避免每次使用 `ssh` 或 `git` 时重复输入密码。

### **📌 适用场景**
- 如果你使用 `ssh-keygen` 生成了密钥对（如 `id_rsa`），并希望免密登录远程服务器或 GitHub。
- 典型用法：
  ```bash
  eval $(ssh-agent)          # 启动 ssh-agent
  ssh-add ~/.ssh/id_rsa      # 添加私钥（需输入密码一次）
  ```

---

## **🔹 3. `sv-enable sshd` 的作用**
### **📌 功能**
- **`sshd`** 是 OpenSSH 的**服务端程序**，允许其他设备通过 SSH 连接到你的 Termux。
- `sv-enable sshd` 会**注册并启动 `sshd` 守护进程**，使其在后台持续运行。

### **📌 使用步骤**
1. **设置 SSH 密码**（如果未设置）：
   ```bash
   passwd  # 设置登录密码
   ```
2. **查看 SSH 连接信息**：
   ```bash
   whoami  # 查看用户名（如 `u0_a123`）
   ifconfig  # 查看手机 IP 地址
   ```
3. **从电脑连接 Termux**：
   ```bash
   ssh u0_a123@手机IP -p 8022  # 默认端口 8022
   ```

---

## **🔹 4. 其他相关命令**
| 命令              | 作用                   |
| ----------------- | ---------------------- |
| `sv-disable sshd` | 停止并禁用 `sshd` 服务 |
| `sv down sshd`    | 停止服务（但不禁用）   |
| `sv up sshd`      | 启动服务               |
| `sv status sshd`  | 查看服务状态           |

---

## **🔹 5. 开机自启（需 Termux:Boot）**
如果希望 Termux 启动时自动运行 `sshd`：
1. 安装 **Termux:Boot**（Google Play 或 F-Droid）。
2. 创建 `~/.termux/boot/` 目录：
   ```bash
   mkdir -p ~/.termux/boot
   ```
3. 创建启动脚本：
   ```bash
   echo "sv up sshd" > ~/.termux/boot/start-sshd
   chmod +x ~/.termux/boot/start-sshd
   ```
4. 重启手机，`sshd` 会自动运行。

---

## **⚠️ 注意事项**
1. **安全风险**  
   - 确保 `passwd` 设置了强密码，避免被暴力破解。
   - 可改用密钥认证（更安全）：
     ```bash
     ssh-keygen -t ed25519  # 生成密钥
     cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys  # 添加公钥
     ```
2. **端口冲突**  
   - 如果 `8022` 端口被占用，可修改 `/data/data/com.termux/files/usr/etc/ssh/sshd_config` 中的 `Port`。

---

## **✅ 总结**
- **`termux-services`**：管理 Termux 后台服务（如 `sshd`）。
- **`sv-enable ssh-agent`**：启用 SSH 密钥管理守护进程。
- **`sv-enable sshd`**：启用 SSH 服务端，允许远程连接。
- **持久化运行**：配合 `Termux:Boot` 可实现开机自启。

如果你只是临时使用 SSH，可以手动运行 `sshd`；如果需要长期后台运行，务必按上述步骤配置！ 🔒
