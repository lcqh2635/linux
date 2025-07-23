#!/bin/bash

# Fedora GNOME 42 初始化优化配置脚本
# 功能：自动安装并配置加速镜像、工具、依赖包
# 使用方法：chmod +x jetbrains-vmoptions.sh && ./jetbrains-vmoptions.sh

# 更新系统并升级所有已安装的包
echo "开始更新系统并升级所有已安装的包..."
sudo dnf update -y && sudo dnf upgrade -y
echo "系统更新、升级完成..."


# 启用第三方优质库	https://copr.fedorainfracloud.org
# https://copr.fedorainfracloud.org/coprs/medzik/jetbrains/
# sudo dnf copr enable medzik/jetbrains
# dnf list goland
# sudo dnf install -y intellij-idea-ultimate
# sudo dnf install -y goland webstorm rustrover datagrip android-studio pycharm-professional


# 下载  jetbra.zip 以及获取 JetBrains 软件激活码
# https://3.jetbra.in/
# https://ipfs.io/ipfs/bafybeih65no5dklpqfe346wyeiak6wzemv5d7z2ya7nssdgwdz4xrmdu6i/
# https://bafybeih65no5dklpqfe346wyeiak6wzemv5d7z2ya7nssdgwdz4xrmdu6i.ipfs.dweb.link/


# 下载 jetbrains-toolbox 应用
echo "准备开始安装jetbrains-toolbox应用..."
if [ ! -d "WhiteSur-wallpapers" ]; then
    echo "正在安装WhiteSur壁纸..."
    # git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
    git clone https://gitee.com/llf2635/linux.git --depth=1
    cd linux
    sudo dnf install -y unzip
    unzip jetbra.zip
    mv jetbra ~/.jetbra
    wget "https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.6.2.41321.tar.gz"
    tar -xzf jetbrains-toolbox-2.6.2.41321.tar.gz
    cd jetbrains-toolbox-2.6.2.41321
    ./jetbrains-toolbox
    cd ..
    rm -rf jetbrains-toolbox-2.6.2.41321 jetbrains-toolbox-2.6.2.41321.tar.gz
fi


# IDEA 虚拟机配置文件存放位置
# nautilus ~/.config/JetBrains
# cat ~/.config/JetBrains/IntelliJIdea*/idea64.vmoptions


# 为 IntelliJIdea 配置虚拟机参数
echo "
-Xms1g
-Xmx5g
-XX:ReservedCodeCacheSize=512m
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-XX:+UseZGC
-XX:SoftRefLRUPolicyMSPerMB=50
-XX:CICompilerCount=2
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-ea
-Dsun.io.useCanonCaches=false
-Djdk.http.auth.tunneling.disabledSchemes=""
-Djdk.attach.allowAttachSelf=true
-Djdk.module.illegalAccess.silent=true
-Dkotlinx.coroutines.debug=off
-Drecreate.x11.input.method=true
-XX:ErrorFile=$USER_HOME/java_error_in_idea_%p.log
-XX:HeapDumpPath=$USER_HOME/java_error_in_idea.hprof
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
-javaagent:/home/lcqh/.jetbra/ja-netfilter.jar=jetbrains
" | sudo tee -a ~/.config/JetBrains/IntelliJIdea*/idea64.vmoptions

# 为 GoLand 配置虚拟机参数
echo "
-Xms1g
-Xmx5g
-XX:ReservedCodeCacheSize=512m
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-XX:+UseZGC
-XX:SoftRefLRUPolicyMSPerMB=50
-XX:CICompilerCount=2
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-ea
-Dsun.io.useCanonCaches=false
-Djdk.http.auth.tunneling.disabledSchemes=""
-Djdk.attach.allowAttachSelf=true
-Djdk.module.illegalAccess.silent=true
-Dkotlinx.coroutines.debug=off
-Drecreate.x11.input.method=true
-XX:ErrorFile=$USER_HOME/java_error_in_idea_%p.log
-XX:HeapDumpPath=$USER_HOME/java_error_in_idea.hprof
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
-javaagent:/home/lcqh/.jetbra/ja-netfilter.jar=jetbrains
" | sudo tee -a ~/.config/JetBrains/GoLand*/goland64.vmoptions

# 为 DataGrip 配置虚拟机参数
echo "
-Xms1g
-Xmx5g
-XX:ReservedCodeCacheSize=512m
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-XX:+UseZGC
-XX:SoftRefLRUPolicyMSPerMB=50
-XX:CICompilerCount=2
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-ea
-Dsun.io.useCanonCaches=false
-Djdk.http.auth.tunneling.disabledSchemes=""
-Djdk.attach.allowAttachSelf=true
-Djdk.module.illegalAccess.silent=true
-Dkotlinx.coroutines.debug=off
-Drecreate.x11.input.method=true
-XX:ErrorFile=$USER_HOME/java_error_in_idea_%p.log
-XX:HeapDumpPath=$USER_HOME/java_error_in_idea.hprof
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
-javaagent:/home/lcqh/.jetbra/ja-netfilter.jar=jetbrains
" | sudo tee -a ~/.config/JetBrains/DataGrip*/datagrip64.vmoptions

# 为 PyCharm 配置虚拟机参数
echo "
-Xms1g
-Xmx5g
-XX:ReservedCodeCacheSize=512m
-XX:+IgnoreUnrecognizedVMOptions
-XX:+UnlockExperimentalVMOptions
-XX:+UseZGC
-XX:SoftRefLRUPolicyMSPerMB=50
-XX:CICompilerCount=2
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-ea
-Dsun.io.useCanonCaches=false
-Djdk.http.auth.tunneling.disabledSchemes=""
-Djdk.attach.allowAttachSelf=true
-Djdk.module.illegalAccess.silent=true
-Dkotlinx.coroutines.debug=off
-Drecreate.x11.input.method=true
-XX:ErrorFile=$USER_HOME/java_error_in_idea_%p.log
-XX:HeapDumpPath=$USER_HOME/java_error_in_idea.hprof
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
-javaagent:/home/lcqh/.jetbra/ja-netfilter.jar=jetbrains
" | sudo tee -a ~/.config/JetBrains/PyCharm*/pycharm64.vmoptions


# 清理临时文件
echo "正在清理临时文件..."
dnf clean all

echo "主题美化完成！请注销或重启系统以查看全部更改效果。"
echo "您可以使用GNOME Tweaks工具进一步自定义外观。"

