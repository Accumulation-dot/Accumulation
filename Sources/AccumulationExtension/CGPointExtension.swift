//
//  CGPointExtension.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import CoreGraphics

public extension CGPoint {

    init(same value: Int) {
        self.init(x: value, y: value)
    }

    init(same value: CGFloat) {
        self.init(x: value, y: value)
    }

    init(same value: Double) {
        self.init(x: value, y: value)
    }
}
