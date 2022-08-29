//
//  File.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import CoreGraphics

/// CGSize 扩展
public extension CGSize {

    /// 初始化方法
    /// - Parameter value: 宽 = 高 = value
    init(same value: CGFloat) {
        self.init(width: value, height: value)
    }

    /// 初始化方法
    /// - Parameter value: 宽 = 高 = value
    init(same value: Int) {
        self.init(width: value, height: value)
    }

    /// 初始化方法
    /// - Parameter value: 宽 = 高 = value
    init(same value: Double) {
        self.init(width: value, height: value)
    }

    /// 进行缩放
    /// - Parameter value: 缩放比例
    /// - Returns: 缩放后的值
    func rated(_ value: CGFloat) -> CGSize {
        CGSize(width: width * value, height: height * value)
    }

    /// 对当前值进行缩放
    /// - Parameter value: 缩放比例
    mutating func rate(_ value: CGFloat) {
        width = width * value
        height = height * value
    }

    /// 宽高比
    var ratio: CGFloat {
        guard height != .zero else {
            return .nan
        }
        return width / height
    }
}
