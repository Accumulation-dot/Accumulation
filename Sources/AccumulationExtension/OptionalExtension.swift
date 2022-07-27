//
//  OptionalExtension.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import Foundation

public extension Optional where Wrapped: Collection {

    /// 是否为空
    var isEmpty: Bool {
        guard let self = self else {
            return true
        }
        return self.isEmpty
    }
}
