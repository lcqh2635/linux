在Manjaro中安装和切换内核通常涉及以下几个步骤：

### 安装新的内核版本

1. **打开终端**：
   在Manjaro中打开一个终端窗口。

2. **更新软件包列表**：
   使用`sudo pacman -Sy`来确保你的系统软件包列表是最新的。

3. **安装内核**：
   Manjaro默认使用的是Linux 5.x 内核的一个版本。你可以通过以下命令安装其他版本的内核（这里以安装最新稳定版的`linux515`为例）：
   ```bash
   sudo pacman -S linux515 linux515-headers
   
   # 参考 manjaro 官网教程 https://wiki.manjaro.org/index.php/Manjaro_Kernels
   
   # 添加新内核
   # mhwd-kernel 会用现有内核中使用的任何模块自动更新新安装的内核。例如，如果你要从内核 4.14 升级到 4.19，mhwd-kernel 会自动用 4.14 中的所有模块更新 4.19。
   mhwd-kernel 只能安装官方常规内核，无法安装 linux-zen
   
   # 查看当前使用的内核和内核信息
   mhwd-kernel -li		
   # 下面的命令将安装一个新的内核（6.6），而不会删除正在使用的现有内核：
   sudo mhwd-kernel -i linux66	 
   # 下面的命令将安装一个新的内核（5.10）来替换现有内核，而现有内核将被删除：
   sudo mhwd-kernel -i linux510 rmc 	
   # 无论采用哪种方式，Manjaro 都会自动为你配置新内核，以便立即使用。完成后，关闭终端并重新启动系统，更改即可生效。
   
   
   # 移除内核
   # 切勿在 Manjaro 正在使用现有内核时试图删除它。首先，你可以在终端中使用命令 mhwd-kernel -li 来确定系统上运行的内核。
   # 如果系统中存在多个内核，可以使用 pacman 在终端中删除它们。要完全删除内核，可能需要总共删除三个内核元素：
       The kernel itself
       The kernel's headers
       The kernel's extra modules
   # 是否必须删除头文件和额外模块取决于它们是否已安装。 
   # 以下是删除内核 5.0.17-1 的示例
   sudo mhwd-kernel -r linux[version] 
   sudo mhwd-kernel -r linux50
   # 删除内核头的语法是
   sudo pacman -R linux[version]-headers
   sudo pacman -R linux50-headers
   # 删除内核额外模块的语法是
   sudo pacman -R linux[version]-extramodules
   sudo pacman -R linux50-extramodules
   # 要同时删除内核中的所有元素（如果它们都存在于系统中），语法是
   sudo pacman -R linux[version] linux[version]-headers linux[version]-extramodules
   sudo pacman -R linux50 linux50-headers linux50-extramodules
   # 在 BIOS 中选择已经安装的 Linux 内核
   启动时，系统上安装的所有可用内核都会显示出来。GNU GRUB 会显示几个选项。使用键盘上的方向键 ↑ ↓ 选择 “Manjaro Linux 高级选项”，然后 ↵ Enter。
   如果您隐藏了 grub 菜单，只需在启动时按 Esc 键即可显示并进行更改
   ```
   替换`linux515`为所需的内核版本。
   
4. **创建GRUB配置文件**：
   安装完新内核后，你需要更新GRUB引导加载器来包含新内核的条目。可以使用以下命令：
   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

### 切换内核

1. **重启计算机**：
   重启你的电脑。

2. **选择内核版本**：
   在启动过程中，进入GRUB菜单（通常在启动时按`Shift`键可以进入）。你会看到不同的内核版本作为启动选项。选择你刚刚安装的那个内核版本。

3. **启动选定的内核**：
   选择并启动你想要使用的内核版本。

### 验证内核版本

启动完成后，可以通过运行`uname -r`命令来验证当前正在运行的内核版本。

```bash
# 参考博客 https://orangelop.github.io/2023/01/27/%E5%9C%A8Arch-Linux%E4%B8%8B%E4%BD%BF%E7%94%A8Waydroid%E8%BF%90%E8%A1%8CAndroid-Apps/
```
替换`<version>`为实际的内核版本号。请注意，通常建议保留至少两个内核版本，以防最新的内核出现问题。

以上就是在Manjaro中安装和切换内核的基本步骤。如果你遇到任何具体的问题或者需要更详细的指导，请提供更多的信息。