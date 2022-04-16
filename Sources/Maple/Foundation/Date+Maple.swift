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

// MARK: - Properties
public extension MabpleWrapper where Base == Date {
    
    /// User’s current calendar.
    var calendar: Calendar {
        Calendar(identifier: Calendar.current.identifier) // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
    }
    
    /// Era.
    ///
    ///        Date().era -> 1
    ///
    var era: Int {
        calendar.component(.era, from: base)
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
        calendar.component(.weekOfYear, from: base)
    }
    
    /// Week of month.
    ///
    ///        Date().weekOfMonth -> 3 // date is in third week of the month.
    ///
    var weekOfMonth: Int {
        calendar.component(.weekOfMonth, from: base)
    }
    
    /// Year.
    ///
    ///        Date().year -> 2017
    ///
    var year: Int {
        calendar.component(.year, from: base)
    }
    
    /// Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.month = 10 // sets someDate's month to 10.
    ///
    var month: Int {
        calendar.component(.month, from: base)
    }
    
    /// Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    ///
    var day: Int {
        calendar.component(.day, from: base)
    }
    
    /// Hour.
    ///
    ///     Date().hour -> 17 // 5 pm
    ///
    ///     var someDate = Date()
    ///     someDate.hour = 13 // sets someDate's hour to 1 pm.
    ///
    var hour: Int {
        calendar.component(.hour, from: base)
    }
    
    /// Minutes.
    ///
    ///     Date().minute -> 39
    ///
    ///     var someDate = Date()
    ///     someDate.minute = 10 // sets someDate's minutes to 10.
    ///
    var minute: Int {
        calendar.component(.minute, from: base)
    }
    
    /// Seconds.
    ///
    ///     Date().second -> 55
    ///
    ///     var someDate = Date()
    ///     someDate.second = 15 // sets someDate's seconds to 15.
    ///
    var second: Int {
        calendar.component(.second, from: base)
    }
    
    /// SwifterSwift: Nanoseconds.
    ///
    ///     Date().nanosecond -> 981379985
    ///
    ///     var someDate = Date()
    ///     someDate.nanosecond = 981379985 // sets someDate's seconds to 981379985.
    ///
    var nanosecond: Int {
        calendar.component(.nanosecond, from: base)
    }
    
    /// Milliseconds.
    ///
    ///     Date().millisecond -> 68
    ///
    ///     var someDate = Date()
    ///     someDate.millisecond = 68 // sets someDate's nanosecond to 68000000.
    ///
    var millisecond: Int {
        calendar.component(.nanosecond, from: base) / 1_000_000
    }
    
    /// Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).isInFuture -> true
    ///
    var isInFuture: Bool {
        base > Date()
    }

    /// Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isInPast -> true
    ///
    var isInPast: Bool {
        base < Date()
    }
    
    /// Check if date is within today.
    ///
    ///     Date().isInToday -> true
    ///
    var isInToday: Bool {
        calendar.isDateInToday(base)
    }
    
    /// Check if date is within yesterday.
    ///
    ///     Date().isInYesterday -> false
    ///
    var isInYesterday: Bool {
        calendar.isDateInYesterday(base)
    }
    
    /// Check if date is within tomorrow.
    ///
    ///     Date().isInTomorrow -> false
    ///
    var isInTomorrow: Bool {
        calendar.isDateInTomorrow(base)
    }
    
    /// Check if date is within a weekend period.
    var isInWeekend: Bool {
        calendar.isDateInWeekend(base)
    }
    
    /// Check if date is within a weekday period.
    var isWorkday: Bool {
        !calendar.isDateInWeekend(base)
    }
    
    /// Check if date is within the current week.
    var isInCurrentWeek: Bool {
        calendar.isDate(base, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// Check if date is within the current month.
    var isInCurrentMonth: Bool {
        calendar.isDate(base, equalTo: Date(), toGranularity: .month)
    }
    
    /// Check if date is within the current year.
    var isInCurrentYear: Bool {
        calendar.isDate(base, equalTo: Date(), toGranularity: .year)
    }
    
    /// Yesterday date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let yesterday = date.yesterday // "Oct 2, 2018, 10:57:11"
    ///
    var yesterday: Date? {
        calendar.date(byAdding: .day, value: -1, to: base)
    }
    
    /// Tomorrow's date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let tomorrow = date.tomorrow // "Oct 4, 2018, 10:57:11"
    ///
    var tomorrow: Date? {
        calendar.date(byAdding: .day, value: 1, to: base)
    }
    
    /// UNIX timestamp from date.
    ///
    ///        Date().unixTimestamp -> 1484233862.826291
    ///
    var unixTimestamp: TimeInterval {
        base.timeIntervalSince1970
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
        calendar.date(byAdding: component, value: value, to: base)!
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
    
    /// check if a date is between two other dates.
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false).
    /// - Returns: true if the date is between the two given dates.
    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(base).rawValue * base.compare(endDate).rawValue >= 0
        }
        return startDate.compare(base).rawValue * base.compare(endDate).rawValue > 0
    }
    
    /// check if a date is a number of date components of another date.
    ///
    /// - Parameters:
    ///   - value: number of times component is used in creating range.
    ///   - component: Calendar.Component to use.
    ///   - date: Date to compare self to.
    /// - Returns: true if the date is within a number of components of another date.
    func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = calendar.dateComponents([component], from: base, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }
}
#endif
