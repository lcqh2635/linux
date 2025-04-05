Fedora Workstation 主要使用 **`dnf`**（新一代 RPM 包管理器）和 **`flatpak`**（跨发行版沙盒化软件包），以下是常用命令及其作用详解：

---

### **1. DNF 命令（核心包管理）**
#### **基础操作**
| 命令 | 作用 | 示例 |
|------|------|------|
| `sudo dnf update` | 更新**所有已安装的软件包**（相当于 `upgrade`） | `sudo dnf update` |
| `sudo dnf upgrade` | 同上，与 `update` 完全等价 | `sudo dnf upgrade` |
| `sudo dnf install <包名>` | 安装指定软件包 | `sudo dnf install neovim` |
| `sudo dnf remove <包名>` | 卸载软件包（保留配置文件） | `sudo dnf remove firefox` |
| `sudo dnf autoremove` | 删除无用的依赖包 | `sudo dnf autoremove` |
| `sudo dnf search <关键词>` | 搜索软件包 | `sudo dnf search python3` |
| `sudo dnf info <包名>` | 查看软件包详细信息 | `sudo dnf info git` |

#### **高级操作**
| 命令 | 作用 | 示例 |
|------|------|------|
| `sudo dnf group list` | 查看软件包组（如开发工具组） | `sudo dnf group list` |
| `sudo dnf group install "组名"` | 安装软件包组 | `sudo dnf group install "Development Tools"` |
| `sudo dnf history` | 查看操作历史（可回滚） | `sudo dnf history undo 3` |
| `sudo dnf repoquery <包名>` | 查询仓库中包的依赖关系 | `sudo dnf repoquery --requires httpd` |
| `sudo dnf clean all` | 清理缓存（`/var/cache/dnf`） | `sudo dnf clean all` |

---

### **2. Flatpak 命令（沙盒化应用）**
| 命令 | 作用 | 示例 |
|------|------|------|
| `flatpak install <远程仓库> <应用ID>` | 安装 Flatpak 应用 | `flatpak install flathub com.spotify.Client` |
| `flatpak run <应用ID>` | 运行 Flatpak 应用 | `flatpak run org.telegram.desktop` |
| `flatpak update` | 更新所有 Flatpak 应用 | `flatpak update` |
| `flatpak list` | 列出已安装的 Flatpak 应用 | `flatpak list` |
| `flatpak uninstall <应用ID>` | 卸载 Flatpak 应用 | `flatpak uninstall org.gimp.GIMP` |
| `flatpak search <关键词>` | 搜索 Flatpak 应用 | `flatpak search discord` |

---

### **3. RPM 命令（底层包工具）**
> 注：通常优先用 `dnf`，`rpm` 仅用于特殊情况（如直接安装 `.rpm` 文件）。

| 命令 | 作用 | 示例 |
|------|------|------|
| `rpm -ivh <包名.rpm>` | 安装本地 RPM 包 | `sudo rpm -ivh package.rpm` |
| `rpm -e <包名>` | 卸载 RPM 包 | `sudo rpm -e package` |
| `rpm -qa` | 列出所有已安装的 RPM 包 | `rpm -qa \| grep python` |
| `rpm -qi <包名>` | 查询包信息 | `rpm -qi bash` |
| `rpm -ql <包名>` | 列出包安装的文件 | `rpm -ql httpd` |

---

### **4. 其他实用命令**
#### **COPR（社区仓库）**
```bash
# 启用 COPR 仓库（第三方非官方源）
sudo dnf copr enable user/repo

# 示例：启用 RPM Fusion 的 Steam 支持
sudo dnf copr enable rpmfusion/steam

# 配置清华加速仓库，参考 https://mirrors.tuna.tsinghua.edu.cn/help/fedora/
sed -e 's|^metalink=|#metalink=|g' \
    -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' \
    -i.bak \
    /etc/yum.repos.d/fedora.repo \
    /etc/yum.repos.d/fedora-updates.repo

# 更新本地缓存
sudo dnf makecache


# 安装 RPM Fusion 并更换清华源
# RPM Fusion 为 Fedora/RHEL 提供额外的大量 RPM 软件包的第三方软件源。
sudo dnf install --nogpgcheck https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.tuna.tsinghua.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


作者: insidentally
链接: https://www.insidentally.com/articles/000039/
来源: 无妄当自持
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```

#### **Toolbox（容器化开发环境）**
```bash
# 创建容器
toolbox create myenv

# 进入容器
toolbox enter myenv
```

---

### **关键场景示例**
1. **安装开发工具链**：
   ```bash
   sudo dnf group install "Development Tools"
   sudo dnf install git gcc cmake
   ```

2. **清理系统**：
   ```bash
   sudo dnf autoremove
   sudo dnf clean all
   ```

3. **安装商业软件（如 VS Code）**：
   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/vscode
   sudo dnf install code
   ```

---

### **总结表**
| **工具**   | **用途**                  | **优势**                          |
|------------|---------------------------|-----------------------------------|
| `dnf`      | 系统级软件管理            | 依赖解决完善，支持事务回滚        |
| `flatpak`  | 沙盒化应用（如Spotify）   | 隔离依赖，避免冲突                |
| `rpm`      | 直接操作 RPM 包           | 底层控制，适合调试                |
| `toolbox`  | 容器化开发环境            | 不污染主机系统                    |

建议优先使用 `dnf` 管理核心软件，`flatpak` 安装桌面应用，`toolbox` 隔离开发环境。
