# GSAP SplitText插件详解

SplitText是GSAP动画库的一个强大插件，它能够将文本内容分割成字符、单词或行，便于创建精细的文本动画效果。

## SplitText的作用

1. **文本分割**：将文本分割成字符、单词或行
2. **动画控制**：为分割后的文本元素单独或批量添加动画
3. **布局保留**：保持原始文本的布局和流式布局
4. **响应式支持**：自动处理响应式布局中的文本变化

## 使用场景

1. 逐字显示动画
2. 文本序列动画
3. 打字机效果
4. 文本遮罩动画
5. 文本交错动画
6. 文本滚动动画
7. 文本悬停效果

## 可运行示例

下面是一个使用SplitText创建逐字动画的示例：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GSAP SplitText Demo</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            overflow: hidden;
            color: white;
        }
        
        .container {
            text-align: center;
            max-width: 800px;
            padding: 20px;
        }
        
        h1 {
            font-size: 3rem;
            margin-bottom: 30px;
            line-height: 1.3;
            opacity: 0;
        }
        
        p {
            font-size: 1.5rem;
            line-height: 1.6;
            opacity: 0;
        }
        
        .btn {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 30px;
            background: transparent;
            border: 2px solid white;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 30px;
            transition: all 0.3s ease;
            opacity: 0;
        }
        
        .btn:hover {
            background: white;
            color: #764ba2;
        }
        
        .char {
            display: inline-block;
            position: relative;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>SplitText creates stunning text animations</h1>
        <p>This plugin makes it easy to animate text by characters, words, or lines. Perfect for modern web experiences.</p>
        <button class="btn" id="replay">Replay Animation</button>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/SplitText.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // 初始化SplitText实例
            const splitHeading = new SplitText('h1', { 
                type: 'chars,words,lines', 
                linesClass: 'line'
            });
            
            const splitParagraph = new SplitText('p', { 
                type: 'chars', 
                charsClass: 'char'
            });
            
            // 设置动画初始状态
            gsap.set('h1', { opacity: 1 });
            gsap.set(splitHeading.chars, { 
                opacity: 0, 
                y: 50, 
                rotationX: -90 
            });
            
            gsap.set('p', { opacity: 1 });
            gsap.set(splitParagraph.chars, { 
                opacity: 0, 
                y: 20 
            });
            
            // 创建时间轴动画
            const tl = gsap.timeline();
            
            // 标题字符动画
            tl.to(splitHeading.chars, {
                duration: 0.8,
                opacity: 1,
                y: 0,
                rotationX: 0,
                stagger: 0.03,
                ease: 'back.out'
            });
            
            // 段落字符动画（延迟开始）
            tl.to(splitParagraph.chars, {
                duration: 0.5,
                opacity: 1,
                y: 0,
                stagger: 0.02,
                ease: 'power2.out'
            }, '-=0.4');
            
            // 按钮动画
            tl.to('.btn', {
                duration: 0.8,
                opacity: 1,
                y: 0,
                ease: 'elastic.out(1, 0.5)'
            }, '-=0.2');
            
            // 重新播放动画
            document.getElementById('replay').addEventListener('click', () => {
                tl.restart();
            });
        });
    </script>
</body>
</html>
```

## 示例解析

1. **文本分割**：使用SplitText将标题和段落文本分割成字符
2. **初始状态**：将所有分割后的字符设置为透明和偏移位置
3. **动画序列**：
    - 标题字符逐个飞入并旋转
    - 段落字符逐个淡入并上浮
    - 按钮弹性出现
4. **交错效果**：使用stagger参数实现字符动画的错开效果
5. **交互功能**：添加重新播放动画的按钮

这个示例展示了SplitText最常用的功能 - 将文本分割成字符并创建逐个显示的动画效果。你可以根据需要调整分割方式（字符、单词或行）以及动画参数来创建各种不同的文本动画效果。

要运行此示例，只需将代码复制到HTML文件中并在浏览器中打开即可。