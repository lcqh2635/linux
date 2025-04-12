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

## **3. 扩展管理命令**

### **查看已安装扩展**
```bash
gnome-extensions list
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

---

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

