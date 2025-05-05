# GSAP Draggable 插件详解

GSAP (GreenSock Animation Platform) 的 Draggable 插件是一个强大的工具，可以让任何 DOM 元素变得可拖动，并提供了丰富的控制选项和回调函数。

## Draggable 插件的作用

1. **使元素可拖动**：让任何 DOM 元素能够被鼠标或触摸拖动
2. **多种拖动类型**：支持 x/y 方向拖动、旋转和缩放
3. **边界限制**：可以设置拖动边界和约束
4. **惯性效果**：支持动量/惯性拖动效果
5. **丰富事件**：提供拖动开始、拖动中、拖动结束等回调
6. **与GSAP集成**：可以与其他GSAP动画无缝配合

## 使用场景

- 滑块/轮播图
- 可拖动UI组件（如对话框、面板）
- 拼图游戏
- 可排序列表
- 自定义滚动区域
- 任何需要拖放交互的场景

## 示例：可拖动卡片拼图

下面是一个完整的可拖动卡片拼图示例，用户可以拖动卡片到目标位置：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GSAP Draggable 卡片拼图</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/Draggable.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }
        
        h1 {
            color: #3a4a6d;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }
        
        .container {
            display: flex;
            gap: 30px;
            width: 100%;
            max-width: 900px;
        }
        
        .cards-container, .target-container {
            flex: 1;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .card {
            width: 100px;
            height: 100px;
            border-radius: 8px;
            margin: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: white;
            cursor: move;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .target {
            width: 120px;
            height: 120px;
            border: 2px dashed #aaa;
            border-radius: 8px;
            margin: 10px;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(255,255,255,0.5);
            transition: all 0.3s;
        }
        
        .target.highlight {
            border-color: #4CAF50;
            background-color: rgba(76, 175, 80, 0.1);
        }
        
        .target.filled {
            border-style: solid;
            background-color: rgba(76, 175, 80, 0.2);
        }
        
        .success-message {
            margin-top: 20px;
            padding: 15px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s;
        }
        
        .success-message.show {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <h1>卡片拼图游戏</h1>
    
    <div class="container">
        <div class="cards-container" id="cards">
            <div class="card" style="background-color: #FF6B6B;" data-id="1">1</div>
            <div class="card" style="background-color: #4ECDC4;" data-id="2">2</div>
            <div class="card" style="background-color: #45B7D1;" data-id="3">3</div>
        </div>
        
        <div class="target-container" id="targets">
            <div class="target" data-target-id="1"></div>
            <div class="target" data-target-id="2"></div>
            <div class="target" data-target-id="3"></div>
        </div>
    </div>
    
    <div class="success-message" id="successMessage">
        恭喜！你完成了拼图！
    </div>
    
    <script>
        // 初始化Draggable
        Draggable.create(".card", {
            type: "x,y",
            bounds: document.body,
            edgeResistance: 0.1,
            onDragStart: function() {
                // 拖动开始时，提升z-index
                gsap.to(this.target, {zIndex: 100, duration: 0.1});
            },
            onDrag: function() {
                // 拖动时检查是否在目标区域上方
                const targets = document.querySelectorAll(".target");
                const cardId = this.target.dataset.id;
                const correctTarget = document.querySelector(`.target[data-target-id="${cardId}"]`);
                
                targets.forEach(target => {
                    target.classList.remove("highlight");
                });
                
                if (this.hitTest(correctTarget, "80%")) {
                    correctTarget.classList.add("highlight");
                }
            },
            onDragEnd: function() {
                // 拖动结束时检查是否放入正确位置
                const cardId = this.target.dataset.id;
                const correctTarget = document.querySelector(`.target[data-target-id="${cardId}"]`);
                
                if (this.hitTest(correctTarget, "80%")) {
                    // 放入正确位置
                    const targetRect = correctTarget.getBoundingClientRect();
                    gsap.to(this.target, {
                        x: targetRect.left + targetRect.width/2 - this.target.getBoundingClientRect().width/2 - this.target.parentNode.getBoundingClientRect().left,
                        y: targetRect.top + targetRect.height/2 - this.target.getBoundingClientRect().height/2 - this.target.parentNode.getBoundingClientRect().top,
                        duration: 0.3,
                        onComplete: () => {
                            correctTarget.classList.add("filled");
                            correctTarget.classList.remove("highlight");
                            checkCompletion();
                        }
                    });
                } else {
                    // 返回原位
                    gsap.to(this.target, {
                        x: 0,
                        y: 0,
                        duration: 0.5,
                        ease: "elastic.out(1, 0.5)"
                    });
                }
                
                // 重置z-index
                gsap.to(this.target, {zIndex: 0, delay: 0.3});
            }
        });
        
        // 检查是否所有卡片都放到了正确位置
        function checkCompletion() {
            const cards = document.querySelectorAll(".card");
            let allCorrect = true;
            
            cards.forEach(card => {
                const cardId = card.dataset.id;
                const correctTarget = document.querySelector(`.target[data-target-id="${cardId}"]`);
                
                if (!correctTarget.classList.contains("filled")) {
                    allCorrect = false;
                }
            });
            
            if (allCorrect) {
                document.getElementById("successMessage").classList.add("show");
                
                // 庆祝动画
                gsap.to(".card", {
                    y: -20,
                    duration: 0.5,
                    repeat: 1,
                    yoyo: true,
                    ease: "power1.inOut"
                });
            }
        }
    </script>
</body>
</html>
```

## 示例功能说明

1. **可拖动卡片**：左侧的三个彩色卡片可以通过鼠标拖动
2. **目标区域**：右侧有三个目标区域，每个卡片有对应的目标位置
3. **视觉反馈**：
    - 拖动时卡片会轻微上浮
    - 当卡片靠近正确目标时，目标区域会高亮
    - 正确放置后，卡片会平滑移动到目标中心
    - 错误放置时，卡片会弹性返回原位
4. **完成检测**：当所有卡片都正确放置后，会显示成功消息和庆祝动画

这个示例展示了Draggable插件的核心功能，包括拖动控制、边界检测、碰撞检测和与GSAP动画的配合使用。你可以根据需要进一步扩展功能或调整样式。