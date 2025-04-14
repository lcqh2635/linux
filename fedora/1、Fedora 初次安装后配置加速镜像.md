在 Fedora 41 初次安装后，配置国内镜像源可以显著提升软件包下载速度（尤其是 `dnf` 更新和安装软件时）。

**推荐先配置加速镜像源，然后再更新系统**。以下是详细步骤：

---

### **1. 替换为国内镜像源**
编辑 Fedora 官方仓库文件，将 `metalink` 替换为国内镜像 URL（以 **清华镜像** 为例）：
```bash
# 一切加速镜像配置教程统一参考 清华大学开源软件镜像站 该站点拥有最详细的配置教程
# 清华大学开源软件镜像站 https://mirrors.tuna.tsinghua.edu.cn/help/

# -e 's|^metalink=|#metalink=|g'：注释掉所有以 metalink= 开头的行（将 metalink= 替换为 #metalink=）。这是因为 metalink 动态解析镜像列表，而手动配置时我们希望禁用它。
# -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.aliyun.com/fedora|g'：将原本被注释掉的 #baseurl= 行取消注释，并将其替换为阿里云镜像站的地址。
# -i.bak：在修改文件之前创建备份文件（如 fedora.repo.bak）。
# /etc/yum.repos.d/fedora.repo 和 /etc/yum.repos.d/fedora-updates.repo：需要修改的目标文件。

cat /etc/yum.repos.d/fedora.repo
cat /etc/yum.repos.d/fedora-updates.repo
# 1、清华 Fedora 镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/fedora/
sudo sed -e 's|^metalink=|#metalink=|g' \
    -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' \
    -i.bak \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo


# 2、阿里云 Fedora 镜像源 https://developer.aliyun.com/mirror/fedora
sudo sed -e 's|^metalink=|#metalink=|g' \
    -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.aliyun.com/fedora|g' \
    -i.bak \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo

# 最后运行 sudo dnf makecache 生成缓存
sudo dnf makecache

# 还原之前的配置
ls /etc/yum.repos.d/		# 检查备份文件是否存在
# 如果目标文件（如 /etc/yum.repos.d/fedora.repo）不存在 ，mv 会直接创建目标文件。
# 如果目标文件已存在 ，mv 会覆盖 目标文件
sudo mv /etc/yum.repos.d/fedora.repo.bak /etc/yum.repos.d/fedora.repo
sudo mv /etc/yum.repos.d/fedora-updates.repo.bak /etc/yum.repos.d/fedora-updates.repo
# 还原完成后，清理旧的缓存并重新生成元数据：
sudo dnf clean all
sudo dnf makecache

Fedora 默认使用 Metalink 给出推荐的镜像列表，保证用户使用的镜像仓库足够新，并且能够尽快拿到安全更新，从而提供更好的安全性。所以通常情况下使用默认配置即可，无需更改配置文件。
由于 Metalink 需要从国外的 Fedora 项目服务器上获取元信息，所以对于校园内网、无国外访问等特殊情况，metalink 并不适用，此时可以如下修改配置文件。
Fedora 的软件源配置文件可以有多个，其中：
    系统默认的 fedora 仓库配置文件为 /etc/yum.repos.d/fedora.repo
    系统默认的 updates 仓库配置文件为 /etc/yum.repos.d/fedora-updates.repo
将上述两个文件先做个备份，根据 Fedora 系统版本分别替换为下面内容，之后通过 sudo dnf makecache 命令更新本地缓存，即可使用所选择的软件源镜像。
```

---

### **2. 添加 RPM Fusion 国内镜像**
如果已启用 RPM Fusion，可以替换其镜像源：
```bash
# 一切加速镜像配置教程统一参考 清华大学开源软件镜像站 该站点拥有最详细的配置教程
# 清华大学开源软件镜像站 https://mirrors.tuna.tsinghua.edu.cn/help/

# 清华 RPMFusion 镜像源 https://mirrors.tuna.tsinghua.edu.cn/help/rpmfusion/
# 1、首先安装提供基础配置文件和 GPG 密钥的 rpmfusion-*.rpm。
sudo yum install --nogpgcheck https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# 2、安装成功后，修改链接指向镜像站   
sudo sed -e 's!^metalink=!#metalink=!g' \
         -e 's!^mirrorlist=!#mirrorlist=!g' \
         -e 's!^#baseurl=!baseurl=!g' \
         -e 's!https\?://download1\.rpmfusion\.org/!https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/!g' \
         -i.bak /etc/yum.repos.d/rpmfusion*.repo


# 阿里云 RPMFusion 镜像源 https://developer.aliyun.com/mirror/rpmfusion
# 1、首先安装提供基础配置文件和 GPG 密钥的 rpmfusion-*.rpm。
sudo yum install --nogpgcheck https://mirrors.aliyun.com/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# 2、安装成功后，修改链接指向镜像站         
sudo sed -e 's!^metalink=!#metalink=!g' \
         -e 's!^mirrorlist=!#mirrorlist=!g' \
         -e 's!^#baseurl=!baseurl=!g' \
         -e 's!https\?://download1\.rpmfusion\.org/!https://mirrors.aliyun.com/rpmfusion/!g' \
         -i.bak /etc/yum.repos.d/rpmfusion*.repo         

# 查看配置结果
cat /etc/yum.repos.d/rpmfusion-free.repo
```

---

#### **3. 启用 Fedora COPR 第三方仓库**

```bash
# 添加 Fedora COPR（Community Projects）第三方仓库
# Fedora COPR（Community Projects）第三方仓库。地址 https://copr.fedorainfracloud.org/
# dnf copr enable：启用一个 COPR（Community Projects）第三方仓库。
# peterwu/rendezvous：指定仓库作者（peterwu）和仓库名（rendezvous）。
sudo dnf copr enable <username>/<repository-name>
# 作用：将 peterwu/rendezvous 这个社区维护的软件仓库添加到您的 Fedora 系统中，之后可以通过 dnf install 安装该仓库中的软件包。
sudo dnf copr enable lcqh/fedora-themes
sudo dnf install lcqh-cursor-theme
sudo dnf install lcqh-icon-theme
sudo dnf install lcqh-gtk4-theme
flat-remix-gtk4-theme
# 检查系统中当前启用的所有仓库：
dnf repolist
sudo dnf config-manager --set-disabled copr:copr.fedorainfracloud.org:peterwu:rendezvous
```

---

### **4. 刷新缓存并测试速度**

```bash
sudo dnf clean all
sudo dnf makecache
sudo dnf update -y
```
- 检查速度是否提升，可通过 `dnf` 输出中的下载链接确认是否来自国内镜像。

---

### **5. 其他国内镜像源列表**

| 镜像名称       | 地址                                   |
| -------------- | -------------------------------------- |
| **清华镜像**   | `https://mirrors.tuna.tsinghua.edu.cn` |
| **中科大镜像** | `https://mirrors.ustc.edu.cn`          |
| **阿里云镜像** | `https://mirrors.aliyun.com`           |
| **华为云镜像** | `https://mirrors.huaweicloud.com`      |

替换时只需修改上述命令中的 `baseurl` 地址即可。

### **6. 添加 Flatpak 国内镜像**

如果已启用 Flatpak，可以替换其镜像源：

```bash
# 查看 Flatpak 远程仓库
flatpak remotes --show-details

# 添加 Flathub 官方仓库
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 修改 Flathub 仓库地址为国内镜像
# 上海交大 Flatpak 镜像源 https://mirrors.sjtug.sjtu.edu.cn/docs/flathub
sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
# 中科大 Flatpak 镜像源（处于测试阶段） https://mirrors.ustc.edu.cn/help/flathub.html
sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub

# 安装 Gnome 扩展管理
flatpak install -y flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub com.microsoft.Edge

# 恢复默认值
sudo flatpak remote-modify flathub --url=https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak update -y
flatpak list
flatpak list --app
# 删除未使用的运行时和应用程序
flatpak uninstall --unused
```

---

### **7. 安装系统基础依赖包**

```bash
# 在系统初次安装后，推荐先配置加速镜像源，然后再更新系统。
sudo dnf update -y && sudo dnf upgrade -y

sudo dnf install -y git unzip p7zip wl-clipboard \
gnome-tweaks gnome-extensions-app \
fastfetch timeshift evolution \
google-chrome-stable \
libreoffice-langpack-zh-Hans

# evolution配置qq邮箱授权码： embwnsuwkdjrebge
fastfetch

# 配置 Git
git config --global user.name "龙茶清欢"
git config --global user.email "2320391937@qq.com"
ssh-keygen -t rsa -b 4096 -C "2320391937@qq.com"
# 需要安装 wl-clipboard 工具
cat ~/.ssh/id_rsa.pub | wl-copy
# 配置 Gitee 密钥	https://gitee.com/profile/sshkeys
# 配置 Github 密钥	https://github.com/settings/keys

# 安装基础依赖包 https://v2.tauri.app/zh-cn/start/prerequisites/#linux
sudo dnf check-update
sudo dnf install webkit2gtk4.1-devel \
  openssl-devel \
  curl \
  wget \
  file \
  libappindicator-gtk3-devel \
  librsvg2-devel
sudo dnf group install "c-development"

# 配置Github访问加速
# 网站国内可用 DNS 测试 ping https://ping.chinaz.com/www.youtube.com
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

---

### **8. 安装多媒体编解码器**

```bash
# 作为 Fedora 用户和系统管理员，您可以使用这些步骤来安装额外的多媒体插件，使您能够播放各种视频和音频类型。参考 https://docs.fedoraproject.org/zh_Hans/quick-docs/installing-plugins-for-playing-movies-and-music/
sudo dnf group install multimedia

dnf list installed
sudo dnf install gnome-terminal
sudo dnf install dnf-plugins-core
# 参考 https://docs.fedoraproject.org/zh_CN/quick-docs/openh264/#_firefox_config_changes
sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264 mozilla-ublock-origin
# 配置 Firefox
在 Firefox 地址栏中键入 about:config 并接受警告。
在搜索字段中，输入 264，将出现一些选项。通过双击 false，为以下 Preference Names 指定 true 值：
media.gmp-gmpopenh264.autoupdate
media.gmp-gmpopenh264.enabled
media.gmp-gmpopenh264.provider.enabled
media.peerconnection.video.h264_enabled


sudo dnf install \
ffmpeg \                    # 通用音视频处理框架（支持多种格式）
gstreamer1-plugins-bad-* \  # "Bad"插件集（非自由/实验性编解码器，如MPEG-2、DTS）
gstreamer1-plugins-good-* \ # "Good"插件集（高质量自由编解码器，如MP3、H.264）
gstreamer1-plugins-base \   # GStreamer 基础插件（必须依赖项）
gstreamer1-plugin-openh264 \ # 开源H.264编解码器（用于WebRTC视频通话）
gstreamer1-libav \          # 基于FFmpeg的编解码器扩展（补充格式支持）
--exclude=gstreamer1-plugins-bad-free-devel  # 排除开发头文件（避免冲突）
```

