//
//  CollectionExtension.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import Foundation

public extension Collection {

    /// 获取方式
    subscript(nilable index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
