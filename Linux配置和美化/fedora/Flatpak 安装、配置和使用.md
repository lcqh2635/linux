在 Flatpak 中查看当前配置（包括权限覆盖、运行时设置等）可以通过以下方法实现：

---

### 一、查看全局或用户级覆盖配置
#### 1. **查看所有应用的全局覆盖配置**
```bash
flatpak override --show
```
- **作用**：显示通过 `flatpak override` 设置的全局权限规则（如文件系统访问、环境变量等）。
- **输出示例**：
  ```
  [Context]
  filesystems=/usr/share/themes:ro;~/.themes:ro
  env=GTK_THEME=WhiteSur
  ```

#### 2. **查看特定应用的覆盖配置**
```bash
flatpak override --show <应用ID>
```
- **示例**（查看 VLC 的覆盖配置）：
  ```bash
  flatpak override --show org.videolan.VLC
  ```

---

### 二、查看已安装应用和运行时
#### 1. **列出所有已安装的 Flatpak 应用和运行时**
```bash
flatpak list
```
- **输出列**：应用ID、分支、版本、来源仓库、安装位置（用户/系统）。

#### 2. **查看应用的详细信息**
```bash
flatpak info <应用ID>
```
- **示例**：
  ```bash
  flatpak info org.gnome.Epiphany
  ```
- **关键信息**：  
  - 运行时依赖（如 `org.gnome.Platform`）  
  - 文件系统访问权限（`Context → filesystems`）  
  - 环境变量（`Context → env`）

---

### 三、查看配置文件
#### 1. **系统级配置文件**
Flatpak 的全局配置文件位于：
```bash
/etc/flatpak/installations.conf
```
- **作用**：定义默认安装位置和仓库优先级。

#### 2. **用户级配置目录**
用户级覆盖配置存储在：
```bash
~/.local/share/flatpak/overrides/
```
- **文件内容**：  
  - `global` 文件：全局覆盖配置。  
  - `<应用ID>` 文件：单个应用的覆盖配置。

#### 3. **查看全局覆盖文件**
```bash
cat ~/.local/share/flatpak/overrides/global
```

---

### 四、检查运行时和权限
#### 1. **查看运行时包含的依赖**
```bash
flatpak run --runtime=org.kde.Platform/x86_64/6.8 --command=bash
```
- **作用**：进入运行时的沙盒环境，手动检查文件系统访问和库依赖。

#### 2. **检查沙盒内文件系统挂载**
```bash
flatpak-spawn --host ls /usr/share/themes
```
- **作用**：在沙盒内验证是否能访问宿主机的主题目录。

---

### 五、调试命令
#### 1. **查看应用实际加载的 GTK 主题**
```bash
flatpak run --env=GTK_DEBUG=all <应用ID>
```
- **输出**：GTK 主题加载日志。

#### 2. **查看 Qt 应用的主题引擎**
```bash
flatpak run --env=QT_DEBUG_PLUGINS=1 <应用ID>
```
- **输出**：Qt 插件加载日志（包括主题引擎）。

---

### 六、总结
| **需求场景**           | **对应命令**                               |
| ---------------------- | ------------------------------------------ |
| 查看全局覆盖配置       | `flatpak override --show`                  |
| 查看单个应用的覆盖配置 | `flatpak override --show <应用ID>`         |
| 列出所有已安装应用     | `flatpak list`                             |
| 查看应用详细权限       | `flatpak info <应用ID>`                    |
| 手动检查沙盒内文件系统 | `flatkat-spawn --host ls <路径>`           |
| 调试主题加载问题       | `flatpak run --env=GTK_DEBUG=all <应用ID>` |

通过上述命令，你可以全面掌握 Flatpak 的配置状态，验证权限覆盖是否生效，并快速定位主题或权限相关的问题。







以下是 **Flatpak 常用命令及其作用** 的表格总结，适用于 Fedora 或其他 Linux 发行版：

---

| **命令**                            | **作用**                                    | **示例**                                                     |
| ----------------------------------- | ------------------------------------------- | ------------------------------------------------------------ |
| **基本管理**                        |                                             |                                                              |
| `flatpak install <远程仓库> <应用>` | 安装应用                                    | `flatpak install flathub org.telegram.desktop`               |
| `flatpak uninstall <应用>`          | 卸载应用                                    | `flatpak uninstall org.telegram.desktop`                     |
| `flatpak update`                    | 更新所有已安装的 Flatpak 应用               | `flatpak update`                                             |
| `flatpak list`                      | 列出已安装的应用                            | `flatpak list`                                               |
| `flatpak search <关键词>`           | 搜索远程仓库中的应用                        | `flatpak search telegram`                                    |
| **仓库管理**                        |                                             |                                                              |
| `flatpak remote-add <名称> <URL>`   | 添加远程仓库（如 Flathub）                  | `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo` |
| `flatpak remote-list`               | 列出已配置的远程仓库                        | `flatpak remote-list`                                        |
| `flatpak remote-delete <名称>`      | 删除远程仓库                                | `flatpak remote-delete flathub`                              |
| **运行与权限**                      |                                             |                                                              |
| `flatpak run <应用>`                | 运行已安装的应用                            | `flatpak run org.gimp.GIMP`                                  |
| `flatpak override <应用>`           | 修改应用的权限（如文件访问、网络）          | `flatpak override --filesystem=~/Documents org.gimp.GIMP`    |
| `flatpak permissions <应用>`        | 查看应用的权限设置                          | `flatpak permissions org.gimp.GIMP`                          |
| **系统维护**                        |                                             |                                                              |
| `flatpak repair`                    | 修复损坏的 Flatpak 安装或依赖               | `flatpak repair`                                             |
| `flatpak uninstall --unused`        | 删除未使用的运行时（节省空间）              | `flatpak uninstall --unused`                                 |
| `flatpak info <应用>`               | 显示应用的详细信息（版本、运行时等）        | `flatpak info org.gimp.GIMP`                                 |
| **高级操作**                        |                                             |                                                              |
| `flatpak history`                   | 查看 Flatpak 操作历史（安装/更新/卸载记录） | `flatpak history`                                            |
| `flatpak mask <应用>`               | 阻止应用或运行时更新                        | `flatpak mask org.gimp.GIMP`                                 |
| `flatpak enter <应用>`              | 进入应用的沙箱环境（调试用）                | `flatpak enter org.gimp.GIMP /bin/bash`                      |

---

### **关键说明**
1. **远程仓库**  
   - 默认推荐添加 `flathub`（最大的 Flatpak 应用仓库）：  
     ```bash
     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
     ```
2. **权限控制**  
   - 通过 `override` 可限制或扩展应用权限（如禁用访问家目录以外的文件）：  
     ```bash
     flatpak override --nofilesystem=home org.telegram.desktop
     ```
3. **清理空间**  
   - 定期运行 `flatpak uninstall --unused` 删除旧版本运行时。

4. **应用 ID 格式**  
   - Flatpak 应用 ID 通常为反向域名格式（如 `org.gimp.GIMP`），需完整输入。

---

### **常用场景示例**
- **安装 LibreOffice**：  
  ```bash
  flatpak install flathub org.libreoffice.LibreOffice
  ```
- **允许 GIMP 访问外部存储**：  
  ```bash
  flatpak override --filesystem=/mnt/data org.gimp.GIMP
  ```
- **彻底删除应用及数据**：  
  ```bash
  flatpak uninstall --delete-data org.telegram.desktop
  ```

Flatpak 的优势在于 **沙箱化** 和 **跨发行版支持**，适合需要隔离或最新版软件的场景。