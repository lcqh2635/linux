在 Fedora 41（GNOME 桌面）中，GNOME 扩展可以极大增强桌面功能。以下是 **常用扩展推荐**、**作用说明** 及对应的 **`gsettings` 配置命令**，涵盖生产力、美观和功能增强。

如果想在 **Fedora 41（GNOME）** 上实现 **macOS 风格** 的桌面，可以通过以下 **扩展 + 主题 + 配置** 组合来实现，包括 **Dock 栏、全局菜单、Launchpad 启动器、窗口动画** 等 macOS 特色功能。  

---

## **1. 必备扩展安装工具**
### **安装 GNOME 扩展管理器**
```bash
sudo dnf install gnome-extensions-app
```
或通过浏览器安装扩展：
1. 安装浏览器插件 [GNOME Shell Integration](https://extensions.gnome.org/)
2. 访问 [GNOME Extensions 官网](https://extensions.gnome.org/) 直接安装。

---

## **2. 常用扩展推荐及配置**
### **① Dash to Dock（macOS 式 Dock 栏）**

**作用**：将 GNOME 默认的 Dash 改为类似 macOS 的 Dock，支持自动隐藏、图标放大、任务指示器等。  
**安装**：

```bash
sudo dnf install gnome-shell-extension-dash-to-dock
```
**`gsettings` 配置示例**：（调整成 macOS 风格）：

```bash
# 设置 Dock 位置（'BOTTOM' 或 'LEFT'）
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'

# 启用自动隐藏（类似 macOS）
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

# 图标大小和放大效果
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true

# 任务指示器（当前应用高亮）
gsettings set org.gnome.shell.extensions.dash-to-dock show-running true
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top false
```

---

### **② ArcMenu**  
**作用**：替换 GNOME 默认应用菜单为现代化布局（类似 Windows 开始菜单或 macOS Launchpad）。  
**安装**：

```bash
sudo dnf install gnome-shell-extension-arcmenu
```
**`gsettings` 配置示例**：

```bash
# 设置菜单样式（'Windows'、'Mac'、'Ubuntu' 等）
gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Mac'

# 设置 Launchpad 图标（使用 macOS 风格图标）
gsettings set org.gnome.shell.extensions.arcmenu menu-button-icon 'MacOS'

# 禁用搜索栏动画（更流畅）
gsettings set org.gnome.shell.extensions.arcmenu enable-animations false
```

---

### ③ Blur My Shell（毛玻璃效果）
**作用**：为 GNOME Shell 添加 macOS 风格的毛玻璃模糊效果（顶栏、Dock、概述、侧边栏等）。 

**安装**：

```bash
sudo dnf install gnome-shell-extension-blur-my-shell
```
**`gsettings` 配置示例**：
```bash
# 启用顶栏模糊
gsettings set org.gnome.shell.extensions.blur-my-shell blur-panel true

# 设置模糊强度（1-10）
gsettings set org.gnome.shell.extensions.blur-my-shell sigma 10

# 禁用 Dash 背景模糊（避免性能问题）
gsettings set org.gnome.shell.extensions.blur-my-shell blur-dash false
```

---

### **④ Just Perfection**  
**作用**：微调 GNOME Shell 的细节（隐藏冗余元素、调整动画速度等）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-just-perfection
```
**`gsettings` 配置示例**：
```bash
# 隐藏活动按钮（左上角）
gsettings set org.gnome.shell.extensions.just-perfection hide-activities-button true

# 禁用工作区切换动画
gsettings set org.gnome.shell.extensions.just-perfection workspace-switcher-should-show false

# 加快窗口动画（类似 macOS）
gsettings set org.gnome.shell.extensions.just-perfection animation-speed 0.7
```

---

### **⑤ Clipboard Indicator**  
**作用**：记录剪贴板历史，支持快捷键粘贴。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-clipboard-indicator
```
**`gsettings` 配置示例**：
```bash
# 设置历史记录数量（默认20）
gsettings set org.gnome.shell.extensions.clipboard-indicator history-size 50

# 禁用预览弹出窗口
gsettings set org.gnome.shell.extensions.clipboard-indicator show-preview false
```

---

### **⑥ GSConnect**  
**作用**：实现与 Android 设备的无缝连接（文件传输、通知同步等）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-gsconnect
```
**`gsettings` 配置示例**：
```bash
# 启用自动连接
gsettings set org.gnome.shell.extensions.gsconnect auto-connect true

# 限制文件传输大小（单位MB）
gsettings set org.gnome.shell.extensions.gsconnect share-max-size 100
```

---

### **⑦ OpenWeather**  
**作用**：在顶栏显示实时天气信息。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-openweather
```
**`gsettings` 配置示例**：
```bash
# 设置城市（例如 "Beijing"）
gsettings set org.gnome.shell.extensions.openweather city 'Beijing'

# 温度单位（'celsius' 或 'fahrenheit'）
gsettings set org.gnome.shell.extensions.openweather unit 'celsius'

# 禁用详细预报弹窗
gsettings set org.gnome.shell.extensions.openweather show-comment-in-panel false
```

### **⑧ Caffeine**  

**作用**：临时禁用屏幕休眠和锁屏（适合演示或观影时使用）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-caffeine
```
**`gsettings` 配置示例**：
```bash
# 默认启用（启动即禁用休眠）
gsettings set org.gnome.shell.extensions.caffeine enable-fullscreen true

# 设置超时时间（秒）
gsettings set org.gnome.shell.extensions.caffeine user-enabled false
```

### **① 全局菜单（Top Bar 显示应用菜单）**

```bash
sudo dnf install gnome-shell-extension-appindicator
gsettings set org.gnome.shell.extensions.appindicator show-menus true
```

### **③ 触控板手势（类似 macOS）**

```bash
# 安装触摸板手势扩展
sudo dnf install gnome-shell-extension-gesture-improved

# 设置三指拖拽（类似 macOS）
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

---

## 





以下是 **下载量高、用户好评度极高** 的 GNOME 扩展列表（数据来自 [GNOME Extensions 官网](https://extensions.gnome.org/) 的评分和下载量统计），这些扩展经过大量用户验证，兼具实用性和稳定性：

---

### **🌟 顶级热门扩展推荐**
#### **1. User Themes**  
**评分**: ★★★★★ (几乎所有用户必备)  
**作用**: 允许使用自定义 Shell 主题（必备基础扩展）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-user-theme
```
**配置**:
```bash
gsettings set org.gnome.shell.extensions.user-theme name "Your-Theme-Name"
```

---

#### **2. Dash to Dock**  
**评分**: ★★★★★ (超 100 万用户)  
**作用**: 将 GNOME 默认 Dash 转换为可定制的 Dock 栏（支持 macOS 风格自动隐藏）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-dash-to-dock
```
**配置命令**（macOS 风格）:
```bash
# 恢复默认设置
gsettings reset-recursively org.gnome.shell.extensions.dash-to-dock

# 列出所有已安装的 Schema
gsettings list-schemas
# 列出某个 Schema 下的所有键
gsettings list-keys org.gnome.shell.extensions.dash-to-dock
# 递归列出某个 Schema 的键值（例如 org.gnome.shell.extensions.dash-to-dock）
gsettings list-recursively org.gnome.shell.extensions.dash-to-dock

# MacOS-like 配置，其他使用默认即可
# 动画速度 (0.2=流畅不拖沓)
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.4
# 点击动作 (0: 最小化, 1: 聚焦, 2: 启动新实例)
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
# 滚动动作 (0: 无, 1: 切换应用窗口)
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
# 收缩 Dash 紧凑模式
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
# 正在运行的应用的视觉指示器样式，使用短横线
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DASHES'
# 让运行指示器 使用应用图标的主色调（而非默认主题颜色）
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
```

---

#### **3. GSConnect**  
**评分**: ★★★★★ (KDE Connect 的 GNOME 版)  
**作用**: 手机与电脑无缝连接（文件传输、剪贴板同步、通知转发）。  
**安装**:

```bash
sudo dnf install gnome-shell-extension-gsconnect
```
**无需配置**，安装后与手机端 KDE Connect 配对即可。

---

#### **4. Clipboard Indicator**  
**评分**: ★★★★★ (50 万+ 用户)  
**作用**: 记录剪贴板历史，支持快捷键粘贴。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-clipboard-indicator
```
**优化配置**:
```bash
gsettings set org.gnome.shell.extensions.clipboard-indicator history-size 50
gsettings set org.gnome.shell.extensions.clipboard-indicator toggle-menu '<Primary><Alt>v'
```

---

#### **5. Blur My Shell**  
**评分**: ★★★★★ (视觉美化首选)  
**作用**: 为顶栏、概览等添加毛玻璃模糊效果。  
**安装**:

```bash
sudo dnf install gnome-shell-extension-blur-my-shell
```
**配置命令**:
```bash
gsettings set org.gnome.shell.extensions.blur-my-shell sigma 10  # 模糊强度
gsettings set org.gnome.shell.extensions.blur-my-shell blur-panel true  # 模糊顶栏
```

---

#### **6. AppIndicator and KStatusNotifierItem Support**  
**评分**: ★★★★☆ (解决托盘图标缺失问题)  
**作用**: 显示传统托盘图标（如 Discord、Steam、微信）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-appindicator
```
**启用所有图标**:
```bash
gsettings set org.gnome.shell.extensions.appindicator show-menus true
```

---

#### **7. OpenWeather**  
**评分**: ★★★★☆ (天气扩展榜首)  
**作用**: 在顶栏显示实时天气和预报。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-openweather
```
**配置命令**:
```bash
gsettings set org.gnome.shell.extensions.openweather city 'Beijing'
gsettings set org.gnome.shell.extensions.openweather unit 'celsius'
```

---

#### **8. Caffeine**  
**评分**: ★★★★☆ (防止休眠神器)  
**作用**: 临时禁用屏幕休眠和锁屏（适合演示/观影）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-caffeine
```
**快捷键**: 点击顶栏咖啡图标或 `Super+Esc` 切换状态。

---

#### **9. Just Perfection**  
**评分**: ★★★★★ (极简主义必备)  
**作用**: 微调 GNOME Shell 的每个细节（隐藏冗余元素、调整动画速度）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-just-perfection
```
**常用配置**:
```bash
gsettings set org.gnome.shell.extensions.just-perfection hide-activities-button true  # 隐藏活动按钮
gsettings set org.gnome.shell.extensions.just-perfection animation-speed 0.7  # 加快动画
```

---

#### **10. Vitals**  
**评分**: ★★★★☆ (硬件监控最佳)  
**作用**: 在顶栏显示 CPU/内存/温度/网络等实时数据。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-vitals
```
**配置命令**:
```bash
gsettings set org.gnome.shell.extensions.vitals monitors "['cpu', 'memory', 'temperature']"
```

---

### **📊 用户评价最高的功能扩展**
| **扩展名称**            | **核心功能**      | **安装量** | **评分** |
| ----------------------- | ----------------- | ---------- | -------- |
| **Dash to Dock**        | macOS 式 Dock 栏  | 100 万+    | ★★★★★    |
| **GSConnect**           | 手机与电脑互联    | 80 万+     | ★★★★★    |
| **Blur My Shell**       | 毛玻璃特效        | 60 万+     | ★★★★★    |
| **Clipboard Indicator** | 剪贴板历史        | 50 万+     | ★★★★★    |
| **User Themes**         | 自定义 Shell 主题 | 必备       | ★★★★★    |

---

### **💡 使用建议**
1. **按需安装**：避免同时启用过多扩展（可能影响性能）。
2. **定期更新**：
   ```bash
   sudo dnf upgrade --refresh
   ```
3. **冲突排查**：若遇到问题，通过 `gnome-extensions list` 检查冲突扩展。

这些扩展经过全球用户验证，能显著提升 GNOME 桌面的功能和美观度！ 🚀







以下是更多 **高人气、高评分** 的 GNOME 扩展，这些扩展在功能和用户体验上都经过广泛验证，适合不同场景需求：

---

### **🔧 系统增强类**
#### 1. **Tray Icons: Reloaded**  
**评分**: ★★★★★ (解决 GNOME 40+ 托盘图标兼容性问题)  
**作用**: 完美支持传统应用托盘图标（如 QQ、Steam、WPS）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-tray-icons-reloaded
```
**配置**：安装后自动生效，无需额外设置。

---

#### 2. **Quick Settings Tweaker**  
**评分**: ★★★★☆ (20万+ 用户)  
**作用**: 自定义顶部面板的快捷设置菜单（隐藏无用按钮、添加夜间模式开关等）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-quick-settings-tweaker
```
**实用配置**：
```bash
# 添加电池百分比显示
gsettings set org.gnome.shell.extensions.quick-settings-tweaker battery-show-percentage true
```

---

#### 3. **Grand Theft Focus**  
**评分**: ★★★★☆ (游戏玩家必备)  
**作用**: 强制锁定焦点到当前窗口，防止弹窗打断全屏游戏/演示。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-grand-theft-focus
```
**快捷键**: `Super` + `F` 一键锁定。

---

### **🎨 视觉美化类**
#### 4. **Rounded Window Corners**  
**评分**: ★★★★★ (50万+ 用户)  
**作用**: 为所有窗口添加圆角效果（类似 macOS）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-rounded-window-corners
```
**配置**：
```bash
gsettings set org.gnome.shell.extensions.rounded-window-corners border-radius 12  # 圆角大小
```

---

#### 5. **Aylur's Widgets**  
**评分**: ★★★★☆ (极简风格小组件)  
**作用**: 在顶栏添加时间、天气、系统监控等精美组件。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-aylurs-widgets
```
**效果预览**：  
![Aylur's Widgets](https://example.com/aylurs-widgets-preview.png)

---

#### 6. **Burn My Windows**  
**评分**: ★★★★☆ (炫酷动画)  
**作用**: 为窗口添加打开/关闭特效（火焰、像素化、矩阵等）。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-burn-my-windows
```
**特效切换**：
```bash
gsettings set org.gnome.shell.extensions.burn-my-windows animation-type 'fire'
```

---

### **⚡ 效率工具类**
#### 7. **Forge**  
**评分**: ★★★★★ (进阶窗口管理)  
**作用**: 比 Tiling Assistant 更强大的分屏工具，支持自定义布局和快捷键。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-forge
```
**分屏快捷键**：  
- `Super` + `方向键` 快速分屏  
- `Super` + `G` 创建窗口组  

---

#### 8. **Fly-Pie**  
**评分**: ★★★★☆ (创意菜单交互)  
**作用**: 通过手势呼出圆形菜单，快速启动应用或执行命令。  
**安装**:
```bash
sudo dnf install gnome-shell-extension-flypie
```
**触发方式**: 长按 `Super` + 鼠标划动。

---

#### 9. **Espresso**  
**评分**: ★★★★☆ (续航优化)  
**作用**: 根据应用自动禁用休眠（如全屏看视频时保持常亮）。  
**安装**:
```bash
Add to Desktop
Alphabetical App Grid
Bluetooth Quick Connect
Clipboard Indicator
Coverflow Alt-Tab
Compiz windows effect
Compiz alike magic lamp effect
Desktop Cube
Dynamic Panel
Dash2Dock Animated
Extension List
Gtk4 Desktop Icons NG (DING)
# 安装 Lunar Calendar 农历 扩展插件需要如下内容
#https://gitlab.gnome.org/Nei/ChineseCalendar/-/archive/20250205/ChineseCalendar-20250205.tar.gz
# tar -xzvf ChineseCalendar-20250205.tar.gz
# cd ChineseCalendar-20250205
# ./install.sh
Lunar Calendar 农历
Logo Menu
Hide Top Bar
# 修复 Hide Top Bar 闪跳 BUG
Disable unredirect fullscreen windows
IBus Tweaker
Night Theme Switcher
Notification Banner Reloaded
Quick Settings Tweaks
Rounded Corners
Rounded Window Corners Reborn
Search Light
SettingsCenter
# 数值设置为 4
Status Area Horizontal Spacing
Top Bar Organizer
Tray Icons: Reloaded
User Avatar In Quick Settings
Window Gestures
VirtualBox applet
# https://github.com/Sominemo/Fildem-Gnome-45
```
**排除应用**：
```bash
gsettings set org.gnome.shell.extensions.espresso whitelist "['vlc.desktop', 'chrome.desktop']"
```

---

### **📊 用户投票TOP扩展**
| 扩展名称            | 核心功能      | 适合人群      | 安装量 |
| ------------------- | ------------- | ------------- | ------ |
| **Dash to Dock**    | macOS式任务栏 | 所有用户      | 100万+ |
| **GSConnect**       | 手机电脑互联  | 多设备用户    | 80万+  |
| **Blur My Shell**   | 毛玻璃特效    | 视觉党        | 60万+  |
| **Forge**           | 超级分屏管理  | 程序员/设计师 | 40万+  |
| **Burn My Windows** | 炫酷窗口动画  | 游戏玩家      | 30万+  |

---

### **💡 使用建议**
1. **性能优先**：低配设备建议关闭动画类扩展（如 Burn My Windows）。
2. **快捷键冲突检查**：通过 `Settings > Keyboard Shortcuts` 调整冲突快捷键。
3. **扩展管理器**：使用 `Extensions` 应用（Fedora 预装）一键开关扩展。

---

### **🚀 一键安装所有推荐扩展**
```bash
sudo dnf install \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-gsconnect \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-forge \
    gnome-shell-extension-burn-my-windows
```













Translate clipboard

Extension List

Open Bar





当然！以下是一些 **更独特、更极客向** 的 GNOME 扩展，涵盖 **隐藏功能、自动化、系统级优化**，适合追求极致个性化和效率的用户：

---

### **一、自动化 & 效率神器**
#### 2. **RunCat**  
**作用**：在顶栏显示一只奔跑的猫咪动画，CPU 占用越高跑得越快（实用又可爱）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-runcat
```
**配置命令**：
```bash
# 设置动画类型（可选 'cat'/'parrot'/'dog'）
gsettings set org.gnome.shell.extensions.runcat animation-type 'cat'

# 显示 CPU 占用率文本
gsettings set org.gnome.shell.extensions.runcat show-cpu-usage true
```

#### 3. **Grand Theft Focus**  
**作用**：强制将焦点锁定在当前窗口（防止弹窗打断全屏工作/游戏）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-grand-theft-focus
```
**快捷键**：  
- `Super`+`F` 锁定/解锁焦点（可自定义）

---

### **二、系统级黑科技**
#### 4. **Gnome 4x UI Improvements**  
**作用**：修复 GNOME 4x 系列的细节问题（如窗口按钮错位、菜单间距不合理）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-gnome-4x-ui-improvements
```
**无需配置**，自动优化界面细节。

#### 5. **TopHat**  
**作用**：在顶栏实时显示 CPU/GPU 温度、风扇转速、功耗等硬件数据（需 `lm_sensors`）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-tophat lm_sensors
```
**配置命令**：
```bash
# 显示 GPU 温度（NVIDIA 需安装 nvidia-smi）
gsettings set org.gnome.shell.extensions.tophat show-gpu true

# 警告温度阈值（摄氏度）
gsettings set org.gnome.shell.extensions.tophat warning-temperature 80
```









当然！以下是一些 **更加小众但充满惊喜** 的 GNOME 扩展，涵盖 **创意交互、系统增强、视觉黑科技**，适合追求极致个性化和高效工作流的用户：

---

### **一、创意交互 & 效率神器**
#### 2. **Coverflow Alt-Tab**  
**作用**：将传统的 Alt-Tab 窗口切换变成 **macOS 式的 3D 卡片翻转效果**。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-coverflow-alttab
```
**配置命令**：
```bash
# 设置动画速度（1-10）
gsettings set org.gnome.shell.extensions.coverflow-alttab animation-duration 3

# 启用模糊背景
gsettings set org.gnome.shell.extensions.coverflow-alttab blur-background true
```

---

### **二、系统级增强工具**
#### 5. **Night Theme Switcher**  
**作用**：根据日出日落时间 **自动切换 GTK 主题和壁纸**（比默认夜间模式更强大）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-night-theme-switcher
```
**配置命令**：
```bash
# 设置白天/黑夜主题
gsettings set org.gnome.shell.extensions.night-theme-switcher day-theme 'Adwaita'
gsettings set org.gnome.shell.extensions.night-theme-switcher night-theme 'Adwaita-dark'

# 同步壁纸切换
gsettings set org.gnome.shell.extensions.night-theme-switcher change-wallpaper true
```

#### 6. **Proxy Switcher**  
**作用**：在顶栏快速切换 **系统代理配置**（支持 Shadowsocks/V2Ray 等）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-proxy-switcher
```
**配置命令**：
```bash
# 添加自定义代理（示例：本地 SOCKS5）
gsettings set org.gnome.shell.extensions.proxy-switcher.profiles "['127.0.0.1:1080', 'socks5']"
```

---

### **三、视觉黑科技**
#### 9. **Dynamic Panel**  
**作用**：让顶栏和 Dock **随窗口内容动态调整透明度**（类似 macOS 的菜单栏）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-dynamic-panel
```
**配置命令**：
```bash
# 设置最小透明度（0-255）
gsettings set org.gnome.shell.extensions.dynamic-panel-transparency min-opacity 50

# 启用智能颜色反色（浅色背景时自动变深色）
gsettings set org.gnome.shell.extensions.dynamic-panel-transparency smart-text-color true
```



















## **3. 扩展管理命令**

### **查看已安装扩展**
```bash
gnome-extensions list

# 列出所有已安装的 Schema
gsettings list-schemas
# 列出某个 Schema 下的所有键
gsettings list-keys org.gnome.desktop.interface
# 查看键的取值类型和描述
gsettings describe org.gnome.desktop.interface font-name
# 递归列出某个 Schema 的键值（例如 org.gnome.desktop.interface）
gsettings list-recursively org.gnome.desktop.interface
```

### **启用/禁用扩展**
```bash
gnome-extensions enable extension-name@developer
gnome-extensions disable extension-name@developer
```

### **重置扩展配置**
```bash
gsettings reset-recursively org.gnome.shell.extensions.extension-name
```

---

## **4. 扩展组合推荐**
| 场景       | 推荐扩展组合                                      |
| ---------- | ------------------------------------------------- |
| **生产力** | Dash to Panel + Clipboard Indicator + GSConnect   |
| **美观**   | Blur My Shell + ArcMenu + Just Perfection         |
| **极简**   | Just Perfection + OpenWeather（隐藏所有冗余元素） |
| **娱乐**   | Caffeine + OpenWeather（禁用休眠+天气监控）       |

---

## **注意事项**
1. **兼容性**：Fedora 41 使用 GNOME 46+，确保扩展支持该版本。
2. **性能影响**：模糊特效（如 Blur My Shell）可能增加 GPU 负载，笔记本用户建议调低 `sigma` 值。
3. **备份配置**：
   ```bash
   dconf dump /org/gnome/shell/extensions/ > ~/gnome-extensions-settings.dconf
   ```

通过合理配置这些扩展，可以打造出既美观又高效的 Fedora 41 桌面环境！











#### 1. **Tiling Assistant**  
**作用**：实现类似 macOS 的窗口分屏（拖拽窗口到边缘自动分屏），支持自定义布局和快捷键。  
**安装**：

```bash
sudo dnf install gnome-shell-extension-tiling-assistant
```
**配置命令**：
```bash
# 启用边缘吸附分屏
gsettings set org.gnome.shell.extensions.tiling-assistant enable-snap-to-zone true

# 设置分屏动画（0-100，越高越慢）
gsettings set org.gnome.shell.extensions.tiling-assistant snap-animation-duration 10
```

#### 2. **Clipboard History**  
**作用**：记录剪贴板历史，支持快捷键粘贴（比默认 Clipboard Indicator 更强大）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-clipboard-history
```
**配置命令**：
```bash
# 设置历史记录数量
gsettings set org.gnome.shell.extensions.clipboard-history items-size 50

# 禁用弹出通知
gsettings set org.gnome.shell.extensions.clipboard-history show-notifications false
```

#### 3. **Quick Settings Tweaker**  
**作用**：自定义顶部面板的快捷设置菜单（如添加夜间模式、电源选项等隐藏按钮）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-quick-settings-tweaker
```
**配置命令**：
```bash
# 添加“电池百分比”显示
gsettings set org.gnome.shell.extensions.quick-settings-tweaker battery-show-percentage true

# 隐藏不常用的按钮（如蓝牙）
gsettings set org.gnome.shell.extensions.quick-settings-tweaker hide-bluetooth false
```

#### 4. **AppIndicator and KStatusNotifierItem Support**  
**作用**：让 GNOME 支持传统托盘图标（如微信、Steam 等应用的常驻图标）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-appindicator
```
**配置命令**：
```bash
# 强制显示所有托盘图标
gsettings set org.gnome.shell.extensions.appindicator show-menus true
```

#### 5. **CPU Power Manager**  
**作用**：在顶栏显示 CPU 频率和功耗模式（平衡/性能/省电），适合笔记本用户。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-cpupower
```
**配置命令**：
```bash
# 设置默认模式（'powersave'/'performance'）
gsettings set org.gnome.shell.extensions.cpupower default-mode 'powersave'
```

#### 6. **Unite**  
**作用**：合并顶栏和窗口标题栏（类似 macOS 的全局菜单，节省屏幕空间）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-unite
```
**配置命令**：
```bash
# 启用标题栏合并
gsettings set org.gnome.shell.extensions.unite hide-window-titlebars true

# 隐藏应用菜单（仅保留关闭/最小化按钮）
gsettings set org.gnome.shell.extensions.unite show-window-buttons 'never'
```

#### 7. **Rounded Window Corners**  
**作用**：为所有窗口添加圆角效果（类似 macOS 风格）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-rounded-window-corners
```
**配置命令**：
```bash
# 设置圆角半径（像素）
gsettings set org.gnome.shell.extensions.rounded-window-corners border-radius 12

# 禁用模糊背景的圆角（提升性能）
gsettings set org.gnome.shell.extensions.rounded-window-corners skip-libadwaita-apps true
```

#### 8. **Aylur's Widgets**  
**作用**：在顶栏添加天气、系统监控、日期增强等小组件（高度可定制）。  
**安装**：

```bash
sudo dnf install gnome-shell-extension-aylurs-widgets
Desktop Widgets (Desktop Clock)
```
**配置命令**：
```bash
# 启用天气组件
gsettings set org.gnome.shell.extensions.aylurs-widgets weather-enabled true

# 设置天气城市
gsettings set org.gnome.shell.extensions.aylurs-widgets weather-city 'Beijing'
```

#### 9. **Burn My Windows**  
**作用**：为窗口打开/关闭添加炫酷动画（如火焰、像素化等特效）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-burn-my-windows
```
**配置命令**：
```bash
# 设置动画类型（'fire'/'pixelate'/'matrix'）
gsettings set org.gnome.shell.extensions.burn-my-windows animation-type 'fire'

# 禁用工作区切换动画（避免冲突）
gsettings set org.gnome.shell.extensions.burn-my-windows enable-workspace false
```

---

### **四、实用工具类扩展**
#### 10. **GSConnect**（KDE Connect 的 GNOME 版）  
**作用**：通过局域网连接手机，实现文件传输、剪贴板同步、通知转发等。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-gsconnect
```
**配置命令**：
```bash
# 自动信任同一网络下的设备
gsettings set org.gnome.shell.extensions.gsconnect auto-trust true

# 限制文件传输大小（MB）
gsettings set org.gnome.shell.extensions.gsconnect share-max-size 500
```

#### 11. **Sound Input & Output Device Chooser**  
**作用**：在顶栏快速切换音频输入/输出设备（如耳机、扬声器、蓝牙设备）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-sound-output-device-chooser
```
**配置命令**：
```bash
# 显示输入设备（麦克风）
gsettings set org.gnome.shell.extensions.sound-output-device-chooser show-input-devices true
```

#### 12. **Vitals**  
**作用**：在顶栏实时显示 CPU、内存、温度、网络速度等系统监控信息。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-vitals
```
**配置命令**：
```bash
# 监控项排序（逗号分隔）
gsettings set org.gnome.shell.extensions.vitals monitors "['cpu','memory','network']"

# 隐藏电池监控（笔记本可保留）
gsettings set org.gnome.shell.extensions.vitals hide-battery false
```

### **一、极致效率工具**
#### 1. **Fly-Pie**  
**作用**：通过手势呼出圆形菜单（类似 macOS 的 [RadialMenu](https://apps.apple.com/us/app/radialmenu/id1534398431)），快速启动应用、执行命令或控制媒体。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-flypie
```
**配置命令**：
```bash
# 设置触发手势（默认按住 Super+鼠标中键）
gsettings set org.gnome.shell.extensions.flypie activation-button 'middle'

# 添加自定义命令到菜单
gsettings set org.gnome.shell.extensions.flypie custom-items "[['终端', 'gnome-terminal'], ['截图', 'flameshot gui']]"
```

#### 2. **Quick Close in Overview**  
**作用**：在 GNOME 概览界面中，鼠标悬停在窗口缩略图上时显示关闭按钮（类似 macOS 的 Mission Control）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-quick-close-in-overview
```
**无需配置**，安装后直接生效。

#### 3. **Forge**  
**作用**：进阶版窗口分屏管理，支持自定义布局、快捷键和动态工作区（比 Tiling Assistant 更强大）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-forge
```
**配置命令**：
```bash
# 设置分屏布局（例如 'tiled' 或 'stacked'）
gsettings set org.gnome.shell.extensions.forge window-layout 'tiled'

# 启用边缘拖拽分屏
gsettings set org.gnome.shell.extensions.forge enable-edge-dragging true
```

---

### **二、界面深度定制**
#### 4. **Desktop Cube**  
**作用**：将 GNOME 的工作区切换变为 3D 立方体旋转效果（复古但炫酷）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-desktop-cube
```
**配置命令**：
```bash
# 设置立方体旋转速度（1-10）
gsettings set org.gnome.shell.extensions.desktop-cube rotation-speed 3

# 启用透明立方体
gsettings set org.gnome.shell.extensions.desktop-cube transparency true
```

#### 5. **Compiz Windows Effect**  
**作用**：为窗口添加 Compiz 风格的魔幻特效（如窗口燃烧、水滴涟漪等）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-compiz-windows-effect
```
**配置命令**：
```bash
# 启用最小化动画（'genie' 效果）
gsettings set org.gnome.shell.extensions.compiz-windows-effect minimize-effect 'genie'

# 设置点击水面涟漪效果
gsettings set org.gnome.shell.extensions.compiz-windows-effect ripple-effect true
```

#### 6. **Space Bar**  
**作用**：在顶栏显示当前工作区名称和编号（适合多工作区用户）。  
**安装**：

```bash
sudo dnf install gnome-shell-extension-space-bar
```
**配置命令**：
```bash
# 显示工作区名称（而非编号）
gsettings set org.gnome.shell.extensions.space-bar show-workspace-name true

# 自定义颜色
gsettings set org.gnome.shell.extensions.space-bar active-workspace-color 'rgb(255,100,100)'
```

---

### **三、系统底层增强**
#### 7. **Systemd Manager**  
**作用**：在 GNOME 中直接图形化管理 systemd 服务（无需命令行）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-systemd-manager
```
**无需配置**，安装后在应用菜单中打开。

#### 8. **Gamemode Indicator**  
**作用**：在顶栏显示游戏模式状态（自动优化系统资源分配）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-gamemode-indicator
```
**配置命令**：
```bash
# 设置游戏模式自动启用全屏应用
gsettings set org.gnome.shell.extensions.gamemode auto-enable-fullscreen true
```

#### 9. **GPU Profile Selector**  
**作用**：快速切换 NVIDIA/AMD 显卡性能模式（适合双显卡笔记本）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-gpu-profile-selector
```
**配置命令**：
```bash
# 默认使用集成显卡（省电）
gsettings set org.gnome.shell.extensions.gpu-profile-selector default-profile 'power-saver'
```

---

### **四、交互创新**
#### 10. **Gesture Improvements**  
**作用**：增强触控板手势（支持四指滑动、自定义手势绑定）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-gesture-improvements
```
**配置命令**：
```bash
# 设置四指左滑切换到上一个工作区
gsettings set org.gnome.shell.extensions.gesture-improvements swipe-4-finger-left 'switch-to-previous-workspace'

# 禁用三指拖拽（避免冲突）
gsettings set org.gnome.shell.extensions.gesture-improvements drag-3-finger-enabled false
```

#### 11. **PaperWM**  
**作用**：将 GNOME 工作区变为横向滚动的“纸张式”布局（类似 iPad 多任务）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-paperwm
```
**配置命令**：
```bash
# 启用无限横向滚动
gsettings set org.gnome.shell.extensions.paperwm enable-infinite-scroll true

# 设置新窗口自动排列
gsettings set org.gnome.shell.extensions.paperwm auto-tile-new-windows true
```

#### 12. **No Overview at Start-Up**  
**作用**：禁用 GNOME 启动时自动显示概览界面（加速登录速度）。  
**安装**：
```bash
sudo dnf install gnome-shell-extension-no-overview-at-startup
```
**无需配置**，安装后立即生效。

---

### **五、终极组合方案**
| **用户类型**      | **推荐扩展组合**                                             |
| ----------------- | ------------------------------------------------------------ |
| **极客玩家**      | Fly-Pie + Forge + Desktop Cube + Systemd Manager             |
| **设计师/创作者** | PaperWM + Burn My Windows + Rounded Corners + Gesture Improvements |
| **游戏玩家**      | Gamemode Indicator + GPU Profile Selector + No Overview at Start-Up |
| **键盘党**        | Quick Close in Overview + Space Bar + Tiling Assistant       |

---

### **注意事项**
1. **性能影响**：3D 特效类扩展（如 Desktop Cube）会显著增加 GPU 负载，建议高性能设备使用。
2. **扩展冲突**：避免同时启用多个分屏管理扩展（如 Forge 和 Tiling Assistant）。
3. **手动安装**：若官方仓库无某些扩展，可通过 [GNOME Extensions 官网](https://extensions.gnome.org/) 手动安装（下载 `.zip` 后通过 `gnome-extensions install` 命令安装）。

这些扩展能将 GNOME 的体验提升到全新高度，适合追求个性化和效率的用户！ 🎉



### **五、扩展管理技巧**

#### 1. **查看已安装扩展**
```bash
gnome-extensions list
```

#### 2. **启用/禁用扩展**
```bash
gnome-extensions enable extension-name@developer
gnome-extensions disable extension-name@developer
```

#### 3. **备份扩展配置**
```bash
dconf dump /org/gnome/shell/extensions/ > ~/gnome-extensions-backup.dconf
```

---

### **六、扩展组合推荐**
| **需求场景**   | **推荐扩展组合**                                  |
| -------------- | ------------------------------------------------- |
| **极简办公**   | Unite + Tiling Assistant + Clipboard History      |
| **系统监控**   | Vitals + CPU Power Manager + Aylur's Widgets      |
| **媒体创作**   | Burn My Windows + Rounded Corners + Blur My Shell |
| **多设备协同** | GSConnect + AppIndicator + Sound Device Chooser   |

---

### **注意事项**
1. **兼容性**：Fedora 41 使用 GNOME 46+，确保扩展支持该版本（可通过 [GNOME Extensions 官网](https://extensions.gnome.org/) 查看）。
2. **性能影响**：动画类扩展（如 Burn My Windows）可能增加 GPU 负载，低配设备建议关闭。
3. **冲突问题**：功能相似的扩展（如 Dash to Dock 和 Unite）不要同时启用。

这些扩展能大幅提升 GNOME 桌面的功能性和美观度，根据实际需求选择搭配即可！ 🚀











---

## **2. 安装 macOS 主题**
### **① GTK 主题：WhiteSur**
```bash
# 安装 WhiteSur 主题（GTK + Shell + 图标）
sudo dnf install whitesur-gtk-theme whitesur-icon-theme
```
**应用主题**：

```bash
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-dark'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-dark'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur'
```

### **② 光标主题：McMojave**
```bash
# 安装类似 macOS 的光标
sudo dnf install mcmojave-cursor-theme
gsettings set org.gnome.desktop.interface cursor-theme 'McMojave-cursors'
```

### 
---

## **5. 一键恢复默认**
```bash
# 重置所有主题和扩展
gsettings reset-recursively org.gnome.shell.extensions.dash-to-dock
gsettings reset-recursively org.gnome.shell.extensions.arcmenu
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.interface icon-theme
```

---

