//
//  NSString+Extension.swift
//  
//
//  Created by Mario on 2022/8/29.
//

import Foundation

/// NSString 扩展
public extension NSString {

    /// 是否为空
    var isEmpty: Bool {
        length == .zero
    }

    /// 搜索子字符串在当前的range
    /// - Parameter content: 字符串
    /// - Parameter mask: 匹配方式
    /// - Returns: NSRange的集合
    func ranges(of content: String, options mask: NSString.CompareOptions = []) -> [NSRange] {
        var ranges: [NSRange] = []
        guard !isEmpty, !content.isEmpty, content.length < length else {
            return ranges
        }
        var searchRange = NSRange(location: .zero, length: length)
        var result = range(of: content, options: mask, range: searchRange)
        while result.location != NSNotFound {
            ranges.append(result)
            let end = result.upperBound
            searchRange = NSRange(location: end, length: length - end)
            result = range(of: content, options: mask, range: searchRange)
        }
        return ranges
    }
}
