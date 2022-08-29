//
//  Constants.swift
//  
//
//  Created by Mario on 2022/8/27.
//

#if os(iOS)

import Foundation
import CoreGraphics
import UIKit

public class Constants: NSObject {

    /// 获取 keyWindow
    public class var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let windowScenes = UIApplication.shared.connectedScenes.filter {
                $0.activationState == .foregroundActive && ($0 is UIWindowScene)
            } as? Set<UIWindowScene>
            return windowScenes?.first?.windows.filter {
                $0.isKeyWindow
            }.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    /// 屏幕size
    public class var screenSize: CGSize {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow else {
            return UIScreen.main.bounds.size
        }
        return window.bounds.size
    }

    /// 当前屏幕宽度
    public class var currentScreenWidth: CGFloat {
        screenSize.width
    }

    /// 当前屏幕高度
    public class var currentScreenHeight: CGFloat {
        screenSize.height
    }

}
#endif
