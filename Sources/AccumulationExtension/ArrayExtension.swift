import Foundation

/// `Array` Extension
public extension Array {

    /// 根据数量进行分割
    func split(maxCount: Int) -> [[Element]] {
        // 不适用through 为了防止生成空数组
        stride(from: 0, to: count, by: maxCount).map {
            Array(self[$0..<$0 + Swift.min(maxCount, count - $0)])
        }
    }


    /// 去重
    /// - Parameter filter: 条件
    /// - Returns: 去重后的新数组
    func filterDuplicates<E: Equatable>(_ condition: (Element) -> E) -> [Element] {
        var result = [Element]()
        var keys = [E]()
        for value in self {
            let key = condition(value)
            if !keys.contains(key) {
                keys.append(key)
                result.append(value)
            }
        }
        return result
    }
}

public extension Array where Element: Equatable {
  func removeDuplicate() -> [Element] {
    enumerated().filter { (index, value) -> Bool in
      firstIndex(of: value) == index
    }.map { (_, value) in
      value
    }
  }
}
