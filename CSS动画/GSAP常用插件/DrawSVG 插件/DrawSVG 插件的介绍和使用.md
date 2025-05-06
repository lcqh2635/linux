# GSAP DrawSVG插件详解

DrawSVG插件是GSAP动画库中的一个强大工具，专门用于制作SVG路径的描边动画效果。它可以让你创建出路径逐渐绘制出来的视觉效果，非常适合用于图表展示、Logo动画、数据可视化等场景。

## DrawSVG插件的作用

1. **路径描边动画**：模拟手绘SVG路径的效果
2. **精确控制**：可以控制描边的开始点和结束点
3. **平滑过渡**：创建流畅的路径绘制动画
4. **性能优化**：比CSS或原生SVG动画更高效

## 使用场景

- Logo或图标的入场动画
- 数据图表的动态展示
- 地图路径的绘制效果
- 艺术性SVG插画的动画
- UI元素的加载动画

## 示例代码

下面是一个完整的、可运行的DrawSVG插件使用示例：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GSAP DrawSVG Plugin Demo</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
            margin: 0;
            overflow: hidden;
            font-family: 'Arial', sans-serif;
        }
        
        .container {
            width: 80%;
            max-width: 600px;
            text-align: center;
        }
        
        svg {
            width: 100%;
            height: auto;
            filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.5));
        }
        
        h1 {
            color: white;
            margin-bottom: 30px;
            text-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }
        
        .btn {
            margin-top: 30px;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid white;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn:hover {
            background: rgba(255, 255, 255, 0.4);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>SVG路径绘制动画</h1>
        <svg viewBox="0 0 500 200" id="svg-demo">
            <!-- 心形路径 -->
            <path id="heart" fill="none" stroke="#FFFFFF" stroke-width="3" 
                  d="M250,100 C200,20 100,20 100,100 C100,180 250,250 250,250 C250,250 400,180 400,100 C400,20 300,20 250,100 Z"/>
            
            <!-- 星星路径 -->
            <path id="star" fill="none" stroke="#FFD700" stroke-width="3" 
                  d="M250,50 L263,80 L295,85 L270,105 L280,135 L250,120 L220,135 L230,105 L205,85 L237,80 Z" 
                  style="opacity:0"/>
            
            <!-- 波浪路径 -->
            <path id="wave" fill="none" stroke="#4FC3F7" stroke-width="3" 
                  d="M50,150 C100,100 150,200 200,150 C250,100 300,200 350,150 C400,100 450,200 450,150" 
                  style="opacity:0"/>
        </svg>
        <button class="btn" id="replay-btn">重播动画</button>
    </div>

    <!-- 引入GSAP库和DrawSVG插件 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/DrawSVGPlugin.min.js"></script>

    <script>
        // 注册插件
        gsap.registerPlugin(DrawSVGPlugin);
        
        // 创建时间线
        const tl = gsap.timeline({defaults: {duration: 1.5, ease: "power2.inOut"}});
        
        // 动画序列
        tl.fromTo("#heart", 
            {drawSVG: "0% 0%"}, 
            {drawSVG: "0% 100%", opacity: 1})
          .to("#heart", 
            {fill: "rgba(255,255,255,0.2)", duration: 0.5})
          .fromTo("#star", 
            {drawSVG: "0% 0%", opacity: 1}, 
            {drawSVG: "0% 100%"}, "-=0.5")
          .to("#star", 
            {fill: "rgba(255,215,0,0.2)", duration: 0.5})
          .fromTo("#wave", 
            {drawSVG: "0% 0%", opacity: 1}, 
            {drawSVG: "0% 100%"}, "-=0.5")
          .to("#wave", 
            {fill: "rgba(79,195,247,0.2)", duration: 0.5});
        
        // 重播按钮
        document.getElementById("replay-btn").addEventListener("click", () => {
            tl.restart();
        });
    </script>
</body>
</html>
```

## 示例解析

1. **SVG路径**：我们创建了三个SVG路径 - 心形、星星和波浪线
2. **DrawSVG动画**：使用`drawSVG`属性从"0% 0%"动画到"0% 100%"来绘制路径
3. **时间线控制**：使用GSAP的时间线(timeline)来顺序播放动画
4. **额外效果**：路径绘制完成后添加填充色动画
5. **交互功能**：添加了重播按钮

这个示例展示了DrawSVG插件的基本用法，同时结合了GSAP的其他功能创建了一个美观、流畅的动画效果。你可以复制这段代码到HTML文件中直接运行查看效果。

要使用DrawSVG插件，记得在GSAP核心库之后引入DrawSVGPlugin，并且在使用前调用`gsap.registerPlugin(DrawSVGPlugin)`注册插件。