#### 桌面环境切换（不推荐同时使用同时使用Gnome和KDE）

当然可以使用 tasksel 工具来安装和切换桌面环境。tasksel 是一个 Debian 系统中常用的工具，用于安装软件包组（tasks）。

你可以使用以下命令来列出可用的桌面环境选项：

```bash
sudo tasksel --list-tasks

# 或者先 su 进入管理员模式，然后 tasksel 进入 debian 桌面环境选择界面，我们上下选择想要安装的桌面环境，然后按 空格键 即可进行选中，然后回车就可以进行安装
```

接着，你可以选择想要安装的桌面环境，然后使用以下命令安装：

```
sudo tasksel install task-desktop
sudo tasksel install task-kde-desktop
```

在这个命令中，将 "task-desktop" 替换为你想要安装的桌面环境的名称，比如 "task-gnome-desktop" 用于 GNOME 桌面环境，或者 "task-kde-desktop" 用于 KDE 桌面环境。

最后，我们注销登录，然后在登录界面的右下角的桌面环境选择设置中选择一个自己喜欢桌面环境即可

一旦安装完成，你可以在登录时选择新的桌面环境。tasksel 可以更方便地安装和切换桌面环境，因为它会自动处理依赖关系，确保安装所选桌面环境所需的所有软件包。

### Debian多系统启动引导的优先级修改
在Debian中，多系统启动引导的优先级可以通过修改GRUB引导加载程序的配置文件来实现。GRUB是Debian默认的引导加载程序。

以下是修改Debian多系统启动引导优先级的步骤：

1. 打开终端，以管理员权限（root或使用sudo）登录系统。

2. 编辑 GRUB 配置文件 `/etc/default/grub`。你可以使用文本编辑器（如nano或vim）打开该文件。

```
sudo nano /etc/default/grub
sudo cat /etc/default/grub
sudo vim /etc/default/grub

sudo cat /boot/grub/grub.cfg

sudo update-grub && update-grub2

EasyUEFI



# WhiteSur GTK 主题
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme

# 安装默认 WhiteSur GTK 主题包
./install.sh    
# 卸载 GTK 主题
./install.sh -r
# 修复 libadwaita (不完美)
./install.sh -l -c Light 

# 优化头部 gnome-shell 
./install.sh --shell -i 'arch'

# 修复 libadwaita (不完美)
./install.sh --round --right
./install.sh -l -c Light --shell -i 'arch' --round --right

# 安装的 flat Firefox 主题
./tweaks.sh -f flat
# 卸载 Firefox 火狐主题
./tweaks.sh -f -r

# 修复了 Dash to Dock 主题问题。
./tweaks.sh -d

# 安装 GDM 主题，使用默认的背景
sudo ./tweaks.sh -g -b default         
# 安装 GDM 主题，使用自定义背景
sudo ./tweaks.sh -g -b "my picture.jpg" 
# 卸载 GDM 主题
sudo ./tweaks.sh -g -r


# WhiteSur Icon 主题
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
# 安装 Icon 主题
./install.sh
# 卸载 Icon 主题
./install.sh -r

# WhiteSur cursors 主题
git clone https://github.com/vinceliuice/WhiteSur-cursors.git -depth=1
sudo ./install.sh
yay -S WhiteSur-cursors

# WhiteSur 壁纸
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
# 安装 Gnome 背景（壁纸将随时间变化）
sudo ./install-gnome-backgrounds.sh
# 安装普通壁纸
./install-wallpapers.sh


# grub2 主题
git clone https://github.com/vinceliuice/grub2-themes.git
sudo ./install.sh -t tela -s 2k
sudo ./install.sh -t whitesur -s 2k
sudo ./install.sh -r -t tela
sudo ./install.sh -r -t whitesur

cat /etc/default/grub
grep "GRUB_THEME" /etc/default/grub


https://discovery.endeavouros.com/bluetooth/bluetooth
https://discovery.endeavouros.com/installation/live-iso-tricks-tips
```

3. 在打开的文件中，找到名为 `GRUB_DEFAULT` 的行。这是设置默认启动项的选项。默认情况下，它的值通常是 `0`，表示选择第一个启动项。

4. 根据你想要设置的启动项，将 `GRUB_DEFAULT` 的值更改为相应的数字。请注意，GRUB的启动项从0开始计数。例如，如果你想要将第三个启动项设置为默认启动项，将 `GRUB_DEFAULT` 的值更改为 `2`。

5. 保存文件并关闭文本编辑器。

6. 在终端中运行以下命令，以使配置更改生效：

```
sudo update-grub2
```

这将重新生成 GRUB 的配置文件并应用你的更改。

7. 重新启动你的系统，新的默认启动项将生效。

通过修改 `GRUB_DEFAULT` 的值，你可以更改 Debian 的多系统启动引导的默认启动项。请记住，如果你的系统中有更新的内核或其他操作系统，它们的启动顺序可能会发生变化，因此你可能需要在每次更新后检查和调整默认启动项的值。

### Linux多系统引导配置
在Debian系统中，`efibootmgr` 是一个用于管理 UEFI（统一的可扩展固件接口）引导项的命令行工具。它允许你查看、创建、修改和删除系统的引导项。

UEFI是一种固件接口标准，用于替代传统的BIOS（基本输入输出系统）。`efibootmgr` 帮助你管理UEFI固件中的引导项，这些引导项用于选择要启动的操作系统或引导管理器。

以下是使用 `efibootmgr` 的基本步骤：

1. 打开终端，在管理员权限下（root或使用sudo）登录系统。

2. 运行 `efibootmgr` 命令，可以显示当前系统中的引导项列表。

```
sudo efibootmgr
```

该命令将列出每个引导项的唯一标识符（Boot####）、引导顺序号（BootOrder）、引导项的描述信息和引导文件的路径。

3. 如果你想更改引导顺序，可以使用 `-o` 参数后跟引导项的顺序号来指定新的引导顺序。例如，以下命令将把引导顺序设置为 `0000`、`0001`、`0002`：

```
sudo efibootmgr -o 0000,0001,0002
sudo efibootmgr -o 0002,0001
sudo efibootmgr -o 0001,0002
```

请确保在逗号后面按照你希望的引导顺序列出所有引导项的顺序号。

4. 如果你想删除引导项，可以使用 `-b` 参数后跟引导项的标识符来指定要删除的引导项。例如，以下命令将删除标识符为 `Boot001` 的引导项：

```
sudo efibootmgr -b 1 -B
```

请注意，引导项的标识符是从0开始计数的。

这些只是 `efibootmgr` 的一些基本用法示例。你可以使用 `man efibootmgr` 命令查看更多详细的用法和选项。

请注意，在使用 `efibootmgr` 之前，请确保你的系统支持UEFI，并且你对引导项的修改有一定的了解，以免导致系统无法启动。



在`Terminel`中输入`efibootmgr`，回车，可以看到当前的bootcurrent，以及 BootOrder 启动顺序，各个启动项名称
BootCurrent: 0002
Timeout: 0 seconds
BootOrder: 0001,0002,2001,2002,2003
Boot0001* ubuntu
Boot0002* debian
Boot2001* EFI USB Device
Boot2002* EFI DVD/CDROM
Boot2003* EFI Network
由上可知，当前的bootcurrent标号为0002，debian，下面`*`对应于启动项的有效无效
- 修改boot 顺序  
    `efibootmgr -o X,Y` #指定标号为X的启动项顺序在Y之前
    
- 启用/禁用boot option  
    `efibootmgr -a -b X`启用标号为X的启动项  
    `efibootmgr -A -b X`禁用标号为X的启动项
