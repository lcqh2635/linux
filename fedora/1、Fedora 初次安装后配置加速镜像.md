在 Fedora 41 初次安装后，配置国内镜像源可以显著提升软件包下载速度（尤其是 `dnf` 更新和安装软件时）。以下是详细步骤：

---

### **1. 备份默认镜像配置**
```bash
sudo cp /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.backup
sudo cp /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.backup
```

---

### **2. 替换为国内镜像源**
#### **方法一：手动修改 repo 文件**
编辑 Fedora 官方仓库文件，将 `metalink` 替换为国内镜像 URL（以 **清华镜像** 为例）：
```bash
sudo sed -i 's|metalink=|#metalink=|g' /etc/yum.repos.d/fedora.repo
sudo sed -i 's|#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' /etc/yum.repos.d/fedora.repo

sudo sed -i 's|metalink=|#metalink=|g' /etc/yum.repos.d/fedora-updates.repo
sudo sed -i 's|#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' /etc/yum.repos.d/fedora-updates.repo
```

#### **方法二：直接下载预配置 repo 文件（推荐）**
```bash
# 清华镜像
sudo curl -o /etc/yum.repos.d/fedora.repo https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/41/Everything/x86_64/os/repo/fedora.repo
sudo curl -o /etc/yum.repos.d/fedora-updates.repo https://mirrors.tuna.tsinghua.edu.cn/fedora/updates/41/Everything/x86_64/os/repo/fedora-updates.repo
```

---

### **3. 添加 RPM Fusion 国内镜像（可选）**
如果已启用 RPM Fusion，可以替换其镜像源：
```bash
# 替换 free 仓库
sudo sed -i 's|baseurl=http://download1.rpmfusion.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn/rpmfusion|g' /etc/yum.repos.d/rpmfusion-free.repo

# 替换 nonfree 仓库
sudo sed -i 's|baseurl=http://download1.rpmfusion.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn/rpmfusion|g' /etc/yum.repos.d/rpmfusion-nonfree.repo
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

---

### **6. 注意事项**
1. **版本号匹配**：确保 URL 中的 `41` 与你的 Fedora 版本一致（例如 Fedora 40 需改为 `40`）。
2. **网络问题**：如果某些镜像不稳定，可尝试切换其他源。
3. **Flatpak 镜像**（如需加速 Flatpak）：
   ```bash
   flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
   ```

完成以上步骤后，`dnf` 安装和更新速度会有明显改善。