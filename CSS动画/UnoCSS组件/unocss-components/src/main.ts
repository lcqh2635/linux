import { createApp } from 'vue'
import App from '@/App.vue'
import '@assets/styles/index.scss'
import '@unocss/reset/tailwind.css'
import router from "@/router";
import pinia from "@/stores";

const app = createApp(App)

app.use(router)
app.use(pinia)

// 等待路由准备就绪后再挂载应用
router.isReady().then(() => {
    // 路由初始化完成后挂载Vue根实例
    app.mount('#app')
})