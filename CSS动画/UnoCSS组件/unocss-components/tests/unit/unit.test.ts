// 单元测试（Vitest）参考官方文档 https://cn.vitest.dev/
import { expect, test } from 'vitest'

// biome-ignore lint/suspicious/noExportsInTest: <explanation>
export function sum(a, b) {
    return a + b
}

test('adds 1 + 2 to equal 3', () => {
    expect(sum(1, 2)).toBe(3)
})