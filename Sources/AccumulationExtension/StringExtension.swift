import Foundation

#if !os(macOS)
import UIKit

public extension String {
    /// url编码
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    /// 生成二维码
    /// - Parameters:
    ///   - icon: 中心icon
    ///   - size: 图片大小
    /// - Returns: 二维码图片
    @available(iOS 10.0, *)
    func qrCode(_ icon: UIImage? = nil, size: CGFloat = 60) -> UIImage? {
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
