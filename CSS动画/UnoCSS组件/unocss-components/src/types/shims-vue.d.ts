/*
 * 类型声明文件（.d.ts）
 * 作用：让 TypeScript 识别 .vue 文件模块
 *
 * 注意：
 * 1. 此文件不需要手动导入，TypeScript会自动加载
 * 2. 文件名通常固定为 shims-vue.d.ts
 */

// 声明一个模块，用于匹配所有以 ".vue" 结尾的文件，并将其识别为一个 Vue 组件
declare module '*.vue' {
    // 从 "vue" 中导入 DefineComponent 类型
    import type { DefineComponent } from 'vue'
    // 定义一个类型为 DefineComponent 的变量 component
    // 它具有三个泛型参数，分别表示组件的 props、组件的 data 和其他的类型。
    // 在这里，我们使用空对象（{}）表示没有 props，使用空对象（{}）表示没有 data，使用 any 表示其他类型可以是任意值。
    const component: DefineComponent<{}, {}, any>
    // 默认导出
    // import Doc from '../doc.md'  // 直接导入默认导出，Doc 就是 component
    export default component
}
// 新增 Markdown 模块声明（作为 Vue 组件，可以像普通 Vue 组件一样使用 ）
declare module '*.md' {
    import type { DefineComponent } from 'vue'
    const component: DefineComponent<{}, {}, any>
    // 命名导出
    // import { component as Doc } from '../doc.md'  // 必须解构命名导出
    export { component }
    // export default component
}


// 声明自定义文件格式
declare module '*.yaml' {
    const data: Record<string, any>
    export default data
}
declare module '*.json5' {
    const data: Record<string, any>
    export default data
}


// 声明图片等静态资源模块
declare module '*.png';
declare module '*.jpg';
declare module '*.jpeg';
declare module '*.gif';
declare module '*.svg';
declare module '*.ico';
declare module '*.webp';