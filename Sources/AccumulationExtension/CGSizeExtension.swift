//
//  File.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import CoreGraphics

public extension CGSize {

    init(same value: CGFloat) {
        self.init(width: value, height: value)
    }

    init(same value: Int) {
        self.init(width: value, height: value)
    }

    init(same value: Double) {
        self.init(width: value, height: value)
    }

    func rate(_ value: CGFloat) -> CGSize {
        CGSize(width: width * value, height: height * value)
    }

    mutating func rated(_ value: CGFloat) {
        width = width * value
        height = height * value
    }
}
