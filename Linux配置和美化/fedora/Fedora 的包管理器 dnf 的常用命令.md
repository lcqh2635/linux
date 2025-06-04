以下是关于 Fedora Workstation 41 的软件包管理器 `dnf` 的说明及其常用命令的表格总结：

---

### **DNF 简介**
| 项目     | 说明                                                         |
| -------- | ------------------------------------------------------------ |
| **全称** | Dandified YUM（下一代 YUM）                                  |
| **作用** | Fedora 的默认包管理器，用于软件包的安装、更新、删除及系统依赖管理 |
| **特点** | 支持 RPM 包、依赖自动解析、事务回滚、模块化仓库等            |

---

### **常用 DNF 命令及作用**
| 命令                       | 作用                                 | 示例                                    |
| -------------------------- | ------------------------------------ | --------------------------------------- |
| `dnf install <包名>`       | 安装指定软件包                       | `dnf install neovim`                    |
| `dnf remove <包名>`        | 卸载软件包（保留依赖）               | `dnf remove firefox`                    |
| `dnf autoremove`           | 删除无用依赖                         | `dnf autoremove`                        |
| `dnf update`               | 更新所有可升级的软件包               | `dnf update`                            |
| `dnf upgrade`              | 等同于 `update`（Fedora 中两者相同） | `dnf upgrade`                           |
| `dnf search <关键词>`      | 搜索软件包                           | `dnf search python`                     |
| `dnf info <包名>`          | 显示软件包详细信息                   | `dnf info httpd`                        |
| `dnf list installed`       | 列出已安装的软件包                   | `dnf list installed`                    |
| `dnf repolist`             | 查看已启用的仓库                     | `dnf repolist`                          |
| `dnf history`              | 查看 DNF 操作历史                    | `dnf history`                           |
| `dnf history undo <ID>`    | 回滚指定操作                         | `dnf history undo 5`                    |
| `dnf clean all`            | 清理缓存（元数据和软件包）           | `dnf clean all`                         |
| `dnf group list`           | 列出软件包组                         | `dnf group list`                        |
| `dnf group install <组名>` | 安装软件包组                         | `dnf group install "Development Tools"` |
| `dnf provides <文件路径>`  | 查找提供特定文件的包                 | `dnf provides /bin/bash`                |

---

### **常用选项**
| 选项           | 说明                        |
| -------------- | --------------------------- |
| `-y`           | 自动确认操作（非交互式）    |
| `--refresh`    | 强制刷新仓库元数据          |
| `--nogpgcheck` | 跳过 GPG 签名验证（不推荐） |

---

### **注意事项**
1. 需要 `sudo` 权限执行管理操作（如安装、更新）。
2. 定期运行 `dnf update` 保持系统安全。
3. 使用 `dnf history undo` 可撤销错误操作。

如果需要更详细的参数说明，可通过 `man dnf` 查看手册。



```bash
sudo dnf list installed | grep nginx

sudo dnf repolist --all
```







以下是 **DNF** 包管理器的更多常用命令及其作用，补充到之前的表格中，方便你更全面地使用 Fedora Workstation 41：

---

### **扩展的 DNF 常用命令表**
| 命令                     | 作用                                        | 示例                                  |
| ------------------------ | ------------------------------------------- | ------------------------------------- |
| `dnf downgrade <包名>`   | 降级软件包到旧版本                          | `dnf downgrade kernel`                |
| `dnf reinstall <包名>`   | 重新安装指定软件包                          | `dnf reinstall nano`                  |
| `dnf check-update`       | 检查可更新的软件包（不实际更新）            | `dnf check-update`                    |
| `dnf distro-sync`        | 同步软件包到发行版默认版本                  | `dnf distro-sync`                     |
| `dnf makecache`          | 生成或更新仓库元数据缓存                    | `dnf makecache`                       |
| `dnf repoquery <模式>`   | 查询仓库中的包（需安装 `dnf-plugins-core`） | `dnf repoquery --installed`           |
| `dnf deplist <包名>`     | 查看软件包的依赖关系                        | `dnf deplist python3`                 |
| `dnf needs-restarting`   | 列出需要重启的服务/进程（安全更新后）       | `dnf needs-restarting`                |
| `dnf download <包名>`    | 下载 RPM 包但不安装                         | `dnf download httpd`                  |
| `dnf list available`     | 列出仓库中所有可用软件包                    | `dnf list available`                  |
| `dnf list updates`       | 列出可更新的软件包                          | `dnf list updates`                    |
| `dnf list extras`        | 列出非仓库来源安装的包                      | `dnf list extras`                     |
| `dnf shell`              | 进入交互式 DNF 命令行模式                   | `dnf shell`                           |
| `dnf config-manager`     | 管理仓库配置（需安装 `dnf-plugins-core`）   | `dnf config-manager --add-repo <URL>` |
| `dnf copr enable <仓库>` | 启用 COPR 第三方仓库                        | `dnf copr enable user/repo`           |

---

### **实用组合命令**
| 场景               | 命令                                                       |
| ------------------ | ---------------------------------------------------------- |
| **清理系统**       | `sudo dnf autoremove && sudo dnf clean all`                |
| **查找文件所属包** | `dnf provides */<文件名>`（如 `dnf provides */libc.so.6`） |
| **查看仓库优先级** | `dnf repolist -v`                                          |
| **排除特定包更新** | `sudo dnf update --exclude=kernel*`                        |

---

### **注意事项**
1. **第三方仓库**：COPR 或 RPM Fusion 等仓库需谨慎启用（可能影响稳定性）。  
   - 例如启用 RPM Fusion：  
     ```bash
     sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
     ```
2. **调试依赖问题**：若安装失败，尝试 `sudo dnf --skip-broken install` 跳过冲突包。  
3. **历史回滚**：`dnf history` 显示的 `ID` 可用于回滚（如 `sudo dnf history undo 3`）。

如果需要更高级功能（如模块管理、构建依赖等），可查阅 `man dnf` 或 Fedora 官方文档。
