/// <reference types="vite/client" />

// env.d.ts 是 TypeScript 的类型声明文件，专门用于为环境变量提供类型支持
// 使用统一前缀（如 VITE_ 或 VUE_APP_）保持与 .env 文件中的变量名完全一致
// 自定义环境变量的 TypeScript 智能提示，参考 vite 文档  https://cn.vitejs.dev/guide/env-and-mode.html#intellisense
interface ImportMetaEnv {
    /**
     * 应用API基础地址
     * @example 'https://api.example.com'
     */
    readonly VITE_API_BASE_URL: string

    /**
     * 是否启用分析工具
     * @default 'false'
     */
    readonly VITE_ENABLE_ANALYTICS: 'true' | 'false'

    /**
     * Google Maps API密钥
     */
    readonly VITE_GOOGLE_MAPS_KEY?: string

    // 更多环境变量...
}

interface ImportMeta {
    readonly env: ImportMetaEnv
}