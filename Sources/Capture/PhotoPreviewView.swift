//
//  File.swift
//  
//
//  Created by Mario on 2022/9/30.
//

import Foundation

#if canImport(UIKit) && canImport(Photos)
import UIKit
import Photos

/// 拍摄预览
public class PhotoPreviewView: UIView {

    /// 预览
    public override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    /// 获取layer
    public var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
}

#endif
