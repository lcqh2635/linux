#!/bin/bash

# 设置在遇到错误时自动退出
set -e

# 读取用户密码
read -p "请输入你的登陆密码：" password

# 下载安装非软件商城编程软件
cd $HOME/下载
echo "==========开始安装 WindTerm_远程连接SSH软件工具=========="
wget https://github.com/kingToolbox/WindTerm/releases/download/2.6.0/WindTerm_2.6.1_Linux_Portable_x86_64.tar.gz
# 解压缩 .tar.gz 文件
tar -xvf WindTerm_2.6.1_Linux_Portable_x86_64.tar.gz
# 重命名文件夹
mv WindTerm_2.6.1 WindTerm
# 移动文件夹到 /opt
echo $password | su -c "mv WindTerm /opt" -s /bin/bash root
# 进入到 /opt/WindTerm 文件夹
cd /opt/WindTerm
# 执行权限
echo $password | su -c "chmod +x WindTerm" -s /bin/bash root
# 给快捷方式文件添加公共读取权限，让其能够被系统读取识别
echo $password | su -c "chmod +r windterm.desktop" -s /bin/bash root
# 请注意，路径中的斜杠 / 需要使用反斜杠 \ 进行转义，否则会被解释为分隔符。
echo $password | su -c "sed -i 's/Icon=windterm/Icon=\/opt\/WindTerm\/windterm.png/g' windterm.desktop" -s /bin/bash root
echo $password | su -c "sed -i 's/Exec=\/usr\/bin\/windterm/Exec=\/opt\/WindTerm\/WindTerm/g' windterm.desktop" -s /bin/bash root
# 移动desktop文件到 /usr/share/applications
echo $password | su -c "cp windterm.desktop /usr/share/applications" -s /bin/bash root
# 修改 windterm 主题字体大小
cd global/themes
echo $password | su -c "sed -i 's/font-size: 9pt/font-size: 12pt/g' dige-black/gui.theme" -s /bin/bash root
echo $password | su -c "sed -i 's/font-size: 9pt/font-size: 12pt/g' dige-white/gui.theme" -s /bin/bash root
echo $password | su -c "sed -i 's/font-size: 9pt/font-size: 12pt/g' dige-black-and-white/gui.theme" -s /bin/bash root
