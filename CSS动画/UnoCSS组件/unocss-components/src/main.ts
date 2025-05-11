import { createApp } from 'vue'
import '@assets/styles/index.scss'
import App from '@/App.vue'
import router from "@/router";

const app = createApp(App)

app.use(router)

router.isReady().then(() => {
    app.mount('#app')
})