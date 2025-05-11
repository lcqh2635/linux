// 认证相关路由
import type { AppRouteRecordRaw } from '../types'
import { RouteNames } from '../constants'

/**
 * 认证相关路由
 */
const authRouter: AppRouteRecordRaw[] = [
    {
        path: '/login',
        name: RouteNames.LOGIN,
        component: () => import('@/views/auth/Login.vue'),
        meta: {
            title: '登录',
            hidden: true // 不在菜单显示
        }
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import('@/views/auth/Register.vue'),
        meta: {
            title: '注册',
            hidden: true
        }
    }
]

export default authRouter