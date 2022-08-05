import Foundation


/// 返回满足条件的返回值
/// - Throws: 跑出异常
/// - Returns: 返回结果
public func value<T>(expected: @autoclosure () throws -> T, alternation: @autoclosure () throws -> T, satisfied: () -> Bool) rethrows -> T {
    guard satisfied() else {
        return try alternation()
    }
    return try expected()
}
