//
//  AuthorizationManager.swift
//  
//
//  Created by Mario on 2022/9/28.
//

/// 授权管理
import Foundation
import UIKit

public struct AuthorizationManager {

    static let share = AuthorizationManager()

    private init() { }

    public func alert(title: String?, message: String?, cancelHandler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "以后再说", style: .cancel, handler: { _ in
            cancelHandler?()
        }))

        alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
            let shared = UIApplication.shared
            guard let url = URL(string: UIApplication.openSettingsURLString), shared.canOpenURL(url) else {
                return
            }
            shared.open(url)
        }))
        return alert
    }
}
