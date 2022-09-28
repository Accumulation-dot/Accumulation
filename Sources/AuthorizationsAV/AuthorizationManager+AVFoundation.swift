//
//  AuthorizationManager+AVFoundation.swift
//  
//
//  Created by Mario on 2022/9/28.
//

#if canImport(AVFoundation)
import Foundation
import AVFoundation


extension AuthorizationManager {

    /// 查看录音的权限
    /// - Parameter completion: 查看权限或者授权结束的处理
    public func request(audio completion: @escaping (Bool) -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission(completion)
        case .denied:
            completion(false)
        case .granted:
            completion(true)
        @unknown default:
            completion(false)
        }
    }
}

#endif
