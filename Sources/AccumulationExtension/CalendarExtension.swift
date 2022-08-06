//
//  CalendarExtension.swift
//  
//
//  Created by Mario on 2022/8/6.
//

import Foundation


extension Calendar {

    ///
    public enum WeekDayEnum: Int {

        /// 周日
        case sunday = 1

        /// 周一
        case monday = 2

        /// 周二
        case tuesday = 3

        /// 周三
        case wednesday = 4

        /// 周四
        case thursday = 5

        /// 周五
        case friday = 6

        /// 周六
        case saturday = 7
    }

    /// 以周几开始
    public var weekdayStart: WeekDayEnum {
        set {
            firstWeekday = newValue.rawValue
        }
        get {
            WeekDayEnum(rawValue: firstWeekday) ?? .sunday
        }
    }
}
