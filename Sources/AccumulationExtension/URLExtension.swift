//
//  URL+Extension.swift
//  
//
//  Created by Mario on 2022/8/29.
//

import Foundation

/// URL 扩展
public extension URL {

    /// 获取参数
    var urlParameters: [String: Any]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let items = components.queryItems else {
            return nil
        }
        return items.reduce(into: [String: Any]()) { result, item in
            result[item.name] = item.value
        }
    }

  
}
