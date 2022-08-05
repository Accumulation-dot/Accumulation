import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

public extension String {
    /// url编码
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
