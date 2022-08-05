//
//  File.swift
//  
//
//  Created by Mario on 2022/8/5.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// 连体属性类型
public enum LigatureType: Int {

    /// 无连体
    case zero = 0

    /// 默认
    case `default` = 1
}

/// WritingDirection
public enum WritingDirectionType: Int {

    /// left to right with Embedding
    case lre = 0

    /// right to left with Embedding
    case rle = 1

    /// left to right with override
    case lro = 2

    /// right to left with override
    case rlo = 3
}

public enum StringAttributedType {

    /// 附加
    case attachment(NSTextAlignment)

    /// 背景色
    case backgroundColor(AColor)

    /// 设置基线偏移值
    case baselineOffset(CGFloat)

    /// 字体的横向拉伸
    case expansion(CGFloat)

    /// 字体
    case font(AFont)

    /// 前景色
    case foregroundColor(AColor)

    /// 字距
    case kern(CGFloat)

    /// 连体属性
    case ligature(LigatureType)

    /// 链接
    case link(NSURL)

    /// 倾斜度
    case obliqueness(CGFloat)

    /// 段落
    case paragraphStyle(NSParagraphStyle)

    /// 阴影
    case shadow(NSShadow?)

    /// 删除线颜色
    case strikethroughColor(AColor)

    /// 删除线样式
    case strikethroughStyle(NSUnderlineStyle)

    /// 笔刷颜色
    case strokeColor(AColor)

    /// 笔画的宽度
    case strokeWidth(CGFloat)

    /// 字体特殊效果
    case textEffect(String?)

    /// 下划线
    case underlineColor(AColor)

    /// 下划线样式
    case underlineStyle(NSUnderlineStyle)

    /// 设置文字的书写方向
    case writingDirection([WritingDirectionType])

    ///
    var value: [NSAttributedString.Key: Any] {
        switch self {
        case .attachment(let file):
            return [.attachment: file]
        case .font(let font):
            return [.font: font]
        case .backgroundColor(let color):
            return [.backgroundColor: color]
        case .baselineOffset(let offset):
            return [.baselineOffset: offset]
        case .expansion(let expansion):
            return [.expansion: expansion]
        case .foregroundColor(let color):
            return [.foregroundColor: color]
        case .kern(let kern):
            return [.kern: kern]
        case .ligature(let ligatureType):
            return [.ligature: ligatureType.rawValue]
        case .link(let url):
            return [.link: url]
        case .obliqueness(let obliqueness):
            return [.obliqueness: obliqueness]
        case .paragraphStyle(let paragraphStyle):
            return [.paragraphStyle: paragraphStyle]
        case .shadow(let shadow):
            if let shadow = shadow {
                return [.shadow: shadow]
            }
        case .strikethroughColor(let color):
            return [.strikethroughColor: color]
        case .strikethroughStyle(let underlineStyle):
            return [.strikethroughStyle: underlineStyle.rawValue]
        case .strokeColor(let color):
            return [.strokeColor: color]
        case .strokeWidth(let width):
            return [.strokeWidth: width]
        case .textEffect(let textEffect):
            if let textEffect = textEffect {
                return [.textEffect: textEffect]
            }
        case .writingDirection(let direction):
            if !direction.isEmpty {
                return [.writingDirection: direction.map { $0.rawValue }]
            }
        case .underlineColor(let color):
            return [.underlineColor: color]
        case .underlineStyle(let style):
            return [.underlineStyle: style.rawValue]
        }
        return [:]
    }
}

/// String Extension
public extension String {

    /// 根据参数转富文本
    /// - Parameter attributes: 富文本属性
    /// - Returns: 富文本
    func attributedString(_ attributes: [StringAttributedType]) -> NSAttributedString {
        let result = attributes.reduce([:]) { x, y in
            x.merging(y.value) { pre, suffix in
                suffix
            }
        }
        return NSAttributedString(string: self, attributes: result)
    }
}
