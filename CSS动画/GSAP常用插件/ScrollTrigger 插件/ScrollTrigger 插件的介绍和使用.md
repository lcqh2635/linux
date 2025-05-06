# GSAP ScrollTrigger 插件详解

ScrollTrigger 是 GSAP (GreenSock Animation Platform) 的一个强大插件，它可以让动画与滚动位置精确关联，实现滚动触发动画效果。

## ScrollTrigger 的主要作用

1. **基于滚动位置触发动画** - 当用户滚动到特定位置时开始/结束动画
2. **创建视差效果** - 不同元素以不同速度滚动
3. **实现固定定位元素** - 在滚动过程中固定某个元素一段时间
4. **分屏动画控制** - 将动画与页面不同部分关联
5. **滚动进度控制** - 根据滚动位置控制动画进度

## 使用场景

- 当元素进入视口时触发动画
- 创建随着滚动而播放的动画序列
- 实现视差滚动效果
- 制作固定在某位置的元素（如固定标题）
- 构建复杂的滚动讲故事页面
- 创建基于滚动的产品展示

## 示例：美观的滚动动画页面

下面是一个完整的、可运行的示例，展示了多种 ScrollTrigger 效果：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GSAP ScrollTrigger 示例</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background: #f5f5f5;
            color: #333;
            overflow-x: hidden;
        }
        
        section {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 50px;
            position: relative;
            overflow: hidden;
        }
        
        h1, h2 {
            margin-bottom: 30px;
            text-align: center;
        }
        
        p {
            max-width: 800px;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .box {
            width: 150px;
            height: 150px;
            background: linear-gradient(135deg, #6e8efb, #a777e3);
            border-radius: 10px;
            margin: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-weight: bold;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .panel {
            width: 100%;
            padding: 50px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin: 20px 0;
            opacity: 0;
            transform: translateY(50px);
        }
        
        .parallax {
            width: 100%;
            height: 300px;
            background: url('https://source.unsplash.com/random/1600x900') center/cover;
            margin: 50px 0;
            position: relative;
        }
        
        .pin-container {
            width: 100%;
            height: 500px;
            background: #eee;
            margin: 50px 0;
            position: relative;
        }
        
        .pinned-element {
            width: 200px;
            height: 200px;
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border-radius: 50%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-weight: bold;
        }
        
        .scroll-progress {
            position: fixed;
            top: 0;
            left: 0;
            width: 0;
            height: 5px;
            background: linear-gradient(90deg, #6e8efb, #a777e3);
            z-index: 100;
        }
    </style>
</head>
<body>
    <!-- 滚动进度指示器 -->
    <div class="scroll-progress"></div>
    
    <section>
        <h1>GSAP ScrollTrigger 演示</h1>
        <p>向下滚动查看各种 ScrollTrigger 动画效果</p>
        <div class="box">我会在滚动时旋转</div>
    </section>
    
    <section>
        <div class="panel">
            <h2>进入视口动画</h2>
            <p>这个面板会在滚动到它时淡入并向上移动</p>
        </div>
        
        <div class="panel">
            <h2>另一个面板</h2>
            <p>每个面板都会依次以不同延迟触发动画</p>
        </div>
    </section>
    
    <section>
        <h2>视差效果</h2>
        <div class="parallax"></div>
        <p>背景图片会以不同于页面的速度滚动，产生视差效果</p>
    </section>
    
    <section class="pin-container">
        <div class="pinned-element">我会被固定一段时间</div>
    </section>
    
    <section>
        <h2>动画序列</h2>
        <div class="box" id="box1">1</div>
        <div class="box" id="box2">2</div>
        <div class="box" id="box3">3</div>
        <p>这些盒子会在滚动时依次动画</p>
    </section>
    
    <section>
        <h2>滚动到顶部</h2>
        <p>你已经到达页面底部！</p>
    </section>

    <!-- 引入 GSAP 和 ScrollTrigger -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/ScrollTrigger.min.js"></script>
    
    <script>
        // 注册 ScrollTrigger 插件
        gsap.registerPlugin(ScrollTrigger);
        
        // 1. 基本旋转动画 - 元素在滚动时旋转
        gsap.to(".box", {
            rotation: 360,
            scrollTrigger: {
                trigger: ".box",
                start: "top 80%", // 当元素顶部距离视口底部80%时开始
                end: "top 20%",   // 当元素顶部距离视口底部20%时结束
                scrub: true,       // 动画与滚动位置紧密关联
                markers: false     // 调试时可设为true显示标记
            }
        });
        
        // 2. 进入视口动画 - 面板淡入和上移
        gsap.utils.toArray(".panel").forEach((panel, i) => {
            gsap.from(panel, {
                opacity: 0,
                y: 50,
                duration: 1,
                scrollTrigger: {
                    trigger: panel,
                    start: "top 80%",
                    toggleActions: "play none none none" // 进入时播放，不重复
                },
                delay: i * 0.2 // 每个面板有0.2秒的延迟
            });
        });
        
        // 3. 视差效果 - 背景图片以不同速度滚动
        gsap.to(".parallax", {
            yPercent: 30,
            ease: "none",
            scrollTrigger: {
                trigger: ".parallax",
                start: "top bottom",
                end: "bottom top",
                scrub: true
            }
        });
        
        // 4. 固定元素 - 在滚动过程中固定一段时间
        ScrollTrigger.create({
            trigger: ".pin-container",
            pin: ".pinned-element",
            start: "top top",
            end: "+=500",
            scrub: true,
            markers: false
        });
        
        // 5. 动画序列 - 滚动时依次动画盒子
        const boxes = gsap.utils.toArray("#box1, #box2, #box3");
        boxes.forEach((box, i) => {
            gsap.from(box, {
                x: i % 2 ? -200 : 200,
                opacity: 0,
                duration: 1,
                scrollTrigger: {
                    trigger: box,
                    start: "top 80%",
                    toggleActions: "play none none none"
                },
                delay: i * 0.3
            });
        });
        
        // 6. 滚动进度指示器
        gsap.to(".scroll-progress", {
            width: "100%",
            ease: "none",
            scrollTrigger: {
                scrub: 0.5
            }
        });
    </script>
</body>
</html>
```

## 示例效果说明

这个示例展示了多种 ScrollTrigger 效果：

1. **基本旋转动画** - 第一个盒子会在滚动时旋转360度
2. **进入视口动画** - 两个面板会在滚动到它们时淡入并上移
3. **视差效果** - 图片背景以不同于页面的速度滚动
4. **固定元素** - 圆形元素会在特定区域滚动时保持固定
5. **动画序列** - 三个盒子依次从不同方向进入
6. **滚动进度指示器** - 顶部有一个进度条显示滚动进度

要运行此示例，只需将代码复制到HTML文件中并在浏览器中打开即可。所有资源都通过CDN引入，无需额外安装。

ScrollTrigger 的强大之处在于它可以精确控制动画与滚动位置的关系，创造出丰富多样的交互体验。