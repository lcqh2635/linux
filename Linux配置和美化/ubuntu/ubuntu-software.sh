#!/bin/bash

echo "==========开始安装工作和娱乐常用软件工具=========="
# ISO 镜像写入
flatpak install flathub com.system76.Popsicle

# 存在闪屏BUG，使用snap版本
# flatpak install flathub org.mozilla.firefox -y
# 可让您一键保存当前配置（主题、图标、壁纸、所有桌面环境设置、扩展等）
flatpak install flathub io.github.vikdevelop.SaveDesktop -y
# 聊天、通讯
flatpak install flathub com.qq.QQ -y
flatpak install flathub com.tencent.WeChat -y
# YesPlayMusic音乐
# flatpak install flathub io.github.qier222.YesPlayMusic -y
flatpak install flathub com.github.gmg137.netease-cloud-music-gtk -y
# 百度网盘
flatpak install flathub com.baidu.NetDisk -y
# Flatseal 是一个图形实用程序，用于查看和修改 Flatpak 应用程序的权限。
flatpak install flathub com.github.tchx84.Flatseal -y
# 邮箱
flatpak install flathub org.gnome.Evolution -y
# 以上软件是基本必装的常用软件
# Obsidian 文本编辑器
flatpak install flathub md.obsidian.Obsidian -y
# 插件  https://flhzd5t6fl.feishu.cn/wiki/PVxTwenFdiR7JZkmtXVciAH3nwb?table=tbl8RLiBsIDt4d0i&view=vew1ZbjWVQ
# 管理您的待办事项任务
flatpak install flathub io.github.mrvladus.List -y
# 办公软件
flatpak install flathub org.libreoffice.LibreOffice -y

# 使用 Flatpak 安装的软件存放在 /var/lib/flatpak/app/ 目录下
# 使用 Flatpak 安装的软件配置存放在 ~/.var/app/ 目录下

# gnome桌面火焰截图有效工作所需要的依赖
sudo apt install xdg-desktop-portal-gnome xdg-desktop-portal
# flameshot gui
# 安装邮箱、办公、火焰截图、neofetch 等
sudo apt install evolution libreoffice flameshot neofetch -y



# 下载安装非软件商城编程软件
# https://www.jetbrains.com.cn/toolbox-app/
cd $HOME/下载
echo "==========开始安装 jetbrains-toolbox 代码编辑器管理工具=========="
# -O 选项指示curl将下载的文件保存为与远程文件相同的文件名，为大写字母
# 使用`-OJ`选项参数后，`curl`会从URL中提取文件名，并将其用作保存文件的名称。
# toolbox
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.1.31116.tar.gz
# 解压缩 .tar.gz 文件
tar -xvf jetbrains-toolbox-2.3.1.31116.tar.gz
# 重命名
mv jetbrains-toolbox-2.3.1.31116 ToolBox
# 给AppImage文件授予可执行权限
chmod +x ToolBox/jetbrains-toolbox
# 将软件目录移动到 /opt 目录，需要管理员权限
sudo mv ToolBox /opt
# 安装启动 AppImage 应用所需的依赖，FUSE 库支持，必须安装
sudo apt install libfuse2 -y
# 执行 AppImage 文件来启动应用程序，第一次需要运行一下才能被系统识别出图标
/opt/ToolBox/jetbrains-toolbox
echo "==========开始jetbra破解工具包=========="
wget -O jetbra.zip https://hardbin.com/ipfs/bafybeiawsvnhqx5o2aqa37pvq7brlk7vqj2cpty3b5xac655bxbpqbpkq4/files/jetbra-ded4f9dc4fcb60294b21669dafa90330f2713ce4.zip
# 解压 ZIP 压缩文件，使用 unzip 解压直接得到里面内容，也可以后面指定目录
unzip jetbra.zip
# 重命名文件夹
mv jetbra .jetbra
# 移动文件夹到用户主目录
mv .jetbra $HOME

-javaagent:/home/lcqh/.jetbra/ja-netfilter.jar=jetbrains


echo "==========开始安装 Apifox 接口测试工具=========="
# Apifox
wget https://file-assets.apifox.com/download/Apifox-linux-deb-latest.zip
# 解压 ZIP 压缩文件，使用 unzip 解压直接得到里面内容，也可以后面指定目录
unzip Apifox-linux-deb-latest.zip -d Apifox-linux-deb-latest
cd Apifox-linux-deb-latest
package_name=$(ls | grep deb)
sudo apt install ./$package_name -y

echo "==========完成安装工作和娱乐常用软件工具=========="

# https://wiki.archlinux.org/title/MariaDB
# MariaDB 是一个可靠，高性能且功能齐全的数据库服务器，是Arch Linux默认的MySQL实现
yay -S mariadb
mysql --version
/usr/bin/mariadb --version

# 如果数据库（在 /var/lib/mysql 中）驻留在 Btrfs 文件系统上，则应考虑在创建任何数据库之前禁用该目录的 Copy-on-Write。
sudo chmod -R 777 /var/lib/mysql
# mariadb-secure-installation 命令将以交互方式指导您完成一些建议的安全措施，例如删除匿名帐户和删除测试数据库：
sudo mariadb-secure-installation
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb.service
systemctl status mariadb.service
# 以 sudo 管理员运行则不需要密码，无需密码
sudo mariadb
sudo mariadb -u root -p
show databases;
use mysql;
select host, user, plugin, authentication_string from user;
ALTER USER 'root'@'localhost' IDENTIFIED BY '479368';

# 需要密码
mariadb -u root -p


# - initialize: 默认会为 root 账户生成一个随机密码，且这个密码会过期。过期后需要重新生成一个。
# - initialize-insecure : 不会为 root 账户生成密码。
sudo systemctl start mysqld.service
sudo systemctl start mariadb.service


mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY '479368';
# 设置开机启动
sudo systemctl enable mysqld.service
cat /var/log/mysqld.log
chmod -R 777 /var/lib/mysql
nautilus admin:/var/lib




yay -S redis
redis-server --version
sudo chmod +rw /etc/redis
cat /etc/redis/redis.conf
sudo vim /etc/redis/redis.conf
requirepass 479368


sudo systemctl restart redis
redis-server --requirepass 479368
