//
//  UIVisualEffectView+Extension.swift
//  
//
//  Created by Mario on 2022/8/30.
//
#if os(iOS)
import UIKit

/// typealias: UIBlurEffect.Style
public typealias UIBlurEffectStyle = UIBlurEffect.Style

/// UIVisualEffectView 扩展
public extension UIVisualEffectView {

  /// 初始化
  /// - Parameter effectStyle: 模糊效果

  /// blur 初始化
  /// - Parameter effect: 模糊效果 样式
  convenience init(blur effect: UIBlurEffectStyle) {
    self.init(effect: UIBlurEffect(style: effect))
  }

  /// vibrancy 初始化
  /// - Parameter effect: 模糊效果 样式
  convenience init(vibrancy effect: UIBlurEffectStyle) {
    self.init(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: effect)))
  }


  @available(iOS 13.0, *)
  /// vibrancy 初始化
  /// - Parameters:
  ///   - effect: 模糊效果 样式
  ///   - style: UIVibrancyEffectStyle 样式
  convenience init(vibrancy effect: UIBlurEffectStyle, style: UIVibrancyEffectStyle) {
    self.init(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: effect), style: style))
  }
}
#endif
