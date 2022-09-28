//
//  AuthorizationManager+PHPhotoLibrary.swift
//  
//
//  Created by Mario on 2022/9/28.
//

#if canImport(Photos)
import Photos

public enum Authorization {

    /// 添加
    case write

    /// 存储和读取
    case readWrite

    @available(iOS 14.0, *)
    var access: PHAccessLevel {
        switch self {
        case .write:
            return .addOnly
        case .readWrite:
            return .readWrite
        }
    }
}

public enum AuthorizationResult {

    /// 默认
    case none

    /// 允许
    case allow

    /// 不允许
    case deny

    /// 部分权限
    case limited
}

extension PHAuthorizationStatus {

    /// 结果转换
    var authorizationResult: AuthorizationResult {
        switch self {
        case .notDetermined:
            return .none
        case .restricted, .denied:
            return .deny
        case .authorized:
            return .allow
        case .limited:
            return .limited
        @unknown default:
            return .deny
        }
    }
}


extension AuthorizationManager {

    /// 请求
    /// - Parameters:
    ///   - authorization: 请求哪些权限
    ///   - complection: 权限请求之后的结果
    public func request(authorization: Authorization, complection: @escaping (AuthorizationResult) -> Void) {
        let resultHandler: (PHAuthorizationStatus) -> Void = {
            let status = $0
            DispatchQueue.main.async {
                complection(status.authorizationResult)
            }
        }
        let status: PHAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = PHPhotoLibrary.authorizationStatus(for: authorization.access)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        switch status {
        case .notDetermined:
            if #available(iOS 14.0, *) {
                PHPhotoLibrary.requestAuthorization(for: authorization.access, handler: resultHandler)
            } else {
                PHPhotoLibrary.requestAuthorization(resultHandler)
            }
        default:
            resultHandler(status)
        }
    }
}

#endif
