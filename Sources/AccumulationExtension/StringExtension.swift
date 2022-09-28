import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

public extension String {

    /// 空白字符串
    static let empty = ""

    /// 空格
    static let blank = " "
    
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

    /// 拼音
    var phoneticAlphabet: String {
        guard !isEmpty else {
            return .empty
        }
        let origin = NSMutableString(string: self)
        CFStringTransform(origin, nil, kCFStringTransformToLatin, false)
        CFStringTransform(origin, nil, kCFStringTransformStripDiacritics, false)
        return String(origin).trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: Self.blank, with: Self.empty)
    }

    /// 拼音
    func phoneticAlphabet(_ isTrimming: Bool, isBlankRemoved: Bool) -> String {
        guard !isEmpty else {
            return .empty
        }
        let origin = NSMutableString(string: self)
        CFStringTransform(origin, nil, kCFStringTransformToLatin, false)
        CFStringTransform(origin, nil, kCFStringTransformStripDiacritics, false)
        var result = String(origin)
        if isTrimming {
            result = result.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if isBlankRemoved {
            result = result.replacingOccurrences(of: Self.blank, with: Self.empty)
        }
        return result
    }

}
