//
//  DateExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Testing
import Foundation
@testable import Maple

@Suite("Date Extensions Test Suite")
struct DateExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Date should conform to MapleCompatibleValue")
    func testMapleCompatibleValue() {
        let date = Date()
        let wrapper = date.mp
        
        #expect(type(of: wrapper) == MapleWrapper<Date>.self)
    }
    
    // MARK: - Property: calendar
    
    @Test("calendar property should return current calendar")
    func testCalendar() {
        let date = Date()
        let calendar = date.mp.calendar
        
        #expect(calendar.identifier == Calendar.current.identifier)
    }
    
    // MARK: - Property: era
    
    @Test("era property should return valid era")
    func testEra() {
        let date = Date()
        let era = date.mp.era
        
        #expect(era > 0)
    }
    
    // MARK: - Property: quarter
    
    #if !os(Linux)
    @Test("quarter property should return valid quarter")
    func testQuarter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let q1Date = dateFormatter.date(from: "2024-02-15")!
        #expect(q1Date.mp.quarter == 1)
        
        let q2Date = dateFormatter.date(from: "2024-05-15")!
        #expect(q2Date.mp.quarter == 2)
        
        let q3Date = dateFormatter.date(from: "2024-08-15")!
        #expect(q3Date.mp.quarter == 3)
        
        let q4Date = dateFormatter.date(from: "2024-11-15")!
        #expect(q4Date.mp.quarter == 4)
    }
    #endif
    
    // MARK: - Property: weekOfYear
    
    @Test("weekOfYear property should return valid week")
    func testWeekOfYear() {
        let date = Date()
        let weekOfYear = date.mp.weekOfYear
        
        #expect(weekOfYear >= 1)
        #expect(weekOfYear <= 53)
    }
    
    // MARK: - Property: weekOfMonth
    
    @Test("weekOfMonth property should return valid week")
    func testWeekOfMonth() {
        let date = Date()
        let weekOfMonth = date.mp.weekOfMonth
        
        #expect(weekOfMonth >= 1)
        #expect(weekOfMonth <= 6)
    }
    
    // MARK: - Property: weekday
    
    @Test("weekday property should return valid weekday")
    func testWeekday() {
        let date = Date()
        let weekday = date.mp.weekday
        
        #expect(weekday >= 1)
        #expect(weekday <= 7)
    }
    
    // MARK: - Property: year
    
    @Test("year property should return correct year")
    func testYear() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15)
        let date = calendar.date(from: components)!
        
        #expect(date.mp.year == 2024)
    }
    
    // MARK: - Property: month
    
    @Test("month property should return correct month")
    func testMonth() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15)
        let date = calendar.date(from: components)!
        
        #expect(date.mp.month == 6)
    }
    
    // MARK: - Property: day
    
    @Test("day property should return correct day")
    func testDay() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15)
        let date = calendar.date(from: components)!
        
        #expect(date.mp.day == 15)
    }
    
    // MARK: - Property: hour
    
    @Test("hour property should return correct hour")
    func testHour() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15, hour: 14, minute: 30)
        let date = calendar.date(from: components)!
        
        #expect(date.mp.hour == 14)
    }
    
    // MARK: - Property: minute
    
    @Test("minute property should return correct minute")
    func testMinute() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15, hour: 14, minute: 30)
        let date = calendar.date(from: components)!
        
        #expect(date.mp.minute == 30)
    }
    
    // MARK: - Property: second
    
    @Test("second property should return correct second")
    func testSecond() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15, hour: 14, minute: 30, second: 45)
        let date = calendar.date(from: components)!
        
        #expect(date.mp.second == 45)
    }
    
    // MARK: - Property: nanosecond
    
    @Test("nanosecond property should return valid nanosecond")
    func testNanosecond() {
        let date = Date()
        let nanosecond = date.mp.nanosecond
        
        #expect(nanosecond >= 0)
        #expect(nanosecond < 1_000_000_000)
    }
    
    // MARK: - Property: millisecond
    
    @Test("millisecond property should return valid millisecond")
    func testMillisecond() {
        let date = Date()
        let millisecond = date.mp.millisecond
        
        #expect(millisecond >= 0)
        #expect(millisecond < 1000)
    }
    
    // MARK: - Property: isInFuture
    
    @Test("isInFuture should return true for future dates")
    func testIsInFuture() {
        let futureDate = Date(timeInterval: 100, since: Date())
        #expect(futureDate.mp.isInFuture == true)
        
        let pastDate = Date(timeInterval: -100, since: Date())
        #expect(pastDate.mp.isInFuture == false)
    }
    
    // MARK: - Property: isInPast
    
    @Test("isInPast should return true for past dates")
    func testIsInPast() {
        let pastDate = Date(timeInterval: -100, since: Date())
        #expect(pastDate.mp.isInPast == true)
        
        let futureDate = Date(timeInterval: 100, since: Date())
        #expect(futureDate.mp.isInPast == false)
    }
    
    // MARK: - Property: isInToday
    
    @Test("isInToday should return true for today's date")
    func testIsInToday() {
        let today = Date()
        #expect(today.mp.isInToday == true)
        
        let yesterday = Date(timeIntervalSinceNow: -86400)
        #expect(yesterday.mp.isInToday == false)
    }
    
    // MARK: - Property: isInYesterday
    
    @Test("isInYesterday should return true for yesterday's date")
    func testIsInYesterday() {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        
        #expect(yesterday.mp.isInYesterday == true)
    }
    
    // MARK: - Property: isInTomorrow
    
    @Test("isInTomorrow should return true for tomorrow's date")
    func testIsInTomorrow() {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let today = Date()
        
        #expect(tomorrow.mp.isInTomorrow == true)
        #expect(today.mp.isInTomorrow == false)
    }
    
    // MARK: - Property: isInWeekend
    
    @Test("isInWeekend should identify weekend dates")
    func testIsInWeekend() {
        let calendar = Calendar.current
        let date = Date()
        let isWeekend = date.mp.isInWeekend
        
        #expect(isWeekend == calendar.isDateInWeekend(date))
    }
    
    // MARK: - Property: isWorkday
    
    @Test("isWorkday should be opposite of isInWeekend")
    func testIsWorkday() {
        let date = Date()
        let isWorkday = date.mp.isWorkday
        let isWeekend = date.mp.isInWeekend
        
        #expect(isWorkday != isWeekend)
    }
    
    // MARK: - Property: isInCurrentWeek
    
    @Test("isInCurrentWeek should return true for current week")
    func testIsInCurrentWeek() {
        let today = Date()
        #expect(today.mp.isInCurrentWeek == true)
    }
    
    // MARK: - Property: isInCurrentMonth
    
    @Test("isInCurrentMonth should return true for current month")
    func testIsInCurrentMonth() {
        let today = Date()
        #expect(today.mp.isInCurrentMonth == true)
    }
    
    // MARK: - Property: isInCurrentYear
    
    @Test("isInCurrentYear should return true for current year")
    func testIsInCurrentYear() {
        let today = Date()
        #expect(today.mp.isInCurrentYear == true)
    }
    
    // MARK: - Property: yesterday
    
    @Test("yesterday should return date one day before")
    func testYesterday() {
        let date = Date()
        let yesterday = date.mp.yesterday!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: yesterday, to: date)
        #expect(components.day == 1)
    }
    
    // MARK: - Property: tomorrow
    
    @Test("tomorrow should return date one day after")
    func testTomorrow() {
        let date = Date()
        let tomorrow = date.mp.tomorrow!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: tomorrow)
        #expect(components.day == 1)
    }
    
    // MARK: - Property: unixTimestamp
    
    @Test("unixTimestamp should return time interval since 1970")
    func testUnixTimestamp() {
        let date = Date()
        let timestamp = date.mp.unixTimestamp
        
        #expect(timestamp == date.timeIntervalSince1970)
        #expect(timestamp > 0)
    }
    
    // MARK: - Method: adding
    
    @Test("adding should add calendar components correctly")
    func testAdding() {
        let calendar = Calendar.current
        let date = Date()
        
        // Test minutes
        let newDate1 = date.mp.adding(.minute, value: 10)
        let components1 = calendar.dateComponents([.minute], from: date, to: newDate1)
        #expect(components1.minute == 10)
        
        // Test days
        let newDate2 = date.mp.adding(.day, value: 5)
        let components2 = calendar.dateComponents([.day], from: date, to: newDate2)
        #expect(components2.day == 5)
        
        // Test months
        let newDate3 = date.mp.adding(.month, value: 2)
        let components3 = calendar.dateComponents([.month], from: date, to: newDate3)
        #expect(components3.month == 2)
        
        // Test years
        let newDate4 = date.mp.adding(.year, value: 1)
        let components4 = calendar.dateComponents([.year], from: date, to: newDate4)
        #expect(components4.year == 1)
        
        // Test quarter (adds 3 months)
        let newDate5 = date.mp.adding(.quarter, value: 1)
        let components5 = calendar.dateComponents([.month], from: date, to: newDate5)
        #expect(components5.month == 3)
    }
    
    // MARK: - Method: changing
    
    @Test("changing should change calendar components correctly")
    func testChanging() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15, hour: 10, minute: 30, second: 45, nanosecond: 100000)
        let date = calendar.date(from: components)!
        
        // Test changing nanosecond
        let newDate0 = date.mp.changing(.nanosecond, value: 500000)!
        #expect(abs(newDate0.mp.nanosecond - 500000) < 100000)
        #expect(newDate0.mp.second == 45)
        
        // Test invalid nanosecond
        #expect(date.mp.changing(.nanosecond, value: 2_000_000_000) == nil)
        
        // Test changing second
        let newDateSec = date.mp.changing(.second, value: 30)!
        #expect(newDateSec.mp.second == 30)
        #expect(newDateSec.mp.minute == 30)
        
        // Test invalid second
        #expect(date.mp.changing(.second, value: 70) == nil)
        
        // Test changing minute
        let newDateMin = date.mp.changing(.minute, value: 45)!
        #expect(newDateMin.mp.minute == 45)
        #expect(newDateMin.mp.hour == 10)
        
        // Test invalid minute
        #expect(date.mp.changing(.minute, value: 70) == nil)
        
        // Test changing hour
        let newDate1 = date.mp.changing(.hour, value: 15)!
        #expect(newDate1.mp.hour == 15)
        #expect(newDate1.mp.day == 15)
        
        // Test invalid hour
        #expect(date.mp.changing(.hour, value: 25) == nil)
        
        // Test changing day
        let newDate2 = date.mp.changing(.day, value: 20)!
        #expect(newDate2.mp.day == 20)
        #expect(newDate2.mp.month == 6)
        
        // Test invalid day
        #expect(date.mp.changing(.day, value: 32) == nil)
        
        // Test changing month
        let newDate3 = date.mp.changing(.month, value: 9)!
        #expect(newDate3.mp.month == 9)
        #expect(newDate3.mp.year == 2024)
        
        // Test invalid month
        #expect(date.mp.changing(.month, value: 13) == nil)
        
        // Test changing year
        let newDate4 = date.mp.changing(.year, value: 2025)!
        #expect(newDate4.mp.year == 2025)
        
        // Test invalid year (0 or negative)
        #expect(date.mp.changing(.year, value: -1) == nil)
        #expect(date.mp.changing(.year, value: 0) == nil)
        
        // Test default case (other components)
        let newDateEra = date.mp.changing(.era, value: 1)
        #expect(newDateEra != nil)
    }
    
    // MARK: - Method: string
    
    @Test("string should format date correctly")
    func testString() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 1, day: 15, hour: 14, minute: 30)
        let date = calendar.date(from: components)!
        
        let formatted1 = date.mp.string(withFormat: "yyyy-MM-dd")
        #expect(formatted1 == "2024-01-15")
        
        let formatted2 = date.mp.string(withFormat: "HH:mm")
        #expect(formatted2 == "14:30")
        
        let formatted3 = date.mp.string(withFormat: "dd/MM/yyyy HH:mm")
        #expect(formatted3 == "15/01/2024 14:30")
    }
    
    // MARK: - Method: isBetween
    
    @Test("isBetween should check if date is between two dates")
    func testIsBetween() {
        let calendar = Calendar.current
        let start = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        let middle = calendar.date(from: DateComponents(year: 2024, month: 6, day: 15))!
        let end = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
        
        #expect(middle.mp.isBetween(start, end) == true)
        #expect(start.mp.isBetween(middle, end) == false)
        
        // Test with bounds included
        #expect(start.mp.isBetween(start, end, includeBounds: true) == true)
        #expect(end.mp.isBetween(start, end, includeBounds: true) == true)
    }
    
    // MARK: - Method: isWithin
    
    @Test("isWithin should check if date is within range")
    func testIsWithin() {
        let calendar = Calendar.current
        let date1 = Date()
        let date2 = calendar.date(byAdding: .day, value: 5, to: date1)!
        
        #expect(date1.mp.isWithin(10, .day, of: date2) == true)
        #expect(date1.mp.isWithin(2, .day, of: date2) == false)
        
        // Test with exact boundary
        #expect(date1.mp.isWithin(5, .day, of: date2) == true)
        
        // Test with different components
        let date3 = calendar.date(byAdding: .hour, value: 3, to: date1)!
        #expect(date1.mp.isWithin(5, .hour, of: date3) == true)
    }
    
    // MARK: - Method: beginning
    
    #if !os(Linux)
    @Test("beginning should return start of calendar component")
    func testBeginning() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15, hour: 14, minute: 30, second: 45, nanosecond: 500000)
        let date = calendar.date(from: components)!
        
        // Test beginning of second
        let beginningOfSecond = date.mp.beginning(of: .second)
        #expect(beginningOfSecond.mp.second == 45)
        #expect(beginningOfSecond.mp.nanosecond == 0)
        
        // Test beginning of minute
        let beginningOfMinute = date.mp.beginning(of: .minute)
        #expect(beginningOfMinute.mp.minute == 30)
        #expect(beginningOfMinute.mp.second == 0)
        
        // Test beginning of hour
        let beginningOfHour = date.mp.beginning(of: .hour)
        #expect(beginningOfHour.mp.hour == 14)
        #expect(beginningOfHour.mp.minute == 0)
        #expect(beginningOfHour.mp.second == 0)
        
        // Test beginning of day
        let beginningOfDay = date.mp.beginning(of: .day)
        #expect(beginningOfDay.mp.hour == 0)
        #expect(beginningOfDay.mp.minute == 0)
        #expect(beginningOfDay.mp.second == 0)
        
        // Test beginning of week
        let beginningOfWeek = date.mp.beginning(of: .weekOfYear)
        #expect(beginningOfWeek.mp.weekOfYear == date.mp.weekOfYear)
        #expect(beginningOfWeek.mp.weekday == calendar.firstWeekday)
        
        // Test beginning of month
        let beginningOfMonth = date.mp.beginning(of: .month)
        #expect(beginningOfMonth.mp.day == 1)
        #expect(beginningOfMonth.mp.month == 6)
        
        // Test beginning of year
        let beginningOfYear = date.mp.beginning(of: .year)
        #expect(beginningOfYear.mp.month == 1)
        #expect(beginningOfYear.mp.day == 1)
        #expect(beginningOfYear.mp.year == 2024)
        
        // Test default case
        let beginningDefault = date.mp.beginning(of: .era)
        #expect(beginningDefault != date)
    }
    #endif
    
    // MARK: - Method: end
    
    @Test("end should return last moment of calendar component")
    func testEnd() {
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 6, day: 15, hour: 10, minute: 30, second: 45)
        let date = calendar.date(from: components)!
        
        // Test end of second
        let endOfSecond = date.mp.end(of: .second)
        #expect(endOfSecond.mp.second == 45)
        #expect(endOfSecond.mp.minute == 30)
        
        // Test end of minute
        let endOfMinute = date.mp.end(of: .minute)
        #expect(endOfMinute.mp.minute == 30)
        #expect(endOfMinute.mp.second == 59)
        
        // Test end of hour
        let endOfHour = date.mp.end(of: .hour)
        #expect(endOfHour.mp.hour == 10)
        #expect(endOfHour.mp.minute == 59)
        #expect(endOfHour.mp.second == 59)
        
        // Test end of day
        let endOfDay = date.mp.end(of: .day)
        #expect(endOfDay.mp.day == 15)
        #expect(endOfDay.mp.hour == 23)
        #expect(endOfDay.mp.minute == 59)
        #expect(endOfDay.mp.second == 59)
        
        // Test end of week
        let endOfWeek = date.mp.end(of: .weekOfYear)
        #expect(endOfWeek.mp.weekOfYear == date.mp.weekOfYear)
        #expect(endOfWeek.mp.hour == 23)
        #expect(endOfWeek.mp.minute == 59)
        
        // Test end of month
        let endOfMonth = date.mp.end(of: .month)
        #expect(endOfMonth.mp.day == 30)
        #expect(endOfMonth.mp.month == 6)
        
        // Test end of year
        let endOfYear = date.mp.end(of: .year)
        #expect(endOfYear.mp.month == 12)
        #expect(endOfYear.mp.day == 31)
        #expect(endOfYear.mp.year == 2024)
        
        // Test default case
        let endDefault = date.mp.end(of: .era)
        #expect(endDefault == date)
    }
    
    // MARK: - Method: isInCurrent
    
    @Test("isInCurrent should check if date is in current component")
    func testIsInCurrent() {
        let today = Date()
        
        #expect(today.mp.isInCurrent(.day) == true)
        #expect(today.mp.isInCurrent(.month) == true)
        #expect(today.mp.isInCurrent(.year) == true)
    }
    
    // MARK: - Method: compare
    
    @Test("compare should return date components difference")
    func testCompare() {
        let calendar = Calendar.current
        let date1 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        let date2 = calendar.date(from: DateComponents(year: 2024, month: 6, day: 15))!
        
        let diff = date1.mp.compare([.month, .day], to: date2)
        
        #expect(diff.month != nil)
        #expect(diff.day != nil)
    }
    
    // MARK: - Method: differ
    
    @Test("differ should calculate difference in calendar component")
    func testDiffer() {
        let calendar = Calendar.current
        let date1 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        let date2 = calendar.date(from: DateComponents(year: 2024, month: 6, day: 1))!
        
        // Test months
        let monthsDiff = date1.mp.differ(.month, to: date2)
        #expect(monthsDiff == 5)
        
        // Test days
        let date3 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 15))!
        let daysDiff = date1.mp.differ(.day, to: date3)
        #expect(daysDiff == 14)
        
        // Test years
        let date5 = calendar.date(from: DateComponents(year: 2026, month: 1, day: 1))!
        let yearsDiff = date1.mp.differ(.year, to: date5)
        #expect(yearsDiff == 2)
        
        // Test hours
        let date6 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1, hour: 5))!
        let hoursDiff = date1.mp.differ(.hour, to: date6)
        #expect(hoursDiff == 5)
        
        // Test minutes
        let date7 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1, hour: 0, minute: 30))!
        let minutesDiff = date1.mp.differ(.minute, to: date7)
        #expect(minutesDiff == 30)
        
        // Test quarters (within same year)
        let date4 = calendar.date(from: DateComponents(year: 2024, month: 10, day: 1))!
        let quartersDiff = date1.mp.differ(.quarter, to: date4)
        #expect(quartersDiff == 3) // Q1 2024 to Q4 2024 = 9 months / 3 = 3 quarters
        
        // Test quarters (cross year)
        let dateQ2_2025 = calendar.date(from: DateComponents(year: 2025, month: 4, day: 1))!
        let quartersCrossYear = date1.mp.differ(.quarter, to: dateQ2_2025)
        #expect(quartersCrossYear == 5) // Jan 2024 to Apr 2025 = 15 months / 3 = 5 quarters
        
        // Test quarters (negative - going back)
        let dateQ4_2023 = calendar.date(from: DateComponents(year: 2023, month: 10, day: 1))!
        let quartersNegative = date1.mp.differ(.quarter, to: dateQ4_2023)
        #expect(quartersNegative == -1) // Jan 2024 to Oct 2023 = -3 months / 3 = -1 quarter
        
        // Test months (cross year)
        let date2025 = calendar.date(from: DateComponents(year: 2025, month: 3, day: 1))!
        let monthsDiffCrossYear = date1.mp.differ(.month, to: date2025)
        #expect(monthsDiffCrossYear == 14) // Jan 2024 to Mar 2025 = 14 months
        
        // Test negative difference
        let negativeDiff = date2.mp.differ(.month, to: date1)
        #expect(negativeDiff == -5)
        
        // Test same date
        let sameDiff = date1.mp.differ(.month, to: date1)
        #expect(sameDiff == 0)
        
        // Test week difference
        let date8 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 15))!
        let weekDiff = date1.mp.differ(.weekOfYear, to: date8)
        #expect(weekDiff >= 0)
        
        // Test era difference
        let eraDiff = date1.mp.differ(.era, to: date2)
        #expect(eraDiff == 0)
        
        // Test with distant past and future
        let distantPast = Date.distantPast
        let distantFuture = Date.distantFuture
        let extremeDiff = distantPast.mp.differ(.year, to: distantFuture)
        #expect(extremeDiff != 0)
        
        // Test with very close dates (nanosecond precision)
        let now = Date()
        let almostNow = Date(timeIntervalSinceNow: 0.0001)
        let nanosecDiff = now.mp.differ(.nanosecond, to: almostNow)
        #expect(nanosecDiff >= 0)
    }
}
