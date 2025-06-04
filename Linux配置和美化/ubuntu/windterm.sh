#!/bin/bash

echo "==========开始安装 WindTerm_远程连接SSH软件工具=========="
wget https://github.com/kingToolbox/WindTerm/releases/download/2.6.0/WindTerm_2.6.1_Linux_Portable_x86_64.tar.gz
# 解压缩 .tar.gz 文件
tar -xvf WindTerm_2.6.1_Linux_Portable_x86_64.tar.gz
# 重命名文件夹
mv WindTerm_2.6.1 WindTerm
# 移动文件夹到 /opt
sudo mv WindTerm /opt
# 进入到 /opt/WindTerm 文件夹
cd /opt/WindTerm
# 执行权限
sudo chmod +x WindTerm
# 给快捷方式文件添加公共读取权限，让其能够被系统读取识别
sudo chmod +r windterm.desktop
# 请注意，路径中的斜杠 / 需要使用反斜杠 \ 进行转义，否则会被解释为分隔符。
sudo sed -i 's/Icon=windterm/Icon=\/opt\/WindTerm\/windterm.png/g' windterm.desktop
sudo sed -i 's/Exec=\/usr\/bin\/windterm/Exec=\/opt\/WindTerm\/WindTerm/g' windterm.desktop
# 移动desktop文件到 /usr/share/applications
sudo cp windterm.desktop /usr/share/applications
# 修改 windterm 主题字体大小
cd global/themes
sudo sed -i 's/font-size: 9pt/font-size: 12pt/g' dige-black/gui.theme
sudo sed -i 's/font-size: 9pt/font-size: 12pt/g' dige-white/gui.theme
sudo sed -i 's/font-size: 9pt/font-size: 12pt/g' dige-black-and-white/gui.theme
