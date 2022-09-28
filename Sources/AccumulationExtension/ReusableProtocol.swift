import Foundation

public protocol ReusableProtocol { }

extension ReusableProtocol {

    /// 重用标识
    static var reusedIdentifier: String { "\(self)" }
}

#if os(iOS)
import UIKit

// MARK: - `UITableViewHeaderFooterView`: `ReusableProtocol`
extension UITableViewCell: ReusableProtocol { }

// MARK: - `UITableViewHeaderFooterView`: `ReusableProtocol`
extension UITableViewHeaderFooterView: ReusableProtocol { }

// MARK: - `UICollectionReusableView`: `ReusableProtocol`
extension UICollectionReusableView: ReusableProtocol { }

// MARK: - `UITableView`
public extension UITableView {

    /// 注册cell
    func register<T>(cell type: T.Type) where T: UITableViewCell {
        register(type, forCellReuseIdentifier: T.reusedIdentifier)
    }

    /// 注册header/footer
    func register<T>(headerFooter type: T.Type) where T: UITableViewHeaderFooterView {
        register(type, forHeaderFooterViewReuseIdentifier: T.reusedIdentifier)
    }

    /// 获取cell
    /// - Returns: 类型转换后的cell
    func dequeueReusable<T>(cell type: T) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusedIdentifier) as? T else {
            fatalError("Please register UITableViewCell before use")
        }
        return cell
    }

    /// 重用获取cell
    /// - Returns: `T: UITableViewCell`
    func dequeueReusable<T>(type: T, for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusedIdentifier, for: indexPath) as? T else {
            fatalError("Please register UITableViewCell before used")
        }
        return cell
    }

    /// 获取`UITableViewHeaderFooterView`
    /// - Returns: `T: UITableViewHeaderFooterView`
    func dequeueReusable<T>(view type: T) -> T where T: UITableViewHeaderFooterView {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reusedIdentifier) as? T else {
            fatalError("Please register UITableViewHeaderFooterView before used")
        }
        return headerFooter
    }
}

// MARK: - `UICollectionView`
public extension UICollectionView {

    /// 类型
    enum Kind {

        /// UICollectionViewCell
        case cell

        /// UICollectionReusableView footer
        case footer

        /// UICollectionReusableView header
        case header
    }

    /// 注册cell
    func register<T>(cell type: T.Type) where T: UICollectionViewCell {
        register(type, forCellWithReuseIdentifier: T.reusedIdentifier)
    }

    /// 注册header
    func register<T>(header type: T.Type) where T: UICollectionReusableView {
        register(type,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.reusedIdentifier)
    }

    /// 注册footer
    func register<T>(footer type: T.Type) where T: UICollectionReusableView {
        register(type,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: T.reusedIdentifier)
    }

    /// 获取对应的`UICollectionReusableView` cell
    /// - Returns: `T: UICollectionReusableView`
    func dequeueReusable<T>(cell type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusedIdentifier, for: indexPath) as? T else {
            fatalError("Please register UICollectionViewCell before used")
        }
        return cell
    }

    /// /// 获取对应的`UICollectionReusableView` header
    /// - Returns: `T: UICollectionReusableView
    func dequeueReusable<T>(header type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                          withReuseIdentifier: T.reusedIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Please register UICollectionReusableView header before used")
        }
        return view
    }

    /// 获取对应的`UICollectionReusableView` footer
    /// - Returns: `T: UICollectionReusableView`
    func dequeueReusable<T>(footer type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                          withReuseIdentifier: T.reusedIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Please register UICollectionReusableView footer before used")
        }
        return view
    }

    /// 注册 `UICollectionReusableView`
    func register<T>(kind: UICollectionView.Kind, type: T.Type) where T: UICollectionReusableView {
        if let reusedKind = kind.kind {
            register(type, forSupplementaryViewOfKind: reusedKind, withReuseIdentifier: T.reusedIdentifier)
        } else {
            register(type, forCellWithReuseIdentifier: T.reusedIdentifier)
        }
    }

    /// 重用
    /// - Returns: `T: UICollectionReusableView`
    func dequeueReusable<T>(kind: UICollectionView.Kind,
                            type: T.Type,
                            for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        if let reusedKind = kind.kind {
            guard let view = dequeueReusableSupplementaryView(ofKind: reusedKind,
                                                              withReuseIdentifier: T.reusedIdentifier,
                                                              for: indexPath) as? T else {
                fatalError("Please register UICollectionReusableView before used")
            }
            return view
        } else {
            guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusedIdentifier, for: indexPath) as? T else {
                fatalError("Please register UICollectionViewCell before used")
            }
            return cell
        }
    }
}

// MARK: - `UICollectionView.Kind`
extension UICollectionView.Kind {
    fileprivate var kind: String? {
        switch self {
            case .footer:
                return UICollectionView.elementKindSectionFooter
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .cell:
                return nil
        }
    }
}
#endif
