#if os(iOS)

import UIKit

@available(iOS 10, *)
public extension UIView {

    /// 截图
    var captured: UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image {
            layer.render(in: $0.cgContext)
        }
    }

    /// 清空所有
    func clear() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    /// 移除符合条件的View
    /// - Parameter condition: 条件表达式
    func clear(condition: (UIView) throws -> Bool) rethrows {
        try subviews.forEach {
            if try condition($0) {
                $0.removeFromSuperview()
            }
        }
    }
}

#endif
