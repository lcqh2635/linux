在 Fedora 41 初次安装后，通过优化主题和字体配置，可以显著提升桌面美观度和阅读体验。以下是详细的配置指南，涵盖 **GTK 主题**、**图标主题**、**Shell 主题** 和 **字体优化**。

---

## **1. 安装主题管理工具**
首先安装必要的工具和插件：
```bash
# 安装 GNOME Tweaks（图形化设置工具）
sudo dnf install gnome-tweaks

# 安装扩展管理器（用于管理 GNOME 扩展）
sudo dnf install gnome-extensions-app

# 安装插件支持（可选，用于手动安装主题）
sudo dnf install gnome-shell-extension-user-theme
```
启用 `User Themes` 扩展：
- 打开 **GNOME Extensions**（`Alt+F2` 输入 `extensions`）  
- 启用 **User Themes**（允许使用自定义 Shell 主题）

---

## **2. 安装 GTK 主题**
Fedora 默认使用 **Adwaita** 主题，可以更换为更流行的主题（如 **Arc**、**Dracula**、**Catppuccin**）。

### **方法 1：通过 `dnf` 安装官方主题**
```bash
# 安装 Arc 主题
sudo dnf install arc-theme

# 安装 Materia 主题
sudo dnf install materia-theme

# 安装 Adwaita 暗色变体
sudo dnf install adwaita-dark
```

### **方法 2：手动安装第三方主题**
1. 下载主题（如从 [GNOME Look](https://www.gnome-look.org/)）  
2. 解压到 `~/.themes`（GTK 主题）或 `~/.local/share/themes`（系统级主题）  
   ```bash
   mkdir -p ~/.themes
   tar -xzvf theme-name.tar.gz -C ~/.themes
   ```
3. 在 **GNOME Tweaks** → **Appearance** → **Themes** 中选择新主题。

---

## **3. 安装图标主题**
### **推荐图标包**
```bash
# Papirus 图标（推荐）
sudo dnf install papirus-icon-theme

# Tela 图标
sudo dnf install tela-icon-theme

# Numix 图标
sudo dnf install numix-icon-theme
```
在 **GNOME Tweaks** → **Appearance** → **Icons** 中选择新图标。

---

## **4. 安装 Shell 主题（GNOME 顶部栏样式）**
Shell 主题需与 GNOME 版本兼容（Fedora 41 默认 GNOME 46+）。
### **推荐 Shell 主题**
- **WhiteSur**（类似 macOS）
- **Orchis**（Material 风格）
- **Fluent**（Windows 11 风格）

#### **安装方法**
1. 从 [GNOME Look](https://www.gnome-look.org/browse?cat=139) 下载 Shell 主题  
2. 解压到 `~/.themes`  
3. 在 **GNOME Tweaks** → **Appearance** → **Shell** 中选择主题（需启用 `User Themes` 扩展）。

---

## **5. 字体优化**
Fedora 默认字体为 **Cantarell**，可替换为更清晰的字体（如 **Noto**、**Inter**、**Fira Sans**）。

### **（1）安装常用字体**
```bash
# 微软字体（Arial、Times New Roman 等）
sudo dnf install mscore-fonts-all

# Google Noto 字体（支持多语言）
sudo dnf install google-noto-fonts

# 思源黑体/宋体（中文字体）
sudo dnf install adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts

# 等宽字体（编程推荐）
sudo dnf install fira-code-fonts jetbrains-mono-fonts
```

### **（2）调整字体渲染**
```bash
# 安装优化版 freetype（改善字体抗锯齿）
sudo dnf install freetype-freeworld
```
在 **GNOME Tweaks** → **Fonts** 中调整：
- **Interface Font** → `Noto Sans` 或 `Inter`  
- **Document Font** → `Noto Serif`  
- **Monospace Font** → `Fira Code` 或 `JetBrains Mono`  
- **Hinting** → `Slight`  
- **Antialiasing** → `RGBA`

---

## **6. 启用暗色模式**
```bash
# 全局启用暗色模式
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# 仅 GTK 应用暗色模式
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
```

---

## **7. 推荐主题组合**
| 风格         | GTK 主题 | 图标主题 | Shell 主题 | 字体           |
| ------------ | -------- | -------- | ---------- | -------------- |
| **macOS**    | WhiteSur | WhiteSur | WhiteSur   | SF Pro + Menlo |
| **Win11**    | Fluent   | Fluent   | Fluent     | Segoe UI       |
| **Material** | Materia  | Papirus  | Orchis     | Roboto         |
| **极简**     | Arc      | Tela     | Flat Remix | Inter          |

---

## **8. 恢复默认设置**
```bash
# 重置 GTK 主题
gsettings reset org.gnome.desktop.interface gtk-theme

# 重置图标
gsettings reset org.gnome.desktop.interface icon-theme

# 重置字体
gsettings reset org.gnome.desktop.interface font-name
```

---

### **总结**
- **主题管理**：使用 `GNOME Tweaks` 切换 GTK、图标和 Shell 主题。  
- **字体优化**：安装 `freetype-freeworld` 并选择适合的字体（如 `Inter` 或 `Noto Sans`）。  
- **暗色模式**：通过 `gsettings` 或 GNOME 设置启用。  

完成配置后，Fedora 41 的界面会更加美观且符合个人偏好！





在 **GNOME Tweaks** → **外观（Appearance）** 中，`样式` 和 `背景` 两个配置栏分别控制不同方面的视觉表现。以下是详细说明及对应的 `gsettings` 命令（含注释说明）：

---

## **1. 样式（Style）配置栏**
### **(1) 光标（Cursor）**
- **作用**：更改鼠标指针主题（如 `Adwaita`、`Bibata` 等）。
- **`gsettings` 命令**：
  ```bash
  # 查看当前光标主题
  gsettings get org.gnome.desktop.interface cursor-theme
  
  # 设置光标主题（例如改为 "Adwaita"）
  gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
  ```

### **(2) 图标（Icons）**
- **作用**：更改应用程序/文件的图标主题（如 `Papirus`、`Tela` 等）。
- **`gsettings` 命令**：
  ```bash
  # 查看当前图标主题
  gsettings get org.gnome.desktop.interface icon-theme
  
  # 设置图标主题（例如改为 "Papirus"）
  gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
  ```

### **(3) Shell**
- **作用**：更改 GNOME Shell 顶部栏和活动概述的视觉主题（需启用 `User Themes` 扩展）。
- **`gsettings` 命令**：
  ```bash
  # 查看当前 Shell 主题
  gsettings get org.gnome.shell.extensions.user-theme name
  
  # 设置 Shell 主题（例如改为 "Orchis"）
  gsettings set org.gnome.shell.extensions.user-theme name 'Orchis'
  ```

### **(4) 过时应用程序（Legacy Applications）**
- **作用**：为 GTK2/GTK3 旧版应用（如 GIMP、Thunderbird）指定备用主题（通常与 GTK4 主题不同）。
- **`gsettings` 命令**：
  ```bash
  # 查看当前旧版应用主题
  gsettings get org.gnome.desktop.interface gtk-theme
  
  # 设置旧版应用主题（例如改为 "Adwaita-dark"）
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
  ```

---

## **2. 背景（Background）配置栏**
### **(1) 默认图像（Default Image）**
- **作用**：设置桌面壁纸（仅对当前用户生效）。
- **`gsettings` 命令**：
  ```bash
  # 查看当前壁纸路径
  gsettings get org.gnome.desktop.background picture-uri
  
  # 设置壁纸（需使用绝对路径，例如 "/home/user/Pictures/wallpaper.jpg"）
  gsettings set org.gnome.desktop.background picture-uri 'file:///home/user/Pictures/wallpaper.jpg'
  ```

### **(2) 暗色样式图像（Dark Style Image）**
- **作用**：在暗色模式下使用不同的壁纸（需启用 GNOME 的暗色模式）。
- **`gsettings` 命令**：
  ```bash
  # 查看暗色模式壁纸路径
  gsettings get org.gnome.desktop.background picture-uri-dark
  
  # 设置暗色模式壁纸
  gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/user/Pictures/wallpaper-dark.jpg'
  ```

### **(3) 调整（Adjustment）**
- **作用**：控制壁纸的显示方式（如缩放、填充、平铺等）。  
  可选值：`none`（原始大小）、`wallpaper`（平铺）、`centered`（居中）、`scaled`（缩放）、`stretched`（拉伸）、`zoom`（充满）、`spanned`（跨屏）。
- **`gsettings` 命令**：
  ```bash
  # 查看当前壁纸显示模式
  gsettings get org.gnome.desktop.background picture-options
  
  # 设置壁纸显示模式（例如改为 "zoom" 充满屏幕）
  gsettings set org.gnome.desktop.background picture-options 'zoom'
  ```

---

## **3. 其他相关设置**
### **(1) 全局暗色模式开关**
```bash
# 启用暗色模式（同时影响 GTK 应用和 Shell）
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# 恢复亮色模式
gsettings set org.gnome.desktop.interface color-scheme 'default'
```

### **(2) 重置所有外观设置**
```bash
# 重置所有 GTK 相关设置（恢复默认主题、图标、字体等）
gsettings reset-recursively org.gnome.desktop.interface
gsettings reset-recursively org.gnome.desktop.background
```

---

## **总结表**
| 配置项           | `gsettings` 路径                                | 示例命令（设置值）                                           |
| ---------------- | ----------------------------------------------- | ------------------------------------------------------------ |
| **光标主题**     | `org.gnome.desktop.interface cursor-theme`      | `gsettings set ... cursor-theme 'Adwaita'`                   |
| **图标主题**     | `org.gnome.desktop.interface icon-theme`        | `gsettings set ... icon-theme 'Papirus'`                     |
| **Shell 主题**   | `org.gnome.shell.extensions.user-theme name`    | `gsettings set ... name 'Orchis'`                            |
| **旧版应用主题** | `org.gnome.desktop.interface gtk-theme`         | `gsettings set ... gtk-theme 'Adwaita-dark'`                 |
| **壁纸路径**     | `org.gnome.desktop.background picture-uri`      | `gsettings set ... picture-uri 'file:///path/to/img.jpg'`    |
| **暗色模式壁纸** | `org.gnome.desktop.background picture-uri-dark` | `gsettings set ... picture-uri-dark 'file:///path/to/dark-img.jpg'` |
| **壁纸显示模式** | `org.gnome.desktop.background picture-options`  | `gsettings set ... picture-options 'zoom'`                   |

通过 `gsettings` 命令，你可以快速脚本化这些配置，或备份/恢复个性化设置。









以下是针对 Fedora 41（GNOME 桌面）的视觉优化全攻略，涵盖 **主题美化**、**动画调优**、**显示增强** 和 **性能平衡**，兼顾美观与流畅性：

---

### **一、主题与外观深度定制**
#### 1. **GTK 主题 + Shell 主题**
- **推荐组合**：
  - **现代扁平风**：`adw-gtk3`（GTK4/GTK3 统一风格） + `Orchis Shell`
  - **暗黑科技感**：`Juno`（GTK） + `Fluent Shell`
  - **macOS 风格**：`WhiteSur`（GTK + Shell + 图标全家桶）
- **安装与切换**：
  ```bash
  # 安装 adw-gtk3（适配 libadwaita 应用）
  sudo dnf install adw-gtk3-theme
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
  gsettings set org.gnome.shell.extensions.user-theme name 'Orchis'
  ```

#### 2. **图标与光标**
- **图标包**：
  ```bash
  sudo dnf install papirus-icon-theme tela-circle-icon-theme  # 彩色+圆形变体
  gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
  ```
- **光标主题**：
  ```bash
  sudo dnf install breeze-cursor-theme  # 更平滑的指针
  gsettings set org.gnome.desktop.interface cursor-theme 'Breeze'
  ```

#### 3. **壁纸动态切换**
- **自动更换壁纸**：
  ```bash
  sudo dnf install variety  # 动态壁纸工具
  ```
  配置规则：每小时更换 `~/Pictures/Wallpapers` 下的图片，支持在线下载。

---

### **二、显示效果增强**
#### 1. **字体优化**
- **安装高级字体**：
  ```bash
  sudo dnf install inter-fonts firacode-fonts noto-fonts-cjk  # 中文用思源黑体
  ```
- **抗锯齿与微调**：
  ```bash
  gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'  # 子像素渲染
  gsettings set org.gnome.desktop.interface font-hinting 'slight'    # 轻微字型优化
  ```

#### 2. **高分屏缩放**
- **整数缩放（200%）**：
  ```bash
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
  gsettings set org.gnome.desktop.interface scaling-factor 2
  ```
- **分数缩放（125%/150%）**：
  ```bash
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
  gsettings set org.gnome.mutter fractional-scaling true
  ```

#### 3. **夜间模式与蓝光过滤**
- **定时切换**：
  ```bash
  gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
  gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true  # 日出日落自动切换
  ```
- **手动调整色温**：
  ```bash
  gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3700  # 值越低越暖（默认4000）
  ```

---

### **三、动画效果调优**
#### 1. **加速动画速度**
- **缩短动画时长**：
  ```bash
  gsettings set org.gnome.desktop.interface enable-animations true
  gsettings set org.gnome.shell.animation speed-multiplier 0.7  # 默认1.0，值越小越快
  ```
- **禁用特定动画**（如工作区切换）：
  ```bash
  gsettings set org.gnome.desktop.interface enable-hot-corners false  # 禁用角落动画
  ```

#### 2. **GNOME Shell 特效**
- **启用模糊特效**：
  ```bash
  # 安装扩展
  gnome-extensions install blur-my-shell@aunetx
  # 启用并配置（需重启GNOME：Alt+F2 → r）
  gsettings set org.gnome.shell.extensions.blur-my-shell brightness 0.9  # 模糊亮度
  ```

#### 3. **窗口动画优化**
- **更流畅的窗口管理**：
  ```bash
  sudo dnf install mutter-performance  # 优化版Mutter（如官方仓库无此包，需从COPR安装）
  gsettings set org.gnome.mutter framerate 144  # 高刷新率屏幕可设
  ```

---

### **四、高级视觉增强**
#### 1. **透明化终端与面板**
- **终端透明**（如 GNOME Terminal）：
  ```bash
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')/ background-transparency-percent 10
  ```
- **面板透明**（需扩展）：
  ```bash
  gnome-extensions install transparent-top-bar@ftpix.com
  ```

#### 2. **动态工作区缩略图**
- **启用预览动画**：
  ```bash
  gsettings set org.gnome.shell.extensions.dash-to-dock show-workspaces true
  gsettings set org.gnome.shell.animation workspace-switch-animation 'slide'  # 或 'fade'
  ```

#### 3. **登录界面美化**
- **修改 GDM 主题**（谨慎操作）：
  ```bash
  sudo cp -r ~/.themes/YourTheme /usr/share/gnome-shell/theme/
  sudo update-alternatives --config gdm3-theme.gresource  # 选择主题
  ```

---

### **五、性能与美观平衡**
- **减少内存占用**：
  ```bash
  gsettings set org.gnome.desktop.interface overlay-scrolling false  # 禁用滚动条动画
  gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'  # 禁用动态透明度计算
  ```
- **游戏模式优化**：
  ```bash
  sudo dnf install gamemode
  gamemoded -s  # 查看状态，游戏时自动启用
  ```

---

### **六、一键备份配置**
```bash
# 导出所有视觉相关设置
dconf dump /org/gnome/desktop/ > ~/gnome-visual-settings.dconf
dconf dump /org/gnome/shell/ >> ~/gnome-visual-settings.dconf
# 恢复时：dconf load /org/gnome/ < ~/gnome-visual-settings.dconf
```

---

### **最终效果对比**
| 优化前（默认）    | 优化后                       |
| ----------------- | ---------------------------- |
| 扁平 Adwaita 主题 | 深度定制的 GTK4 + Shell 主题 |
| 静态壁纸          | 动态自动更换壁纸             |
| 60Hz 普通动画     | 144Hz 平滑动画 + 模糊特效    |
| 标准字体渲染      | 子像素抗锯齿 + Inter 字体    |
| 固定色温          | 智能夜间模式                 |

通过以上调整，Fedora 41 可同时获得 **macOS 级的美观** 和 **电竞级的流畅度**。根据硬件性能适当取舍特效即可。







在 GNOME 桌面环境中，`gsettings set org.gnome.desktop.wm.preferences theme` 命令用于设置 **窗口管理器（Window Manager）的主题**，它控制的是 **窗口边框、标题栏、最小化/最大化/关闭按钮等非客户区（non-client area）的视觉样式**。以下是详细说明：

---

### **1. 作用解析**
- **影响的元素**：
  - 窗口标题栏（包括按钮、文字、图标）
  - 窗口边框（如阴影、边框粗细）
  - 窗口菜单（右键点击标题栏时的弹出菜单）

- **不影响的元素**：
  - 应用程序内部界面（由 GTK 主题控制，需通过 `org.gnome.desktop.interface gtk-theme` 设置）
  - 图标（由图标主题控制，需通过 `org.gnome.desktop.interface icon-theme` 设置）
  - Shell 主题（如顶栏、概览，需通过 `org.gnome.shell.extensions.user-theme` 设置）

---

### **2. 主题的实际用途**
- **视觉一致性**：使窗口装饰与系统整体风格统一（如暗色模式、圆角设计）。
- **功能区分**：通过颜色或形状区分活动窗口与非活动窗口。
- **用户体验优化**：调整按钮大小、间距等提升操作舒适度。

---

### **3. 常用操作示例**
#### **查看当前窗口管理器主题**
```bash
gsettings get org.gnome.desktop.wm.preferences theme
```
默认值通常为 `Adwaita`（GNOME 默认主题）。

#### **设置新主题（需先安装主题包）**
```bash
# 例如切换到 Adwaita-dark（深色窗口装饰）
gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita-dark'
```

#### **与其他主题的关系**
```bash
# 设置 GTK 主题（应用内部样式）
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# 设置图标主题
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
```

---

### **4. 主题文件存放位置**
窗口管理器主题通常安装在以下目录：
- `/usr/share/themes/`（系统全局）
- `~/.themes/`（用户自定义）

例如，`Adwaita` 主题的窗口管理器样式文件位于：  
`/usr/share/themes/Adwaita/metacity-1/`

---

### **5. 常见问题**
#### **Q：为什么改了窗口主题没效果？**
- **原因1**：主题未正确安装（检查 `/usr/share/themes/` 是否存在对应主题）。
- **原因2**：Wayland 下部分主题兼容性差（可尝试切换到 X11 会话）。
- **原因3**：使用了不支持 GNOME 的旧主题（如 Metacity 主题需适配 GNOME Shell）。

#### **Q：如何自定义窗口按钮布局？**
通过 `gsettings` 调整按钮顺序和显示：
```bash
# 将关闭按钮移到左侧
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
```

---

### **6. 主题效果对比**
| **主题类型**       | **控制范围**                | **设置命令示例**                                             |
| ------------------ | --------------------------- | ------------------------------------------------------------ |
| **窗口管理器主题** | 窗口边框/标题栏             | `gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita-dark'` |
| **GTK 主题**       | 应用内部控件（按钮/输入框） | `gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'` |
| **图标主题**       | 文件管理器/应用图标         | `gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'` |

---

### **总结**
- `org.gnome.desktop.wm.preferences theme` **仅控制窗口装饰**，需搭配 GTK 主题和图标主题实现完整视觉统一。
- 推荐使用 **Adwaita** 或 **匹配 GTK 主题的窗口主题** 以避免风格冲突。
- 调试时可使用 [GNOME Tweaks](https://wiki.gnome.org/Apps/Tweaks) 工具直观调整。









sudo flatpak override --filesystem=xdg-config/gtk-3.0

sudo flatpak override --filesystem=xdg-config/gtk-4.0



https://itsfoss.com/flatpak-app-apply-theme/
参考 https://docs.flatpak.org/zh-cn/latest/desktop-integration.html



官网 https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations

export QT_QPA_PLATFORM=wayland

sudo dnf install -y qadwaitadecorations-qt5 qadwaitadecorations-qt6

export QT_WAYLAND_DECORATION=adwaita

需要自行安装 QWhiteSurGtkDecorations

export QT_WAYLAND_DECORATION=whitesur-gtk

export QT_STYLE_OVERRIDE=kvantum

source ~/.bashrc

```bash
sudo dnf install -y git cmake gtk3-devel gtk4-devel
sudo dnf install -y qt5-qtbase-devel qt5-qttools-devel qt5-qtwayland qt6-qtwayland
sudo dnf install qt5-qtsvg-devel
sudo dnf install qt5-qtwayland-devel
sudo dnf install cmake make qt5-qtsvg qt5-qtwayland qt6-qtsvg qt6-qtwayland
sudo dnf install gtk4-devel libadwaita-devel
# 提供 统一的桌面服务接口，允许 Flatpak/Snap 等沙箱应用与宿主桌面环境（如 GNOME、KDE）安全交互。
xdg-desktop-portal
# 通用（GTK 基础实现）提供基本的 GTK 对话框，兼容所有环境，但功能较简陋。
xdg-desktop-portal-gtk
# 深度集成 GNOME 原生服务（如 GNOME 风格的文件选择器、截图工具）。
xdg-desktop-portal-gnome

git clone https://github.com/nedrysoft/SettingsDialog.git
cd SettingsDialog
mkdir build && cd build
cmake ..
make
sudo make install

git clone https://github.com/nedrysoft/ThemeSupport.git
cd ThemeSupport
mkdir build && cd build
cmake -DCMAKE_PREFIX_PATH=/usr/lib64/cmake ..
sudo dnf install -y qt5-designer.x86_64
https://aur.archlinux.org/packages/qwhitesurgtkdecorations-qt6

# QWhiteSurGtkDecorations 基于 QAdwaitaDecorations 改造而来
sudo dnf install -y qadwaitadecorations-qt5 qadwaitadecorations-qt6
# 但是仓库中没有 qwhitesurgtkdecorations-qt5 qwhitesurgtkdecorations-qt6
sudo dnf install -y qwhitesurgtkdecorations-qt5 qwhitesurgtkdecorations-qt6
git clone https://aur.archlinux.org/qwhitesurgtkdecorations.git

cd ~/下载
git clone https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations.git
cd QWhiteSurGtkDecorations
# 编译安装
mkdir build && cd build
sudo find /usr -name "Qt5SvgConfig.cmake"
sudo find /usr -name "Qt5WaylandClientConfig.cmake"
cmake -DCMAKE_PREFIX_PATH=/usr/lib64/cmake ..
make
sudo make install

# 清理并重新生成构建目录
rm -rf build/
mkdir build
cd build
cmake ..
make
```



flatpak remote-ls --columns=application flathub | grep org.kde.KStyle
flatpak install flathub org.kde.KStyle.Kvantum

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --env=GTK_THEME=my-theme
sudo flatpak override --env=ICON_THEME=my-icon-theme

sudo flatpak override org.gnome.Calculator --filesystem=$HOME/.themes
sudo flatpak override org.gnome.Calculator --filesystem=$HOME/.icons
sudo flatpak override org.gnome.Calculator --env=GTK_THEME=my-theme 
sudo flatpak override org.gnome.Calculator --env=ICON_THEME=my-icon-theme 

flatpak install org.kde.KStyle.Kvantum
sudo flatpak override --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro <name of flatpak app>
sudo flatpak override --reset

sudo flatpak override --show

# 列出所有已安装的 Flatpak 应用和运行时

flatpak list

# 查看应用使用的运行时等信息

flatpak list --app

sudo flatpak override --reset org.example.app


# 参考 https://docs.flatpak.org/zh-cn/latest/desktop-integration.html#theming

On Wayland, starting from the 5.15-22.08+ and 6.5+ branches of the org.kde.Platform runtime, org.kde.WaylandDecoration.QAdwaitaDecorations and org.kde.WaylandDecoration.QGnomePlatform-decoration need to be installed. Please see the upstream usage instructions as well.

For older runtimes, org.kde.PlatformTheme.QGnomePlatform and org.kde.WaylandDecoration.QGnomePlatform-decoration need to be installed.

org.kde.Platform runtime
org.kde.WaylandDecoration.QAdwaitaDecorations
org.kde.WaylandDecoration.QGnomePlatform-decoration
org.kde.PlatformTheme.QGnomePlatform