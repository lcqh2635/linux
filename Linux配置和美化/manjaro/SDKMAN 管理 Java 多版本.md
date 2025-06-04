**SDKMAN!** 是管理多版本 Java 和开发工具链的利器，以下是其 **常用命令及作用**的清晰总结：

---

### **1. 核心命令**
| 命令                | 作用                                 | 示例                           |
| ------------------- | ------------------------------------ | ------------------------------ |
| **`sdk list`**      | 列出所有可安装的软件（JDK、Maven等） | `sdk list java`                |
| **`sdk install`**   | 安装指定版本                         | `sdk install java 17.0.10-tem` |
| **`sdk uninstall`** | 卸载版本                             | `sdk uninstall maven 3.9.6`    |
| **`sdk use`**       | 临时切换版本                         | `sdk use java 21.0.6-graal`    |
| **`sdk default`**   | 设置默认版本                         | `sdk default java 11.0.22-tem` |
| **`sdk current`**   | 查看当前使用的版本                   | `sdk current java`             |
| **`sdk upgrade`**   | 升级已安装的版本                     | `sdk upgrade gradle`           |
| **`sdk version`**   | 查看 SDKMAN! 自身版本                | `sdk version`                  |
| **`sdk offline`**   | 启用/禁用离线模式                    | `sdk offline enable`           |

---

### **2. 高频场景示例**
#### **① 安装和管理 Java**
```bash
# 列出所有可安装的 JDK 版本
sdk list java

# 安装 Temurin JDK 17
sdk install java 17.0.10-tem

# 切换到 GraalVM 21
sdk use java 21.0.6-graal

# 设置默认 JDK 为 11
sdk default java 11.0.22-tem
```

#### **② 管理构建工具（Maven/Gradle）**
```bash
# 安装 Maven
sdk install maven 3.9.6

# 临时使用 Gradle 8.6
sdk use gradle 8.6.0

# 升级所有已安装工具
sdk upgrade
```

#### **③ 清理和维护**
```bash
# 卸载旧版 Java 8
sdk uninstall java 8.0.392-tem

# 查看当前所有工具的版本
sdk current
```

---

### **3. 实用技巧**
#### **查看候选版本详情**
```bash
sdk list java | grep -A 5 "17.0.10-tem"  # 筛选特定版本信息
```

#### **批量安装常用工具**
```bash
sdk install java 17.0.10-tem && \
sdk install maven 3.9.6 && \
sdk install gradle 8.6.0
```

#### **快速回滚版本**
```bash
sdk use java 21.0.6-tem  # 临时切换
sdk default java 17.0.10-tem  # 永久恢复默认
```

---

### **4. 注意事项**
- **网络问题**：若下载慢，可配置镜像：
  ```bash
  export SDKMAN_CANDIDATES_API="https://mirrors.tuna.tsinghua.edu.cn/sdkman"
  ```
- **依赖冲突**：不同工具版本可能依赖特定 JDK，用 `sdk use` 灵活切换。
- **自动补全**：启用 Shell 补全（如 Zsh/Bash）提升效率：
  ```bash
  echo "source \"$SDKMAN_DIR/completions/sdkman.zsh-completion\"" >> ~/.zshrc
  ```

---

### **总结：SDKMAN! 核心价值**
- **一键切换环境**：解决多版本共存问题。
- **工具链统一管理**：JDK、构建工具、Scala/Kotlin 等。
- **干净卸载**：避免系统目录污染。

掌握这些命令后，你可以像这样高效工作：
```bash
sdk install java 21.0.6-graal && sdk use java 21.0.6-graal && java -version
```