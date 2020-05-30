//
//  Date+Maple.swift
//  Maple
//
//  Created by cy on 2020/5/13.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
extension Date: MabpleCompatibleValue { }
// MARK: - Maple
public extension MabpleWrapper where Base == Date {
    
    /// User’s current calendar.
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier) // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
    }
    
    /// Era.
    ///
    ///        Date().era -> 1
    ///
    var era: Int {
        return calendar.component(.era, from: base)
    }
    
    #if !os(Linux)
    /// Quarter.
    ///
    ///        Date().quarter -> 3 // date in third quarter of the year.
    ///
    var quarter: Int {
        let month = Double(calendar.component(.month, from: base))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month/numberOfMonthsInQuarter))
    }
    #endif
    
    /// Week of year.
    ///
    ///        Date().weekOfYear -> 2 // second week in the year.
    ///
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: base)
    }
    
    /// Week of month.
    ///
    ///        Date().weekOfMonth -> 3 // date is in third week of the month.
    ///
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: base)
    }
    
    /// Year.
    ///
    ///        Date().year -> 2017
    ///
    var year: Int {
        return calendar.component(.year, from: base)
    }
    
    /// Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.month = 10 // sets someDate's month to 10.
    ///
    var month: Int {
        return calendar.component(.month, from: base)
    }
    
    /// Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    ///
    var day: Int {
        return calendar.component(.day, from: base)
    }
    
    /// Check if date is within today.
    ///
    ///     Date().isInToday -> true
    ///
    var isInToday: Bool {
        return calendar.isDateInToday(base)
    }

    /// Check if date is within yesterday.
    ///
    ///     Date().isInYesterday -> false
    ///
    var isInYesterday: Bool {
        return calendar.isDateInYesterday(base)
    }

    /// Check if date is within tomorrow.
    ///
    ///     Date().isInTomorrow -> false
    ///
    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(base)
    }

    /// Check if date is within a weekend period.
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(base)
    }

    /// Check if date is within a weekday period.
    var isWorkday: Bool {
        return !calendar.isDateInWeekend(base)
    }

    /// Check if date is within the current week.
    var isInCurrentWeek: Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// Check if date is within the current month.
    var isInCurrentMonth: Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: .month)
    }

    /// Check if date is within the current year.
    var isInCurrentYear: Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: .year)
    }
    
    /// Yesterday date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let yesterday = date.yesterday // "Oct 2, 2018, 10:57:11"
    ///
    var yesterday: Date? {
        return calendar.date(byAdding: .day, value: -1, to: base)
    }

    /// Tomorrow's date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let tomorrow = date.tomorrow // "Oct 4, 2018, 10:57:11"
    ///
    var tomorrow: Date? {
        return calendar.date(byAdding: .day, value: 1, to: base)
    }
    
    /// UNIX timestamp from date.
    ///
    ///        Date().unixTimestamp -> 1484233862.826291
    ///
    var unixTimestamp: TimeInterval {
        return base.timeIntervalSince1970
    }
}

// MARK: - Methods
public extension MabpleWrapper where Base == Date {
    
    /// Date by adding multiples of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: base)!
    }
    
    /// Date string from date.
    ///
    ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
    ///     Date().string(withFormat: "HH:mm") -> "23:50"
    ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
    ///
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    func string(withFormat format: String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: base)
    }
}
#endif
