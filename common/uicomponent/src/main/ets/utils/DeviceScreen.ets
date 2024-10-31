/**
 * 获取窗口宽度(实时)
 */
export function getWindowWidth() {
    return AppStorage.get<number>('windowWidth') || 360
}

/**
 * 获取窗口高度(实时)
 */
export function getWindowHeight() {
    return AppStorage.get<number>('windowHeight') || 780
}

/**
 * 将元素按照原来比例进行转化
 */
export function rvp(val: number): number {
    // 设计稿与模拟器的固定值360
    return val / 360 * getWindowWidth()
}