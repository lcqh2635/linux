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