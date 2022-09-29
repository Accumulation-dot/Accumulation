//
//  AuthorizationManager.swift
//  
//
//  Created by Mario on 2022/9/28.
//

/// 授权管理
import Foundation

#if canImport(UIKit)

import UIKit

/// 权限管理
public struct AuthorizationManager {

    /// 单例
    public static let share = AuthorizationManager()

    /// 私有init
    private init() { }

    /// 取消操作
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - cancelHandler: 取消操作 flag true为取消调用
    /// - Returns: alertController
    public static func alert(title: String?, message: String?, cancelHandler: ((Bool) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "以后再说", style: .cancel, handler: { _ in
            cancelHandler?(true)
        }))

        alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
            cancelHandler?(false)
            let shared = UIApplication.shared
            guard let url = URL(string: UIApplication.openSettingsURLString), shared.canOpenURL(url) else {
                return
            }
            shared.open(url)
        }))
        return alert
    }
}

#endif
