#if os(macOS)
import Foundation
public typealias EdgeInsets = NSEdgeInsets
#else
import UIKit
public typealias EdgeInsets = UIEdgeInsets
#endif

import CoreGraphics
public extension EdgeInsets {

    /// 相对Size
    var relativeSize: CGSize {
        .init(width: relativeWidth, height: relativeHeight)
    }

    /// 相对宽度
    var relativeWidth: CGFloat {
        self.left + self.right
    }

    /// 相对高度
    var relativeHeight: CGFloat {
        top + bottom
    }
}
