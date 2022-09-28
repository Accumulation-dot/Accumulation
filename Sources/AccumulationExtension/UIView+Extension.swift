#if os(iOS)

import UIKit

public extension UIView {

    /// 截图
    @available(iOS 10, *)
    var captured: UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image {
            layer.render(in: $0.cgContext)
        }
    }

    /// 清空所有
    func subviewsClearAll() {
        subviewsClear { _ in
            true
        }
    }

    /// 移除符合条件的View
    /// - Parameter condition: 条件表达式
    func subviewsClear(_ condition: (UIView) throws -> Bool) rethrows {
        try subviews.forEach {
            if try condition($0) {
                $0.removeFromSuperview()
            }
        }
    }

    enum ViewPropertyEnum {

        /// 背景色
        case backgroundColor(UIColor?)

        /// 是否隐藏
        case isHidden(Bool)

        /// 透明度
        case alhpa(CGFloat)

        /// tint颜色
        case tintColor(UIColor?)

        /// tint模式
        case tintAdjustmentMode(UIView.TintAdjustmentMode)

        /// tag值
        case tag(Int)

        ///
        case contentMode(UIView.ContentMode)

        /// mask
        case mask(UIView?)

        /// margin
        @available(iOS 8.0, *)
        case layoutMargins(UIEdgeInsets)
    }

    /// 更新属性
    /// - Parameter property: view属性
    func updateProperty(_ property: ViewPropertyEnum) {
        switch property {
        case .backgroundColor(let value):
            backgroundColor = value
        case .isHidden(let value):
            isHidden = value
        case .alhpa(let value):
            alpha = value
        case .tintColor(let value):
            tintColor = value
        case .tintAdjustmentMode(let value):
            tintAdjustmentMode = value
        case .tag(let value):
            tag = value
        case .contentMode(let value):
            contentMode = value
        case .mask(let value):
            mask = value
        case .layoutMargins(let value):
            layoutMargins = value
        }
    }

    /// 更新属性数组
    /// - Parameter properies: 属性数组
    func updateProperties(_ properies: [ViewPropertyEnum]) {
        properies.forEach {
            updateProperty($0)
        }
    }
}

public extension UIStackView {

    /// 移除符合条件的arrangedSubView
    /// - Parameter condition: 条件表达式
    func arrangedSubViewsClear(_ condition: (UIView) throws -> Bool) rethrows {
        try arrangedSubviews.forEach {
            if try condition($0) {
                $0.removeFromSuperview()
            }
        }
    }

    /// 全部移除
    func arrangedSubViewsClearAll() {
        arrangedSubViewsClear { _ in
            true
        }
    }
}


public extension UILabel {
    enum LabelPropertyEnum {
        case text(String?)
        case textColor(UIColor?)
        case font(UIFont?)
        case attributedText(NSAttributedString?)
        case textAlignment(NSTextAlignment)
        case lineBreakMode(NSLineBreakMode)
        case lineBreakStrategy(NSParagraphStyle.LineBreakStrategy)
        case isEnabled(Bool)
        case shadowColor(UIColor?)
        case shadowOffset(CGSize)
        case isUserInteractionEnabled(Bool)
        case isHighlighted(Bool)
        case highlightedTextColor(UIColor?)
        case numberOfLines(Int)
        case adjustsFontSizeToFitWidth(Bool)
        case baselineAdjustment(UIBaselineAdjustment)
        case minimumScaleFactor(CGFloat)
        case allowsDefaultTighteningForTruncation(Bool)
        case preferredMaxLayoutWidth(CGFloat)

    }

    /// 更新单个属性
    /// - Parameter property: 属性
    func updateProperty(_ property: LabelPropertyEnum) {
        switch property {
        case .text(let value):
            text = value
        case .textColor(let value):
            textColor = value
        case .font(let value):
            font = value
        case .attributedText(let value):
            attributedText = value
        case .textAlignment(let value):
            textAlignment = value
        case .lineBreakMode(let value):
            lineBreakMode = value
        case .lineBreakStrategy(let value):
            lineBreakStrategy = value
        case .isEnabled(let value):
            isEnabled = value
        case .shadowColor(let value):
            shadowColor = value
        case .shadowOffset(let value):
            shadowOffset = value
        case .isUserInteractionEnabled(let value):
            isUserInteractionEnabled = value
        case .isHighlighted(let value):
            isHighlighted = value
        case .highlightedTextColor(let value):
            highlightedTextColor = value
        case .numberOfLines(let value):
            numberOfLines = value
        case .adjustsFontSizeToFitWidth(let value):
            adjustsFontSizeToFitWidth = value
        case .baselineAdjustment(let value):
            baselineAdjustment = value
        case .minimumScaleFactor(let value):
            minimumScaleFactor = value
        case .allowsDefaultTighteningForTruncation(let value):
            allowsDefaultTighteningForTruncation = value
        case .preferredMaxLayoutWidth(let value):
            preferredMaxLayoutWidth = value
        }
    }

    /// 更新属性数组
    /// - Parameter properies: 属性数组
    func updateProperties(_ properies: [LabelPropertyEnum]) {
        properies.forEach {
            updateProperty($0)
        }
    }
}

/// 创建view
public func create<T: UIView>(view config: (T) -> Void) -> T {
    let t = T()
    config(t)
    return t
}

public func lineView(color: UIColor) -> UIView {
    create { view in
        view.backgroundColor = color
    }
}

#endif
