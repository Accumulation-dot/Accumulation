import Foundation

public extension BinaryInteger {

    /// 是否为偶数
    var isEven: Bool {
        isMultiple(of: Self(2))
    }
}
