import { createApp } from 'vue'
import App from '@/App.vue'
import '@assets/styles/main.scss'
import '@unocss/reset/tailwind.css'
import router from "@/router";
import pinia from "@/stores";
import {i18n} from "@/locales";
// UnoCSS样式
import 'virtual:uno.css'

const app = createApp(App)

app.use(router)
app.use(pinia)
app.use(i18n)

// 等待路由准备就绪后再挂载应用
router.isReady().then(() => {
    // 路由初始化完成后挂载Vue根实例
    app.mount('#app')
})