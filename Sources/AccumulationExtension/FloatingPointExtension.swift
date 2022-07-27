//
//  FloatingPointExtension.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import Foundation

public extension FloatingPoint {
    /// ceil
    var ceil: Self {
        rounded(.up)
    }

    /// floor
    var floor: Self {
        rounded(.down)
    }

    /// 趋于0
    var trunc: Self {
        rounded(.towardZero)
    }

    /// 四舍五入
    var rounded: Self {
        rounded(.toNearestOrAwayFromZero)
    }

    ///  远离0的
    var awayFromZero: Self {
        rounded(.awayFromZero)
    }

    ///     (5.2).rounded(.toNearestOrEven)
    ///     // 5.0
    ///     (5.5).rounded(.toNearestOrEven)
    ///     // 6.0
    ///     (4.5).rounded(.toNearestOrEven)
    ///     // 4.0
    var nearestOrEven: Self {
        rounded(.toNearestOrEven)
    }

    /// 判断是否是偶数
    var isEven: Bool {
        truncatingRemainder(dividingBy: Self(2)) == .zero
    }
}
