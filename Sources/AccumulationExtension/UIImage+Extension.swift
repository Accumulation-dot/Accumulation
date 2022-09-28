#if os(iOS)
import UIKit

public enum QRInputCorrectionLevel: String {
    case M
    case H
    case L
}

public protocol QRImageProtocol {
    
    var data: Data? { get }
    
    var inputCorrectionLevel: QRInputCorrectionLevel { get }
    
    var icon: UIImage? { get }
    
    func filter(image: CIImage) -> CIFilter?
    
    var size: CGFloat { get }
    
    var interpolationQuality: CGInterpolationQuality { get }
}

public extension QRImageProtocol {
    
    var inputCorrectionLevel: QRInputCorrectionLevel {
        .M
    }
    
    var icon: UIImage? {
        nil
    }
    
    func filter(image: CIImage) -> CIFilter? {
        nil
    }
    
    var size: CGFloat {
        60
    }
    
    var interpolationQuality: CGInterpolationQuality { .default }
    
}

public struct QRImageStruct {
    
    var content: String
    
    var level: QRInputCorrectionLevel = .M
    
    var iconImage: UIImage?
    
    var theme: (UIColor, UIColor)?
    
    var quality: CGInterpolationQuality = .default
}

public extension QRImageStruct {
    var data: Data? {
        content.data(using: .utf8, allowLossyConversion: true)
    }
    
    var inputCorrectionLevel: QRInputCorrectionLevel {
        level
    }
    
    var icon: UIImage? { iconImage }
    
    func filter(image: CIImage) -> CIFilter? {
        guard let theme = theme else {
            return nil
        }
        let filter = CIFilter(name: "CIFalseColor")
        filter?.setDefaults()
        filter?.setValue(image, forKey: "inputImage")
        filter?.setValue(theme.0.cgColor, forKey: "inputColor0")
        filter?.setValue(theme.1.cgColor, forKey: "inputColor1")
        return filter
    }
    
    var interpolationQuality: CGInterpolationQuality { quality }
}

@available(iOS 10.0, *)
public extension UIImage {
    
    /// 生成二维码
    /// - Parameter qr: 二维码协议
    /// - Returns: 图片
    static func image(from qr: QRImageProtocol) -> UIImage? {
        guard let data = qr.data else {
            return nil
        }
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue(qr.inputCorrectionLevel.rawValue, forKey: "inputCorrectionLevel")
        
        guard let image = filter?.outputImage else {
            return nil
        }
        let qrImage = UIImage(ciImage: image)
        guard let filtered = qr.filter(image: image),
              let icon = filtered.outputImage else {
            return qrImage.resize(qr.size)
        }
        let width = qr.size
        let resize = CGSize(same: width)
        let iconSize = width * 0.25
        let origin = width * 0.75 * 0.5
        return UIGraphicsImageRenderer(size: resize).image { context in
            context.cgContext.interpolationQuality = .default
            qrImage.draw(in: CGRect(origin: .zero, size: resize))
            UIImage(ciImage: icon).draw(in: CGRect(origin: CGPoint(same: origin), size: CGSize(same: iconSize)))
        }
    }
    
    /// 生成二维码
    /// - Parameters:
    ///   - data: 数据
    ///   - level: 纠错 `inputCorrectionLevel`
    /// - Returns: image
    static func image(from data: Data, level: QRInputCorrectionLevel = .M) -> UIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        guard let filter = filter else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue(level.rawValue, forKey: "inputCorrectionLevel")
        guard let image = filter.outputImage else {
            return nil
        }
        return UIImage(ciImage: image)
    }
    
    /// 缩放图片
    /// - Parameters:
    ///   - rate: 缩放比例
    ///   - quality: 质量
    /// - Returns: 缩放后图片
    func scale(_ rate: CGFloat, quality: CGInterpolationQuality = .default) -> UIImage {
        let rate = size.rated(rate)
        return UIGraphicsImageRenderer(size: rate).image { context in
            context.cgContext.interpolationQuality = quality
            self.draw(in: CGRect(origin: .zero, size: rate))
        }
    }
    
    /// 根据大小生成图片
    /// - Parameters:
    ///   - val: 宽 = 高 = val
    ///   - quality: 质量
    /// - Returns: 图片
    func resize(_ val: CGFloat, quality: CGInterpolationQuality = .default) -> UIImage {
        let resize = CGSize(width: val, height: val)
        return UIGraphicsImageRenderer(size: resize).image { context in
            context.cgContext.interpolationQuality = quality
            self.draw(in: CGRect(origin: .zero, size: resize))
        }
    }
}

extension String {
    /// 生成二维码
    /// - Parameters:
    ///   - icon: 中心icon
    ///   - size: 图片大小
    /// - Returns: 二维码图片
    @available(iOS 10.0, *)
    public func qrCode(_ icon: UIImage? = nil, size: CGFloat = 60) -> UIImage? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        guard let image = UIImage.image(from: data) else {
            return nil
        }
        guard let icon = icon else {
            return image.resize(size)
        }
        let iconSize = size * 0.25
        let origin = size * 0.75 * 0.5
        return UIGraphicsImageRenderer(size: CGSize(same: size)).image { context in
            context.cgContext.interpolationQuality = .default
            image.draw(in: CGRect(origin: .zero, size: CGSize(same: size)))
            icon.draw(in: CGRect(origin: CGPoint(same: origin), size: CGSize(same: iconSize)))
        }
    }
}

#endif
