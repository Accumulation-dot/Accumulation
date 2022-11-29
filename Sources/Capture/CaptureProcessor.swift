//
//  File.swift
//  
//
//  Created by Mario on 2022/9/30.
//

import Foundation
import Photos

/// 拍照类型
/// 可能根据学到的内容进行添加
/// 目前
public enum CapturePhotoType {

    /// 图片
    case jpeg

    /// LivePhoto 可能理解有偏差
    case hevc(fileURL: URL)

    /// 视频
    case video
}

/// LivePhoto信息
public struct LivePhotoInfo {

    /// 文件路径url
    var outputFileURL: URL

    /// 时间间隔
    var duration: CMTime

    /// 显示时间
    var photoDisplayTime: CMTime

    ///
    var photo: AVCapturePhoto?
}

/// 闭包
public typealias PhotoCaptureProcessorProgress = (CaptureProgress, AVCapturePhotoOutput, AVCaptureResolvedPhotoSettings?) -> Void

/// 进度 并不是每一个进度都会被涉及到
public enum CaptureProgress {

    /// 将要开始
    case willBegin

    /// 将要拍照
    case willCapture

    /// 已经拍照
    case didCapturePhoto

    /// 完成处理图片
    case didFinishProcessingPhoto(Result<AVCapturePhoto, Error>)

    /// 完成记录LivePhoto文件
    case didFinishRecordingLivePhotoMovieForEventualFile(URL)

    /// 完成处理LivePhoto文件
    case didFinishProcessingLivePhotoToMovieFile(Result<LivePhotoInfo, Error>)

    /// 最后完成操作
    case didFinishCapture(Data?, URL?)
}

public class CaptureProcessor: NSObject {
    var photoCaptureProgress: PhotoCaptureProcessorProgress?

    private var photo: AVCapturePhoto?

    private var data: Data?
    
    private var url: URL?
}


// MARK: - `PhotoCaptureProcessor: AVCapturePhotoCaptureDelegate`
extension CaptureProcessor: AVCapturePhotoCaptureDelegate {

    public func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        photoCaptureProgress?(.willBegin, output, resolvedSettings)
    }

    public func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        photoCaptureProgress?(.willCapture, output, resolvedSettings)
    }

    public func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        photoCaptureProgress?(.didCapturePhoto, output, resolvedSettings)
    }

    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let photoCaptureProgress = photoCaptureProgress else {
            return
        }
        let result: Result<AVCapturePhoto, Error>
        if let error = error {
            result = .failure(error)
        } else {
            result = .success(photo)
        }
        self.photo = photo
        data = photo.fileDataRepresentation()
        photoCaptureProgress(.didFinishProcessingPhoto(result), output, nil)
    }

    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishRecordingLivePhotoMovieForEventualFileAt outputFileURL: URL, resolvedSettings: AVCaptureResolvedPhotoSettings) {
        photoCaptureProgress?(.didFinishRecordingLivePhotoMovieForEventualFile(outputFileURL), output, resolvedSettings)
    }

    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingLivePhotoToMovieFileAt outputFileURL: URL, duration: CMTime, photoDisplayTime: CMTime, resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        guard let photoCaptureProgress = photoCaptureProgress else {
            return
        }
        let result: Result<LivePhotoInfo, Error>
        if let error = error {
            result = .failure(error)
        } else {
            result = .success(LivePhotoInfo(outputFileURL: outputFileURL,
                                            duration: duration,
                                            photoDisplayTime: photoDisplayTime,
                                            photo: photo))
        }
        url = outputFileURL
        photoCaptureProgress(.didFinishProcessingLivePhotoToMovieFile(result), output, resolvedSettings)
    }

    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        photoCaptureProgress?(.didFinishCapture(data, url), output, resolvedSettings)
        data = nil
        url = nil
    }
}
