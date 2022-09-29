//
//  AuthorizationManager+AVFoundation.swift
//  
//
//  Created by Mario on 2022/9/28.
//

#if canImport(AVFoundation)
import AuthorizationsCore
import AVFoundation


extension AuthorizationManager {

    /// 查看录音的权限
    /// - Parameter completion: 查看权限或者授权结束的处理
    public func permission(audio completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission(completion)
    }
}

#endif
