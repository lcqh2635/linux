import type { AxiosRequestConfig } from 'axios'

/**
 * 带分页的请求参数
 */
export interface PaginationParams {
    page?: number
    pageSize?: number
}

/**
 * 分页响应数据
 */
export interface PaginationResponse<T = any> {
    items: T[]
    total: number
    page: number
    pageSize: number
}

/**
 * 基础API响应格式
 */
export interface BaseResponse<T = any> {
    code: number
    data: T
    message?: string
}

/**
 * 自定义请求配置
 */
export interface CustomRequestConfig extends AxiosRequestConfig {
    /**
     * 是否显示全局loading
     * @default true
     */
    showLoading?: boolean

    /**
     * 是否显示错误提示
     * @default true
     */
    showError?: boolean

    /**
     * 是否跳过拦截器处理
     * @default false
     */
    skipInterceptors?: boolean
}