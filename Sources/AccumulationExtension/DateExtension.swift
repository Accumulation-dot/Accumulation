//
//  DateExtension.swift
//  
//
//  Created by Mario on 2022/7/27.
//

import Foundation

public extension Date {

    /// zero 1970/1/1
    static let zero = Date(timeIntervalSince1970: .zero)

    /// 是否在同一天
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// 是否为当前时间的明天
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    /// 是否为当前时间的昨天
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    /// 计算两个日期的间隔
    /// - Parameters:
    ///   - date: 目标时间
    ///   - component: 根据
    /// - Returns: 间隔
    func distance(_ date: Date, component: Calendar.Component = .day) -> Int {
        Calendar.current.dateComponents([component], from: self, to: date).value(for: component) ?? .zero
    }

    /// 计算间隔
    /// - Parameters:
    ///   - date: 目标时间
    ///   - components: 需要计算的内容
    /// - Returns: 根据计算内容生成的数组
    func distance(_ date: Date, components: Set<Calendar.Component>) -> [Int] {
        if components.isEmpty {
            return []
        }
        let component = Calendar.current.dateComponents(components, from: self, to: date)
        return components.map {
            component.value(for: $0) ?? .zero
        }
    }
}
