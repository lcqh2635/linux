在安卓设备上使用 Termux 安装 Linux 系统时，Termux 本身是一个应用环境，不是一个完整的操作系统，因此在其中安装的 Linux 系统实际上是在 Termux 应用环境中运行的一个容器。在这种情况下，为了在 Linux 系统启动时自动启动 SSH 服务，需要创建一个启动脚本，并将其放置在 Termux 的启动目录中，以确保每次 Linux 系统启动时都会运行这个脚本从而启动 SSH 服务。

直接在 Linux 系统中配置 SSH 也是可行的，但由于 Termux 中的 Linux 系统是在一个受限环境中运行的，可能无法直接修改系统启动配置或使用传统的启动管理工具。因此，最可靠的方法是创建一个 Termux 启动脚本，在其中启动 SSH 服务。

需求：将废弃的安卓手机改造成Linux便携服务器，然后通过SSH让电脑主机连接操控

BliBli教程： https://www.bilibili.com/video/BV1Sk4y147Dx/?spm_id_from=333.337.search-card.all.click&vd_source=75333bb53891f589527eedfb7b2d5911

ZeroTermux实用教程： https://www.bilibili.com/read/cv29993331/
首先，安装 Termux 或者魔改版本 ZeroTermux 终端工具，下载的地址为：
Termux： https://github.com/termux/termux-app
ZeroTermux（推荐使用）： https://github.com/hanxinhao000/ZeroTermux

安装 ZeroTermux 后，执行： apt update && apt upgrade 
ZeroTermux 一开始是不能用sudo命令的，所以需要输入pkg install tsu 安装sudo

### # 安卓手机使用Termux搭建web服务器（含frp内网穿透、wake on lan远程唤醒）
参考博客： https://blog.csdn.net/zzj19941115/article/details/121060935
ZeroTermux 安装SSH： pkg install openssh



pkg i termux-services

sv-enable ssh-agent && sv-enable sshd

修改ZeroTermux用户/SSH密码： passwd
启动SSH服务： sshd
查看本机IP	ifconfig

执行`whoami`



特别说明：推荐先如上面的两步安装并启用 ZeroTermux 的SSH服务，然后在电脑通过SSH软件来操作方便下面后续的操作！！！

Linux管理工具：                                                         pkg install proot proot-distro
查看可安装的Linux系统                                               proot-distro list
安装Ubuntu                                                                 proot-distro install ubuntu
安装完成后，进入 Linux(Ubuntu)环境的指令为          proot-distro login ubuntu
更新安装的Linux系统                                                   apt update && apt upgrade -y
安装 ssh 远程连接工具                                                 apt install vim neofetch openssh-server -y
修改 ssh 的配置，主要是端口，用于区分外部的ssh    vim /etc/ssh/sshd_config
将ssh配置中的  Port 前面的#去掉，然后22改成除了8022、22之外的任意端口 如223
再加入一行 PermitRootLogin yes

```
pkg install openssh tsu
passwd
cat /data/data/com.termux/files/usr/etc/ssh/sshd_config
sshd && ifccnfig
echo "sshd" >> ~/.bashrc
pkg upgrade

pkg install proot-distro -y
proot-distro list
proot-distro install debian
proot-distro remove debian
proot-distro login debian
apt update && apt upgrade -y

apt install git vim unzip curl wget neofetch build-essential openssh-server python3 python3-pip iproute2 locales -y
vim /etc/apt/sources.list

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware

adduser lcqh
usermod -aG sudo lcqh
su lcqh
cd /home/lcqh && mkdir 下载 && cd ~/下载
apt install openssh-server -y
# 编辑修改SSH配置
vim /etc/ssh/sshd_config

Port 2222
PermitRootLogin yes
PasswordAuthentication yes
# 修改、修改系统登录密码，也是SSH连接密码
passwd

service ssh start
service ssh status
systemctl enable ssh

# 宝塔所需python依赖包
pip3 install --upgrade pip
pip3 install psutil
pip3 install --root-user-action=ignore psutil
# 安装宝塔面板
# 使用宝塔面板安装加速包
git clone https://gitclone.com/github.com/NothingMeaning/pdusb-fast-btpanel
./pdusb-fast-btpanel/pdbolt-inst-bt-acel.sh

# 使用宝塔面板官方的一键脚本
if [ -f /usr/bin/curl ];then curl -sSO https://download.bt.cn/install/install_panel.sh;else wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh;fi;bash install_panel.sh ed8484bec

btpip install gevent psutil requests PluginLoader flask 

宝塔报错解决参考：
报错原因： 宝塔是基于python2因此，需要先安装python2并切换到python2
exit
cd ~/下载
wget https://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz
tar -zxf Python-2.7.5.tgz 
cd Python-2.7.5
./configure --prefix=/usr/local/python2.7 --with-threads --enable-shared
make && make altinstall
python2 -V
ls /usr/bin/python*

https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz

rm -rf /www
curl http://download.bt.cn/install/update_panel.sh|bash
curl -sSO https://download.bt.cn/install/install_panel.sh && bash install_panel.sh 12f2c1d72

/etc/init.d/bt start

https://blog.csdn.net/weixin_46767798/article/details/121738066
https://blog.csdn.net/m0_66678248/article/details/136462877
https://www.bt.cn/bbs/thread-115881-1-1.html


# 切换python版本
https://blog.csdn.net/My_CSDN_IT/article/details/114323834
ls /usr/bin/python*
update-alternatives --list python
update-alternatives --install /usr/bin/python python /usr/bin/python2 1
update-alternatives --install /usr/bin/python python /usr/bin/python3 2



# archlinux
proot-distro install archlinux
proot-distro login archlinux
pacman -S yay
pacman -Syyu
pacman -S vim git neofetch curl
curl -sSO http://download.bt.cn/install/install_panel.sh && bash install_panel.sh 28615082



# 不推荐，因为安装的Linux版本非常老
# 使用 ZeroTermux 自带的工具安装Linux系统，只需要点击 发行版本 
cd ~/Termux-Linux/Ubuntu && ./start-ubuntu.sh
apt update && apt upgrade -y
apt install git vim unzip curl wget neofetch build-essential -y
apt install openssh-server -y
# 编辑修改SSH配置
vim /etc/ssh/sshd_config

Port 2222
PermitRootLogin yes
PasswordAuthentication yes
# 修改、修改系统登录密码，也是SSH连接密码
passwd

service ssh start
service ssh status
wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh ed8484bec
```
重启ssh服务           service ssh start     /etc/init.d/ssh start         service ssh status
ubuntu上安装一个远程开机的包           apt install wakeonlan


**推荐将 ZeroTermux 软件设置为自启动**，步骤为：设置、应用设置、授权管理、自启动管理

### 安卓手机投屏软件安装（在自己的Linux电脑上安装scrcpy）
参考博客： https://blog.csdn.net/itcodexy/article/details/128878249
scrcpy开源Github地址： https://github.com/Genymobile/scrcpy
前置准备：**安卓手机开启所有 USB调试 功能选项**
	adb调试的开启一般是多次点击手机系统版本，如我用的是MIUI10，开启方法是 “设置”->“我的设备”->“全部参数”->点击7下MIUI版本，开启“开发者选项”。然后在 “设置”->“更多设置”->“开发者选项” 中同时开启 `USB调试` 和 `USB调试(安全设置)`。
debian / ubuntu 系统安装scrcpy投屏软件        sudo apt install scrcpy     或者   yay -S scrcpy
用USB链接电脑和安卓设备，并执行                  scrcpy

### scrcpy投屏软件常用命令
scrcpy -v


安装lLinux图形化界面
侧滑点击 MIOE全能 

### 手机 Termux 开启 SSH 连接服务
要在安卓手机上开启SSH连接服务，您可以按照以下步骤进行操作：
1. 首先，您需要在Google Play商店或其他应用商店中下载并安装Termux应用。
2. 打开Termux应用后，您将看到一个命令行界面。
3. 在命令行界面中，输入以下命令以安装openssh：

   ```
   pkg install openssh
   # 修改设置用户密码，也是ssh连接密码。注意，不是 password 而是 passwd
   passwd
   ```

4. 安装完成后，输入以下命令以启动ssh服务：

   ```
   # #### 设置用户密码，也是ssh连接密码
   输入 passwd,之后输入两次你要设置的密码即可
   
   # 然后开启ssh服务并查看当前内网地址 
   sshd
   ifconfig
   ```
   您可能会被要求生成SSH密钥对，可以选择按回车键以接受默认设置。
1. 启动成功后，您可以在命令行界面中看到SSH服务器的连接信息。例如，您将看到类似以下内容的信息：
   ```
   sshd[xxxx]: Server listening on 0.0.0.0 port 8022.
   ```
   该信息表示SSH服务器正在监听8022端口上的连接请求。
2. 现在，您可以使用其他设备上的SSH客户端应用程序，比如PuTTY、OpenSSH等，连接到您的安卓手机。在SSH客户端中，输入您的安卓手机的IP地址和8022端口号，然后按连接按钮。
   注意：您可以在Termux中使用`ifconfig`命令来获取您的安卓手机的IP地址。
3. 如果一切设置正确，您应该能够成功连接到您的安卓手机的Termux应用上。
4. 第四步：termux设置自动开启ssh    echo "sshd" >> ~/.bashrc
希望以上步骤能帮助您开启SSH连接服务。如果您在操作过程中遇到任何问题，请随时向我提问。



```
sudo iptables -A INPUT -p tcp --dport 223 -j ACCEPT
sudo iptables-save > /etc/iptables.up.rules
```


第一步 ：下载  [termux](https://f-droid.org/repo/com.termux_117.apk) 

第二步 ：安装  termux 
打开后安装  pkg install openssh
 输入   sshd   # 开启ssh 
查看手机端ip 可以使用其他方法
ifconfig # 查询本地局域网ip
手机上termux查看用户名  
whoami 
第三步：输入命令 passwd   # termux设置密码

**手机上termux开启的sshd服务用的是8022端口，而不是常用的22端口**

第四步：termux设置自动开启ssh
echo "sshd" >> ~/.bashrc