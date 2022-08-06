#if os(iOS)

import UIKit

public extension UIView {

    /// 截图
    @available(iOS 10, *)
    var captured: UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image {
            layer.render(in: $0.cgContext)
        }
    }

    /// 清空所有
    func subviewsClearAll() {
        subviewsClear { _ in
            true
        }
    }

    /// 移除符合条件的View
    /// - Parameter condition: 条件表达式
    func subviewsClear(_ condition: (UIView) throws -> Bool) rethrows {
        try subviews.forEach {
            if try condition($0) {
                $0.removeFromSuperview()
            }
        }
    }
}

public extension UIStackView {

    /// 移除符合条件的arrangedSubView
    /// - Parameter condition: 条件表达式
    func arrangedSubViewsClear(_ condition: (UIView) throws -> Bool) rethrows {
        try arrangedSubviews.forEach {
            if try condition($0) {
                $0.removeFromSuperview()
            }
        }
    }

    /// 全部移除
    func arrangedSubViewsClearAll() {
        arrangedSubViewsClear { _ in
            true
        }
    }
}

#endif
