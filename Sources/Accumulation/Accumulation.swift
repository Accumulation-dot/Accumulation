#if os(macOS)
import AppKit

public typealias AColor = NSColor
public typealias AImage = NSImage
public typealias AView = NSView
public typealias AImageView = NSImageView
public typealias AButton = NSButton
public typealias AFont = NSFont

#elseif os(iOS)
import UIKit

public typealias AColor = UIColor
public typealias AImage = UIImage
public typealias AView = UIView
public typealias AImageView = UIImageView
public typealias AButton = UIButton
public typealias AFont = UIFont
#endif

/// 类型处理
public typealias TypeHandler<T> = (T) -> Void
