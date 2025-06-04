#!/bin/bash

echo "==========开始一键批量卸载snap安装软件=========="
# 一键批量卸载snap安装软件
for p in $(snap list | awk '{print $1}'); do  
  sudo snap remove $p  
done
# 执行第二遍，必须
for p in $(snap list | awk '{print $1}'); do  
  sudo snap remove $p  
done
for p in $(snap list | awk '{print $1}'); do  
  sudo snap remove $p  
done

# 移除 Snapd 服务
echo "==========开始关闭 snapd 服务=========="
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

echo "==========开始卸载并移除 snapd 服务相关文件目录=========="
# 删除 Snap 的 Core 文件
for m in /snap/core/*; do  
   sudo umount $m  
done

sudo apt remove --autoremove snapd -y
# 删除 Snapd 的管理工具
sudo apt autoremove --purge snapd && sudo apt autoremove -y

# 删除 Snap 的目录
rm -rf ~/snap  
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd  
sudo rm -rf /var/cache/snapd
sudo rm -rf /etc/systemd/system/snap*
sudo rm -rf /etc/systemd/system/multi-user.target.wants/snap*
sudo apt update

# 禁用snap自动安装
# 这还没完，即使你用以上命令移除了 Snap 软件包，但是如果你没有关闭 apt 触发器，`sudo apt update` 命令会再一次将 Snap 安装回来。
# 配置 APT 参数：禁止 apt 安装 snapd
# 一键写入脚本，创建APT偏好设置文件并添加偏好设置
echo "==========开始禁用 snapd 相关软件源=========="
sudo bash -c "cat > /etc/apt/preferences.d/no-snapd.pref" << EOL  
Package: snapd
Pin: release a=* 
Pin-Priority: -10
EOL
# 显示设置的内容
cat /etc/apt/preferences.d/no-snapd.pref

# 添加火狐软件仓库,选择使用flatpak版本firefox
# sudo add-apt-repository ppa:mozillateam/ppa

# 清理无用的软件包
sudo apt autoremove && sudo apt autoclean -y 

sudo apt update && sudo apt upgrade -y

