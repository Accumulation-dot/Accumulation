import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

public extension String {
    
    /// url编码
    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }

    /// 长度 与count 计算方式不同
    var length: Int {
        (self as NSString).length
    }

    /// encode后的url
    var urlEncodedUrl: URL? {
        URL(string: urlEncoded)
    }

    /// 转变为字符串
    var url: URL? {
        URL(string: self)
    }

    /// 参数
    var urlParameters: [String: Any] {
        let target = [String: Any]()
        guard let components = URLComponents(string: self), let items = components.queryItems else {
            return target
        }
        return items.reduce(into: target) { result, item in
            result[item.name] = item.value
        }
    }

    /// 获取range
    func nsRanges(of content: String, options mask: NSString.CompareOptions = []) -> [NSRange] {
        (self as NSString).ranges(of: content, options: mask)
    }

    /// 所有包含content 的Range
    func rangesOf(_ content: String) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        guard !isEmpty, !content.isEmpty, count > content.count else {
            return ranges
        }
        var searchRange = startIndex..<endIndex
        var range = range(of: content, range: searchRange)
        while !searchRange.isEmpty, let temp = range {
            ranges.append(temp)
            searchRange = index(startIndex, offsetBy: distance(from: startIndex, to: temp.upperBound))..<endIndex
            range = self.range(of: content, range: searchRange)
        }
        return ranges
    }
}
