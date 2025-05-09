// 权限守卫
import router from "../index.ts";

// 添加路由守卫
router.beforeEach(async (to, from, next) => {
    // 权限检查逻辑
})