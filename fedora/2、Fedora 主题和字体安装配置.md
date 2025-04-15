在 Fedora 41 初次安装后，通过优化主题和字体配置，可以显著提升桌面美观度和阅读体验。以下是详细的配置指南，涵盖 **GTK 主题**、**图标主题**、**Shell 主题** 和 **字体优化**。

---

## **1. 安装主题管理工具**
首先安装必要的工具和插件：
```bash
# 基础窗口优化
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.interface show-battery-percentage true

# 安装 GNOME Tweaks（图形化设置工具）
sudo dnf install -y \
gnome-tweaks \
gnome-extensions-app \
gnome-shell-extension-user-theme

# 安装配置系统字体
sudo dnf install -y \
adobe-source-han-sans-cn-fonts \
adobe-source-han-serif-cn-fonts \
jetbrains-mono-fonts

gsettings set org.gnome.desktop.interface font-name '思源黑体 CN Medium 12'
gsettings set org.gnome.desktop.interface document-font-name '思源宋体 CN Medium 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font '思源黑体 CN Bold 12'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'slight'

# Fedora 系统默认自带的主题存放目录
# 光标主题：
ls /usr/share/icons/
# 图标主题：
ls /usr/share/icons/
# GTK 主题和 GNOME Shell 主题：
ls /usr/share/themes/

# Fedora 用户安装的主题存放目录
ls ~/.icons/
# 用户自定义的图标主题可以存放在 `~/.local/share/icons/` 目录下，这是符合 XDG Base Directory Specification（XDG 基础目录规范）的设计。这个规范旨在标准化用户配置文件和数据的存放位置，以提高系统的组织性和灵活性。
ls ~/.local/share/icons/
ls ~/.themes/
```
启用 `User Themes` 扩展：
- 打开 **GNOME Extensions**（`Alt+F2` 输入 `extensions`）  
- 启用 **User Themes**（允许使用自定义 Shell 主题）

---

## **2. 安装 GTK 主题**
Fedora 默认使用 **Adwaita** 主题，可以更换为更流行的主题（如 **Arc**、**Dracula**、**Catppuccin**）。

### **方法 1：通过 `dnf` 安装官方主题**
```bash
# 在 Github 范县一个好项目 adw-gtk3
https://github.com/lassekongo83/adw-gtk3

# 在 Fedora 中安装 adw-gtk3-theme 安装后的主题存放目录 ~/.local/share/themes/
sudo dnf install -y adw-gtk3-theme

# 2、如果您使用 flatpak 应用程序，则有 2 个选项来使用主题（仅选择一个）：
# 2-1、从 Flathub 安装主题： 
flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

# 2-2、或者，可以使用 FlatPak override。使用此选项的好处是，将对 Flathub 中的非 libadwaita GTK4 应用程序设置样式。为此，主题必须安装在 ~/.local/share/themes 中。从终端运行：
sudo flatpak override --filesystem=xdg-data/themes && sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3 && sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3-dark

sudo flatpak override --reset
# 3、然后，您可以在应用程序 gnome-tweaks 中启用 adw-gtk3。（某些应用程序可能需要重新登录）

# 如果你使用 dark 主题，你还需要在 设置 中启用 dark 外观。或者，您可以使用终端设置主题：
# 1、将主题更改为 adw-gtk3 light：
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'
# 2、将主题更改为 adw-gtk3-dark：
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# 3、恢复到 GNOME 的默认主题：
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' && gsettings set org.gnome.desktop.interface color-scheme 'default'

# 自定义 adw-gtk3 主题 （修改窗口控制按钮颜色）
https://github.com/lassekongo83/adw-colors

sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0


# 如果您想在 GNOME 47 或更高版本中更改大多数应用程序的强调色，那么您可以使用小的 cli 程序 accent-color-change。
https://github.com/lassekongo83/adw-colors/tree/main/accent-color-change
wget https://github.com/lassekongo83/adw-colors/raw/refs/heads/main/accent-color-change/accent-color-change.sh

sh accent-color-change.sh
# Adw-gtk3 和 libadwaita 可以使用 GTK 命名颜色进行自定义。有关更多信息，请参阅 adw-colors。
# 注意： GTK3 不支持 GNOME 47 中引入的强调色功能。只有 libadwaita 可以。


# https://github.com/birneee/obsidian-adwaita-theme
# 在 Obsidian 中，转到“设置”>“选项”>“外观”>“主题”>“管理”，搜索 Adwaita 并安装
# （可选）安装 Obsidian Style Settings Plugin 进行自定义。在 设置 > 社区插件 下进行调整 > 样式设置 > Adwaita

# 推荐安装支持 GTK4 + Libadwaita 的 GTK 主题 https://drasite.com/
# Flat Remix GTK	https://www.gnome-look.org/p/1214931
# 或者是基于 Gnome 官方主题 adwaita 和 adw-gtk3-theme 而开发的主题
sudo dnf install flat-remix-gtk4-theme
# GNOME-4X themes	https://www.gnome-look.org/p/2173282
git clone https://github.com/daniruiz/GNOME-4X-themes.git
./install.sh
./uninstall.sh


# Gnome 官方主题
sudo dnf install -y \
adwaita-fonts-all \
adwaita-cursor-theme \
adwaita-icon-theme \

qadwaitadecorations-qt5


# https://github.com/lassekongo83/adw-gtk3
dnf install adw-gtk3-theme
sudo flatpak override --filesystem=xdg-data/themes
sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3 && sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3-dark
```

### **方法 2：手动安装第三方主题**
1. 下载主题（如从 [GNOME Look](https://www.gnome-look.org/)）  
2. 解压到 `~/.themes`（GTK 主题）或 `~/.local/share/themes`（系统级主题）  
   ```bash
   # Flat Remix GTK 主题适配了 LibAdwaita
   sudo dnf install -y flat-remix-gtk4-theme
   https://www.gnome-look.org/p/1214931
   https://github.com/daniruiz/Flat-Remix-GTK
   flatpak override --user --filesystem=xdg-config/gtk-4.0 --filesystem=~/.themes/
   gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue"
   
   # 主题美化，参考 https://www.gnome-look.org/browse?ord=rating
   git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
   sed -i 's/\$opacity: if([^;]*);/\$opacity: 1;/g' ~/下载/WhiteSur-gtk-theme/src/sass/_colors.scss
   ./install.sh       # 同时安装Dark/Light两种主题
   ./tweaks.sh -f flat
   sudo ./tweaks.sh -g
   sudo ./tweaks.sh -g -b "my picture.jpg"
   # 授予全局访问 GTK 配置和主题文件的权限
   # 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-3.0 目录。该目录包含 GTK 3 的配置文件（如主题、图标、字体设置等）。
   sudo flatpak override --filesystem=xdg-config/gtk-3.0
   # 允许所有 Flatpak 应用访问宿主机的 ~/.config/gtk-4.0 目录。
   sudo flatpak override --filesystem=xdg-config/gtk-4.0
   # 将 WhiteSur 主题包连接到 Flatpak 仓库
   ./tweaks.sh -F
   
   git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
   ./install.sh
   git clone https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1
   ./install.sh
   git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
   sudo ./install-gnome-backgrounds.sh
   
   
   # MacOS-3D 系列主题基于Gnome官方默认主题 adw-gtk3 构建，完美适配 Gnome 所有应用
   # 不存在像 WhiteSur-gtk-theme 一样对基于 libadwaita 构建的应用无法切换主题的问题
   # MacOS 3D 作者 https://m.youtube.com/watch?v=2-uPje43Zg8&pp=ygUJZmVkb3JhIDQy
   使用 Evolve-core 应用程序应用主题：https://github.com/arcnations-united/evolve-core
   GTK Theme: https://www.pling.com/p/2278127/
   ICONS Theme: https://www.pling.com/p/2023325/
   SHELL Theme: https://www.pling.com/p/2278187/
   https://github.com/Macintosh98/MacOS-3D-Cursor
   git clone https://github.com/Macintosh98/MacOS-3D-Cursor.git
   # 图标放在 					~/.icons/
   # Shell 和 GTK主题放在		~/.themes/
   
   /usr/share/themes/
   /usr/local/share/themes/  # 本地安装的第三方主题
   ~/.themes/  # 传统路径（部分旧版GNOME使用）
   ~/.local/share/themes/  # 新版GNOME推荐路径
   
   # Shell 主题更改 GNOME 顶部栏和活动概述的视觉主题（需启用 `User Themes` 扩展）。
   # GTK 主题为 GTK2/GTK3/GTK4 应用（如 GIMP、Thunderbird）指定主题。应用程序内部界面
   # wm.preferences theme 主题用于设置窗口管理器（Window Manager）的主题，它控制的是 窗口边框、标题栏、最小化/最大化/关闭按钮等非客户区（non-client area）的视觉样式。
   
   fastfetch | grep "WM Theme:"	# 这里的值应该对应 Shell 主题
   # fastfetch 中的 WM Theme: 的值对应的是 gnome-tweaks 中的 Shell 主题，也就是 user-theme
   # 而 fastfetch 中 Theme: 的值对应的是 gnome-tweaks 中的 过时应用程序 主题，也就是 gtk-theme
   
   gsettings set org.gnome.desktop.interface color-scheme 'default'
   gsettings set org.gnome.desktop.interface cursor-theme 'MacOS-3D-Cursor-Light'
   gsettings set org.gnome.desktop.interface icon-theme 'MacOS-3D'
   gsettings set org.gnome.shell.extensions.user-theme name 'MacOS-3D-Shell'
   gsettings set org.gnome.desktop.interface gtk-theme 'MacOS-3D-Gtk'
   gsettings set org.gnome.desktop.wm.preferences theme 'MacOS-3D-Gtk'
   # wm.preferences theme 窗口装饰主题（标题栏、边框、按钮）通常与 GTK 主题捆绑。若 MacOS-3D-Gtk-Dark 主题包已包含对应的窗口装饰，直接使用同一名称即可保持风格一致。
   
   gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
   gsettings set org.gnome.desktop.interface cursor-theme 'MacOS-3D-Cursor-Dark'
   gsettings set org.gnome.desktop.interface icon-theme 'MacOS-3D'
   gsettings set org.gnome.shell.extensions.user-theme name 'MacOS-3D-Shell'
   gsettings set org.gnome.desktop.interface gtk-theme 'MacOS-3D-Gtk-Dark'
   gsettings set org.gnome.desktop.wm.preferences theme 'MacOS-3D-Gtk-Dark'
   
    # la-capitaine 这两个注意已经在 fedora 仓库中可以搜索到，无需启用三方仓库
   sudo dnf install -y la-capitaine-cursor-theme adw-gtk3-theme
   # 由于 MacOS-3D 的 Shell 主题没有提供暗色主题，所以在切换主题时 Shell 主题无法切换
   # 可以使用 WhiteSur 的 Shell 和 wm 主题来弥补这一点。可以解决 WhiteSur 的痛点。
   # 可以比较实现完美的实现全局所有应用的主题切换，包括 libadwaita 系列应用。
   # 但还是有些应用无法解决主题自动切换的问题，例如：IDEA、ApiPost、QQ、WeChat等等
   # 总结：只需替换 WhiteSur 系列中的 GTK 主题为基于 Gnome 官方 adw-gtk3 主题开发的 GTK 主题
   gsettings set org.gnome.desktop.interface color-scheme 'default'
   gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'
   gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-light'
   gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'
   gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
   gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Light'
   
   gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
   gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors-light'
   gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
   gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark'
   gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
   gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark'


	# 恢复默认主题设置
   gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
   gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
   gsettings set org.gnome.shell.extensions.user-theme name 'Adwaita'
   gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
   gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
   # WhiteSur-cursors 在 libadwaita 系列应用中存在 BUG 不推荐使用，可以在如下网站选择一个评分高的
   # https://www.gnome-look.org/browse?cat=107&ord=rating
   

   # Capitaine Cursors
   https://www.gnome-look.org/p/1148692
   git clone https://github.com/keeferrourke/capitaine-cursors.git
   # McMojave cursors 基于 Capitaine Cursors 构建
   https://www.gnome-look.org/p/1355701
   # 光标主题建议白天使用黑色，晚上使用白色
   
   
   
   gsettings reset org.gnome.desktop.wm.preferences theme
   # 默认是 Adwaita
   gsettings get org.gnome.desktop.wm.preferences theme
   
   
   sudo flatpak override --filesystem=~/.themes
   sudo flatpak override --filesystem=~/.icons
   sudo flatpak override --filesystem=~/.local/share/icons
   ls ~/.themes
   ls ~/.icons
   ls ~/.local/share/icons
   # sudo flatpak override --env=GTK_THEME=WhiteSur-Dark
   # sudo flatpak override --env=ICON_THEME=WhiteSur-Dark
   # 列出所有应用，获取 <应用ID>
   flatpak list --app
   # 对于单个应用程序
   sudo flatpak override org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
   sudo flatpak override org.fedoraproject.MediaWriter --env=ICON_THEME=WhiteSur-dark
   # 若需更深度适配（如 Kvantum）
   flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
   # 允许读写取系统主题，默认权限为 读写（Read-Write），应用可以读取和修改目录中的文件。
   # ro 表示 只读（Read-Only）。它的作用是限制 Flatpak 应用对指定目录的访问权限，仅允许 读取 文件，而 禁止写入或修改。
   flatpak override --user --filesystem=~/.themes:ro  # 若使用用户级主题
   # 指定主题名称（如 WhiteSur-Light）
   flatpak override --user --env=GTK_THEME=WhiteSur-Light
   # 例如强制 Media Writer 使用 GTK 主题
   flatpak override --user org.fedoraproject.MediaWriter --env=QT_STYLE_OVERRIDE=kvantum
   
   flatpak override --user org.fedoraproject.MediaWriter --env=ICON_THEME=WhiteSur-dark
   flatpak override --user org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
   flatpak override --user org.fedoraproject.MediaWriter --env=GTK_THEME=WhiteSur-Dark
   
   flatpak override --user cn.apipost.apipost --env=ICON_THEME=WhiteSur-dark
   flatpak override --user cn.apipost.apipost --env=GTK_THEME=WhiteSur-Dark
   
   flatpak run --env=GTK_THEME=WhiteSur-Light org.fedoraproject.MediaWriter
   flatpak run org.fedoraproject.MediaWriter
   # Breeze, Windows, Fusion
   flatpak run --env=QT_STYLE_OVERRIDE=Breeze org.fedoraproject.MediaWriter
   
   flatpak run --env=GTK_THEME=WhiteSur-Dark cn.apipost.apipost
   flatpak run cn.apipost.apipost
   
   flatpak run --env=QT_STYLE_OVERRIDE=gtk3 com.obsproject.Studio
   # 安装主机依赖
   locate libcanberra-gtk-module
   sudo dnf install libcanberra-gtk3 PackageKit-gtk3-module
   sudo dnf -y install libcanberra-gtk3
   
   flatpak run --command=gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark' org.fedoraproject.MediaWriter
   # 列出所有已安装的 Flatpak 应用和运行时
   flatpak list
   # 查看应用使用的运行时等信息
   flatpak list --app
   # 查看所有应用的全局覆盖配置
   flatpak override --show
   flatpak override org.fedoraproject.MediaWriter --show
   sudo flatpak override --reset
   sudo flatpak override org.fedoraproject.MediaWriter --reset
   flatpak run --env=GTK_DEBUG=all <应用ID>
   flatpak run --env=GTK_DEBUG=all org.fedoraproject.MediaWriter
   
   flatpak info org.fedoraproject.MediaWriter
   flatpak info com.obsproject.Studio
   flatpak info org.videolan.VLC
   flatpak info cn.apipost.apipost
   flatpak search org.gtk.Gtk3theme
   flatpak search QAdwaitaDecorations
   dnf search QAdwaitaDecorations
   dnf search Decorations
   sudo dnf install -y qadwaitadecorations-qt5 qadwaitadecorations-qt6
   
   # 在 Linux 中的 Flatpak 应用程序上应用 GTK 系统主题，参考 https://cn.linux-console.net/?p=18267
   # 安装 Kvantum 软件
   sudo dnf install -y qt5ct qt6ct kvantum
   flatpak install -y org.kde.KStyle.Kvantum
   # 参考 https://wiki.archlinuxcn.org/wiki/%E7%BB%9F%E4%B8%80_Qt_%E5%92%8C_GTK_%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E7%9A%84%E5%A4%96%E8%A7%82
   flatpak install flathub org.kde.KStyle.Adwaita
   kvantummanager  # 在 "Change/Delete Theme" 中微调 WhiteSur 参数
   sudo flatpak override --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro org.fedoraproject.MediaWriter
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
  
  sudo flatpak override --filesystem=xdg-config/gtk-3.0
  sudo flatpak override --filesystem=xdg-config/gtk-4.0
  
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
  sudo dnf install -y \
  adw-gtk3-theme \
  adwaita-cursor-theme \
  adwaita-icon-theme \
  adwaita-fonts-all \
  adwaita-qt5 \
  adwaita-qt6 \
  qadwaitadecorations-qt5 \
  qadwaitadecorations-qt6
  
  flatpak install -y \
  org.kde.WaylandDecoration.QAdwaitaDecorations \
  org.kde.KStyle.Adwaita \
  org.gtk.Gtk3theme.Adwaita-dark
  
  sudo dnf install -y libadwaita-demo
  
  gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
  gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
  # 更改 GNOME Shell 顶部栏和活动概述的视觉主题（需启用 `User Themes` 扩展）。
  gsettings set org.gnome.shell.extensions.user-theme name 'Adwaita'
  # 设置旧版应用主题（例如改为 "Adwaita-dark"）应用程序内部界面（由 GTK 主题控制，
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
  # 设置窗口管理器（Window Manager）的主题，它控制的是窗口边框、标题栏、最小化/最大化/关闭按钮等非客户区（non-client area）的视觉样式。
  gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
  
  
  gsettings set org.gnome.desktop.interface gtk-theme 'Adw-gtk3'
  gsettings set org.gnome.desktop.interface gtk-theme 'Adw-gtk3-dark'
  
  
  
  yaru-gtk3-theme.noarch
  yaru-gtk4-theme.noarch
  yaru-icon-theme.noarch
  yaru-sound-theme.noarch
  yaru-gtksourceview-theme.noarch
  gnome-shell-theme-yaru.noarch
  
  flat-remix-icon-theme.noarch
  flat-remix-theme.noarch
  flat-remix-gtk4-theme.noarch
  flat-remix-gtk3-theme.noarch
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
  # 子像素渲染
  gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
  # 轻微字型优化
  gsettings set org.gnome.desktop.interface font-hinting 'slight'
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
https://itsfoss.com/flatpak-app-apply-theme/
参考 https://docs.flatpak.org/zh-cn/latest/desktop-integration.html

# 官网 https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations
# 需要自行安装 QWhiteSurGtkDecorations
# export QT_WAYLAND_DECORATION=whitesur-gtk

export QT_QPA_PLATFORM=wayland
# sudo dnf install -y qadwaitadecorations-qt5 qadwaitadecorations-qt6
export QT_WAYLAND_DECORATION=adwaita
export QT_STYLE_OVERRIDE=kvantum
source ~/.bashrc
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


`
gsettings list-schemas | grep "keybindings"
# 窗口快捷键
org.gnome.desktop.wm.keybindings
# 窗口快捷键
org.gnome.mutter.keybindings
org.gnome.mutter.wayland.keybindings
# 扩展提供的快捷键
org.gnome.shell.extensions.paperwm.keybindings
org.gnome.shell.keybindings

gsettings list-recursively org.gnome.settings-daemon.plugins.media-keys
# 自定义媒体快捷键
gsettings set org.gnome.settings-daemon.plugins.media-keys media ['<Super>F9']
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute ['F2']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down ['F3']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up ['F4']
gsettings set org.gnome.settings-daemon.plugins.media-keys next ['F8']
gsettings set org.gnome.settings-daemon.plugins.media-keys play ['F9']
gsettings set org.gnome.settings-daemon.plugins.media-keys previous ['F10']

gsettings list-recursively org.gnome.desktop.wm.keybindings
# 自定义系统快捷键
gsettings set org.gnome.desktop.wm.keybindings close ['<Super>c']
gsettings set org.gnome.desktop.wm.keybindings maximize ['<Super>Up']
gsettings set org.gnome.desktop.wm.keybindings unmaximize ['<Super>Down']
gsettings set org.gnome.desktop.wm.keybindings show-desktop ['<Super>h']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 ['<Super>1']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 ['<Super>2']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 ['<Super>3']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 ['<Super>4']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last ['<Super>End']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left ['<Super>Left']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right ['<Super>Right']
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen ['<Super>f']
`