import Foundation
import CoreGraphics

/// 提供Optional 扩展
public extension Optional where Wrapped: Collection {

    /// 判断是否为空
    var isEmpty: Bool {
        switch self {
            case .none:
                return true
            case .some(let wrapped):
                return wrapped.isEmpty
        }
    }

    /// 获取数量
    var count: Int {
        switch self {
            case .none:
                return .zero
            case .some(let wrapped):
                return wrapped.count
        }
    }
}

/// 为空态值提供
public extension Optional where Wrapped: AdditiveArithmetic {

    /// 解包值
    var wrapped: Wrapped {
        self ?? .zero
    }
}

public extension Optional where Wrapped == CGPoint {
    var wrapped: Wrapped {
        self ?? .zero
    }
}

public extension Optional where Wrapped == CGSize {
    var wrapped: Wrapped {
        self ?? .zero
    }
}

public extension Optional where Wrapped == CGRect {
    var wrapped: Wrapped {
        self ?? .zero
    }
}

public extension Optional where Wrapped == Date {
    var wrapped: Wrapped {
        self ?? .zero
    }
}

public extension Optional where Wrapped == String {
    var wrapped: Wrapped {
        self ?? ""
    }
}


