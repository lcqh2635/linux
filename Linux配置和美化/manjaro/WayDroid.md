WayDroid（前身为 Userful 和 PhoenixOS）是一个允许你在 Linux 系统上运行 Android 应用程序的工具。它通过创建一个 Android 运行环境来实现这一点，这个环境可以在 Linux 桌面上作为一个容器运行。在 Manjaro 上安装 WayDroid 的过程如下：

### 安装 WayDroid

#### 1. 安装 WayDroid
然后安装 WayDroid：
```bash
# 参考 archlinux 官网  https://wiki.archlinux.org/title/Waydroid#Installation
# 个人安装博客 https://orangelop.github.io/2023/01/27/%E5%9C%A8Arch-Linux%E4%B8%8B%E4%BD%BF%E7%94%A8Waydroid%E8%BF%90%E8%A1%8CAndroid-Apps/

# Waydroid 目前与英特尔 GPU 的配合最为默契。开箱即可使用。所有 AMD GPU 均已支持；如果 Waydroid 无法正常工作，你也可以尝试创建一个新的 Waydroid 镜像（适用于 Radeon 680M），
# Waydroid 只能在 Wayland 会话管理器中运行，因此请确保你是在 Wayland 会话中。

# 内核模块
您需要运行自带粘合剂模块的内核。它们不属于 Arch Linux 的默认内核 (linux)，因此您需要安装包含这些模块的内核。
您可能还需要配置引导加载器，以使用不同的内核。请参阅引导加载器的维基页面，了解如何使用新内核启动。启动到另一个内核（版本）是必须重启 Linux 系统的少数情况之一。在启动 Waydroid 之前，你应该先用这些模块启动内核。
要获得兼容的内核，您有多种选择：
# 使用 Linux-Zen
linux-zen 内核包含必要的模块。这可能是最方便的方法，因为你不必编译内核（这需要很长时间），而且会定期收到更新版本。

# 您需要运行自带粘合剂模块的内核。它们不是 Arch Linux 默认内核 (linux) 的一部分，因此您需要安装包含这些模块的内核。



# 实测不用切换 linux-zen 内核也可唯一使用

yay -S extra/lzip aur/python-pyclip waydroid-helper

yay -S waydroid
sudo waydroid init -f
sudo systemctl start waydroid-container
sudo waydroid container start
waydroid session start
waydroid show-full-ui

ip addr show
sudo ufw allow 53
sudo ufw allow 67
sudo ufw default allow FORWARD
sudo ufw reload
sudo ufw status


git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py





sudo venv/bin/python3 main.py install {gapps, magisk, libndk, libhoudini, nodataperm, smartdock, microg, mitm}


# waydroid
https://github.com/waydroid/waydroid
https://docs.waydro.id/
# waydroid_script
https://github.com/casualsnek/waydroid_script
# archlinux 系统安装 Waydroid 配置
https://wiki.archlinux.org/title/Waydroid

waydroid upgrade
```

#### 2. 启动 WayDroid 服务
安装完成后，启动 WayDroid 服务：
```bash
sudo systemctl enable waydroid.service
sudo systemctl start waydroid.service
```

#### 3. 初始化 WayDroid
初始化 WayDroid 并设置 Android 环境：
```bash
waydroid setup-wizard start
```

### 常用的 WayDroid 命令

一旦 WayDroid 安装完毕并设置完成，你可以使用以下命令来管理和控制 WayDroid：

- **启动 WayDroid**:
  ```bash
  waydroid session start
  ```

- **停止 WayDroid**:
  ```bash
  waydroid session stop
  ```

- **检查状态**:
  ```bash
  waydroid session status
  ```

- **列出可用的应用程序**:
  ```bash
  waydroid app list
  ```

- **启动特定的应用程序**:
  ```bash
  waydroid app start <package-name>
  ```

- **停止特定的应用程序**:
  ```bash
  waydroid app stop <package-name>
  ```

- **安装应用程序**:
  ```bash
  waydroid app install <apk-file-path>
  ```

- **卸载应用程序**:
  ```bash
  waydroid app uninstall <package-name>
  ```

- **显示帮助信息**:
  ```bash
  waydroid --help
  ```

以上是安装和管理 WayDroid 的基本步骤。请确保在安装过程中遵循官方文档以获得最佳体验，并在遇到问题时参考相关论坛或社区寻求帮助。



## 配置 waydroid 属性值

`waydroid prop set` 命令用于设置 WayDroid (Android 运行环境) 中的各种属性值。这些属性可以影响 Android 系统的行为和性能。下面是一些常见的属性及其作用：

### 常见的属性及作用

#### 1. `ro.build.fingerprint`
用于标识设备的指纹信息，包括制造商、设备型号和构建类型。例如：
```bash

sudo waydroid container start
waydroid session start

waydroid session stop
sudo waydroid container stop

# 以下 waydroid prop set 配置均来自 https://docs.waydro.id/

# 启用多窗口模式
waydroid prop set persist.waydroid.multi_windows true
# 使用鼠标模拟触屏
waydroid prop set persist.waydroid.fake_touch com.hypergryph.arknights
# 防止多窗口时出现多个鼠标指针
waydroid prop set persist.waydroid.cursor_on_subsurface true
# 将Linux的下载文件夹映射到waydroid的下载文件夹
sudo mount --bind ~/下载/waydroid ~/.local/share/waydroid/data/media/0/Download

# 安装 apk 应用
waydroid app install iBiliPlayer-bili.apk
waydroid app list
waydroid app launch com.foo.bar
```

#### 2. `ro.product.name`
设置设备的内部名称。这通常与设备的硬件配置有关。例如：
```bash
waydroid prop set ro.product.name walleye
```

#### 3. `ro.product.device`
指定设备的代号，用于识别设备。例如：
```bash
waydroid prop set ro.product.device walleye
```

#### 4. `persist.sys.usb.config`
设置 USB 配置模式。例如：
```bash
waydroid prop set persist.sys.usb.config mtp
```

#### 5. `ro.ril.telephony.mqanelements`
设置 RIL（Radio Interface Layer）相关的参数。例如：
```bash
waydroid prop set ro.ril.telephony.mqanelements 2
```

#### 6. `debug.hwui.text_size`
设置文本大小。例如：
```bash
waydroid prop set debug.hwui.text_size 1.0
```

#### 7. `persist.sys.language`
设置系统语言。例如：
```bash
waydroid prop set persist.sys.language en
```

#### 8. `persist.sys.country`
设置系统所在国家。例如：
```bash
waydroid prop set persist.sys.country US
```

#### 9. `persist.sys.timezone`
设置系统时区。例如：
```bash
waydroid prop set persist.sys.timezone America/Los_Angeles
```

#### 10. `persist.sys.locale`
设置系统区域设置。例如：
```bash
waydroid prop set persist.sys.locale en_US
```

#### 11. `wifi.supplicant_scan_interval`
设置 Wi-Fi 扫描间隔时间。例如：
```bash
waydroid prop set wifi.supplicant_scan_interval 10000
```

#### 12. `net.tethering.notify_only_wda`
设置是否只通知 WDA（Wideband AMR）tethering。例如：
```bash
waydroid prop set net.tethering.notify_only_wda true
```

#### 13. `persist.bluetooth.a2dp_offload.default`
设置蓝牙 A2DP（Advanced Audio Distribution Profile）卸载的默认行为。例如：
```bash
waydroid prop set persist.bluetooth.a2dp_offload.default true
```

### 如何使用 `waydroid prop set`

使用 `waydroid prop set` 命令时，需要知道具体的属性名和对应的值。命令的基本格式如下：
```bash
waydroid prop set <property> <value>
```

在实际使用中，可以根据需要设置不同的属性来调整 Android 环境的行为。不过需要注意的是，某些属性的更改可能会影响系统的稳定性和安全性，因此在修改之前最好了解清楚其影响范围。

### 注意事项
- 修改系统属性时要小心，错误的设置可能导致系统不稳定或无法正常工作。
- 修改某些属性可能需要重启 WayDroid 环境才能生效。
- 一些属性可能依赖于特定的 Android 版本或设备配置，因此并不是所有属性在所有情况下都适用。

如果你不确定某个属性的作用，可以先查询相关文档或在社区中询问有经验的用户。
