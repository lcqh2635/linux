import { createApp } from 'vue'
import App from '@/App.vue'
import router from "@/router";
import '@assets/styles/index.scss'

const app = createApp(App)

app.use(router)

// 等待路由准备就绪后再挂载应用
router.isReady().then(() => {
    // 路由初始化完成后挂载Vue根实例
    app.mount('#app')
})