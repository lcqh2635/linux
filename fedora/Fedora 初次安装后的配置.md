以下是为 Fedora Workstation 41 初次安装后的推荐配置步骤，按优先级和常见需求分类整理：

---

### **一、系统更新与基础配置**
1. **更新系统**  
   ```bash
   sudo dnf update -y && sudo dnf upgrade -y
   ```

2. **启用 RPM Fusion 仓库**（提供非自由软件支持）  
   ```bash
   sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
   https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
   
   
   # 添加中科大 Fedora 镜像源，参考 https://mirrors.ustc.edu.cn/help/fedora.html
   sudo sed -e 's|^metalink=|#metalink=|g' \
            -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
            -i.bak \
            /etc/yum.repos.d/fedora.repo \
            /etc/yum.repos.d/fedora-updates.repo
   # 最后运行 sudo dnf makecache 生成缓存
   sudo dnf makecache
   # 添加中科大 Flatpak 镜像源，参考 https://mirrors.ustc.edu.cn/help/flathub.html
   sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
   # 恢复默认值
   sudo flatpak remote-modify flathub --url=https://dl.flathub.org/repo
   
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
   
   sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
   
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
   sudo dnf install \
   gnome-tweaks \          
   vlc \                   
   unzip p7zip \           
   timeshift \            
   gnome-shell-extension-appindicator
   
   sudo dnf install google-chrome-stable.x86_64
   sudo dnf install libreoffice-langpack-zh-Hans.x86_64
   sudo dnf install evolution.x86_64 obs-studio.x86_64
   # evolution配置qq邮箱授权码： embwnsuwkdjrebge
   sudo dnf install fastfetch.x86_64
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
   flatpak install flathub com.qq.QQ -y
   flatpak install flathub com.tencent.WeChat -y
   flatpak install flathub com.tencent.wemeet -y
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
   # Telegram
   flatpak install flathub org.telegram.desktop -y
   # 翻译
   flatpak install flathub app.drey.Dialect -y
   # 办公软件
   flatpak install flathub org.libreoffice.LibreOffice -y
   flatpak install flathub com.wps.Office -y
   # RustDesk
   flatpak install flathub com.rustdesk.RustDesk -y
   # 制作 ISO 系统启动盘
   # Fedora 启动盘写入工具t
   flatpak install flathub org.fedoraproject.MediaWriter -y
   flatpak install flathub com.system76.Popsicle -y
   flatpak install flathub io.gitlab.adhami3310.Impression -y
   # 快捷、安全的文件传输工具
   flatpak install flathub app.drey.Warp -y
   # 下载、使用且能自适应的 GTK 应用程序字体
   flatpak install flathub org.gustavoperedo.FontDownloader -y
   # 管理您的密码和密钥
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
   # 用于运行 Windows 游戏的软件
   flatpak install flathub ru.linux_gaming.PortProton -y
   # Lutris 可帮您安装和运行大多数平台上几乎所有时代的电子游戏。通过对现有的模拟器、兼容层、第三方游戏引擎等进行整合利用，Lutris 可为您提供一个统一的界面来启动您的所有游戏。
   flatpak install flathub net.lutris.Lutris -y
   # 创建图像或编辑照片
   flatpak install flathub org.gimp.GIMP -y
   # 保持专注,浏览更快。zen是浏览网之妙法. 设计精美,注重隐私,并装有特色. 我们关心你的经验 而不是你的数据.
   flatpak install flathub app.zen_browser.zen -y
   flatpak install flathub org.flameshot.Flameshot -y
   
   # 开发常用软件
   flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate -y
   flatpak install flathub com.google.AndroidStudio -y
   flatpak install flathub dev.zed.Zed -y
   flatpak install flathub io.github.shiftey.Desktop -y
   flatpak install flathub com.visualstudio.code -y
   flatpak install flathub cn.apipost.apipost -y
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
   # 本地证书 - 自定义 - 可信证书 - 导入
   # 证书地址为 /home/lcqh/.local/share/Steam++/Plugins/Accelerator/SteamTools.Certificate.cer
   ```
   
3. **推荐通过 Flatpak 安装的软件**  
   
   ```bash
   flatpak install flathub \
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
   
   
   ```
   
2. **Docker 安装**  
   ```bash
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
     
     
     ```
   
2. **主题与图标**  
   - 下载主题（如 [Arc](https://github.com/NicoHood/arc-theme)）：  
     ```bash
     sudo dnf install arc-theme
     
     yaru-gtk4-theme.noarch
     yaru-gtksourceview-theme.noarch
     yaru-icon-theme.noarch
     yaru-sound-theme.noarch
     
     ```
     
   - 图标包（如 [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)）：  
     ```bash
     sudo dnf install papirus-icon-theme
     
     ```
     
   - 在 `Gnome Tweaks` 中启用主题和图标。
   
     ```bash
     
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
   fastestmirror=True
   max_parallel_downloads=10
   ```

2. **电源管理**  
   ```bash
   sudo dnf install tlp tlp-rdw  # 笔记本续航优化
   sudo systemctl enable tlp
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

