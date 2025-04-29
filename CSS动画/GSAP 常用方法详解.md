
GSAP 的核心对象 `gsap` 提供了多种创建和控制动画的方法。以下是主要方法及其使用示例：

## 1. `gsap.to()` - 创建从当前状态到目标状态的动画

```javascript
// 将元素从当前位置移动到x=100的位置，透明度变为0.5
gsap.to(".box", {
  duration: 1,       // 动画持续时间(秒)
  x: 100,           // 水平移动100px
  opacity: 0.5,     // 透明度变为0.5
  ease: "power2.out", // 使用缓动函数
  delay: 0.5,       // 延迟0.5秒开始
  onComplete: () => console.log("动画完成") // 动画完成回调
});
```

## 2. `gsap.from()` - 创建从指定状态到当前状态的动画

```javascript
// 元素从x=100, opacity=0的位置动画到当前状态
gsap.from(".element", {
  duration: 2,
  x: 100,
  opacity: 0,
  rotation: 360,   // 旋转360度
  ease: "bounce.out" // 弹跳效果
});
```

## 3. `gsap.fromTo()` - 创建从指定起始状态到指定结束状态的动画

```javascript
// 元素从x=0, opacity=0变化到x=200, opacity=1
gsap.fromTo(".target", 
  { x: 0, opacity: 0 },   // 起始状态
  { 
    duration: 1.5, 
    x: 200, 
    opacity: 1,
    stagger: 0.2 // 如果.target是多个元素，每个元素间隔0.2秒动画
  } // 结束状态
);
```

## 4. `gsap.set()` - 立即设置属性(无动画)

```javascript
// 立即设置元素位置和透明度(无动画过渡)
gsap.set(".item", {
  x: 50,
  y: 30,
  opacity: 0.8,
  scale: 1.2
});
```

## 5. `gsap.timeline()` - 创建时间轴序列

```javascript
// 创建时间轴实例
const tl = gsap.timeline({
  defaults: { duration: 0.8 } // 设置默认持续时间
});

// 添加动画到时间轴
tl.to(".box1", { x: 100 })          // 第一个动画
  .to(".box2", { y: 50 }, "<")      // 与上一个动画同时开始("<")
  .to(".box3", { rotation: 45 })    // 在上一个动画完成后开始
  .from(".box4", { opacity: 0 }, "+=0.5"); // 延迟0.5秒后开始
```

## 7. `gsap.getById()` - 通过ID获取动画实例

```javascript
// 创建动画并赋予ID
const anim = gsap.to(".logo", { 
  x: 100, 
  id: "logoAnimation" // 设置动画ID
});

// 通过ID获取动画
const sameAnim = gsap.getById("logoAnimation");
```

## 8. `gsap.registerPlugin()` - 注册插件

```javascript
// 注册ScrollTrigger插件
gsap.registerPlugin(ScrollTrigger);

// 使用注册后的插件
gsap.to(".section", {
  scrollTrigger: ".section", // 使用ScrollTrigger
  x: 100,
  duration: 1
});
```

## 9. `gsap.utils` 工具方法

```javascript
// 使用gsap.utils中的工具函数
const { mapRange, clamp, random } = gsap.utils;

// 将值从输入范围映射到输出范围
const mappedValue = mapRange(0, 100, 0, 1, 50); // 0.5

// 限制值在范围内
const clamped = clamp(0, 100, 150); // 100

// 生成随机数
const randomNum = random(5, 10); // 5到10之间的随机数
```

## 10. `gsap.effects` - 预定义动画效果(需先配置)

```javascript
// 配置自定义效果(通常在应用初始化时做)
gsap.effects.myFade = (target, config) => {
  return gsap.from(target, {
    opacity: 0,
    duration: config.duration || 1,
    ease: "power2.inOut",
    ...config
  });
};

// 使用自定义效果
gsap.effects.myFade(".header", { duration: 2 });
```

## 2. `gsap.context()` - 管理动画作用域(方便清理)

```javascript
// 创建动画上下文
const ctx = gsap.context(() => {
  gsap.to(".box", { x: 100 });
  gsap.to(".circle", { y: 50 });
}, ".container"); // 限定作用域为.container内

// 清理时会自动回收该上下文内的所有动画
button.addEventListener("click", () => ctx.revert());
```

## 4. `gsap.matchMedia()` - 响应式动画

```javascript
// 根据媒体查询条件创建响应式动画
gsap.matchMedia().add("(min-width: 800px)", () => {
  // 大屏幕动画
  gsap.to(".hero", { x: 100, duration: 1 });
  
  return () => { // 清理函数
    gsap.set(".hero", { x: 0 });
  };
}).add("(max-width: 799px)", () => {
  // 移动端动画
  gsap.to(".hero", { y: 50, duration: 0.5 });
});
```

## 5. `gsap.getProperty()` - 获取元素当前属性值

```javascript
// 获取元素当前的x变换值
const currentX = gsap.getProperty(".box", "x");

// 获取元素的计算宽度
const width = gsap.getProperty(".box", "width");

// 获取元素的内联样式值
const opacity = gsap.getProperty(".box", "opacity", "inline");
```

## 8. `gsap.registerEffect()` - 注册可复用动画效果

```javascript
// 注册名为"fadeSlide"的动画效果
gsap.registerEffect({
  name: "fadeSlide",
  effect: (targets, config) => {
    return gsap.from(targets, {
      opacity: 0,
      y: config.y || 50,
      duration: config.duration || 1,
      stagger: config.stagger || 0.1
    });
  },
  defaults: { y: 50 }, // 默认参数
  extendTimeline: true // 扩展到时间轴
});

// 使用方式
gsap.effects.fadeSlide(".item", { y: 100 });

// 如果在时间轴上使用(因为设置了extendTimeline)
const tl = gsap.timeline();
tl.fadeSlide(".header", { duration: 1.5 })
  .to(".content", { opacity: 1 });
```

## 10. `gsap.utils.toArray()` - 转换为数组

```javascript
// 将NodeList或类数组对象转换为真实数组
const boxes = gsap.utils.toArray(".box");

// 处理数组中的每个元素
boxes.forEach((box, i) => {
  gsap.to(box, {
    x: i * 50,
    duration: 1,
    delay: i * 0.2
  });
});

// selector text (returns the raw elements wrapped in an Array)
let targets = gsap.utils.toArray(".class");

// raw element/object
let targets = gsap.utils.toArray(myElement);

// Array of selector text (same result as ".class1, .class2")
let targets = gsap.utils.toArray([".class1", ".class2"]);

// Only descendant elements of myElement
let targets = gsap.utils.toArray(".class", myElement);

// 也可以指定上下文
const items = gsap.utils.toArray(".item", document.querySelector(".container"));
```

这些方法提供了更高级的动画控制和工具功能，特别是在处理复杂动画场景、性能优化和代码组织时非常有用。`gsap.context()` 和 `gsap.matchMedia()` 特别适合现代组件化开发和响应式设计，而 `gsap.quickTo()` 则能优化频繁触发的动画性能。
