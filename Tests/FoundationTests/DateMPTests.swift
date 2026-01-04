//
//  DateMPTests.swift
//  Maple
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class DateMPTests: XCTestCase {

    override func setUp() {
        super.setUp()
        NSTimeZone.default = TimeZone(abbreviation: "UTC")!
    }
    
    func testCalendar() {
        switch Calendar.current.identifier {
        case .buddhist:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .buddhist).identifier)
        case .chinese:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .chinese).identifier)
        case .coptic:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .coptic).identifier)
        case .ethiopicAmeteAlem:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .ethiopicAmeteAlem).identifier)
        case .ethiopicAmeteMihret:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .ethiopicAmeteMihret).identifier)
        case .gregorian:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .gregorian).identifier)
        case .hebrew:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .hebrew).identifier)
        case .indian:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .indian).identifier)
        case .islamic:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .islamic).identifier)
        case .islamicCivil:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .islamicCivil).identifier)
        case .islamicTabular:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .islamicTabular).identifier)
        case .islamicUmmAlQura:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .islamicUmmAlQura).identifier)
        case .iso8601:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .iso8601).identifier)
        case .japanese:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .japanese).identifier)
        case .persian:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .persian).identifier)
        case .republicOfChina:
            XCTAssertEqual(Date().mp.calendar.identifier, Calendar(identifier: .republicOfChina).identifier)
        default:
            break
        }
    }

    func testEra() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.mp.era, 1)
    }
    
    func testQuarter() {
        #if !os(Linux)
        let date1 = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date1.mp.quarter, 1)

        let date2 = Calendar.current.date(byAdding: .month, value: 4, to: date1)
        XCTAssertEqual(date2?.mp.quarter, 2)

        let date3 = Calendar.current.date(byAdding: .month, value: 8, to: date1)
        XCTAssertEqual(date3?.mp.quarter, 3)

        let date4 = Calendar.current.date(byAdding: .month, value: 11, to: date1)
        XCTAssertEqual(date4?.mp.quarter, 4)
        #endif
    }
    
    func testWeekOfYear() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.mp.weekOfYear, 1)

        let dateAfter7Days = Calendar.current.date(byAdding: .day, value: 7, to: date)
        XCTAssertEqual(dateAfter7Days?.mp.weekOfYear, 2)

        let originalDate = Calendar.current.date(byAdding: .day, value: -7, to: dateAfter7Days!)
        XCTAssertEqual(originalDate?.mp.weekOfYear, 1)
    }

    func testWeekOfMonth() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.mp.weekOfMonth, 1)

        let dateAfter7Days = Calendar.current.date(byAdding: .day, value: 7, to: date)
        XCTAssertEqual(dateAfter7Days?.mp.weekOfMonth, 2)

        let originalDate = Calendar.current.date(byAdding: .day, value: -7, to: dateAfter7Days!)
        XCTAssertEqual(originalDate?.mp.weekOfMonth, 1)
    }
    
    func testWeekday() {
        let date = Date(timeIntervalSince1970: 100_000)
        XCTAssertEqual(date.mp.weekday, 6)
    }
    
    func testYear() {
        let date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.mp.year, 1970)
    }

    func testMonth() {
        let date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.mp.month, 1)
    }

    func testDay() {
        let date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.mp.day, 2)
    }
    
    func testHour() {
        let date = Date(timeIntervalSince1970: 100_000.123450040)
        XCTAssertEqual(date.mp.hour, 3)

        var isLowerComponentsValid: Bool {
            guard date.mp.minute == 46 else { return false }
            guard date.mp.second == 40 else { return false }
            guard date.mp.nanosecond == 123_450_040 else { return false }
            return true
        }
    }

    func testMinute() {
        let date = Date(timeIntervalSince1970: 100_000.123450040)
        XCTAssertEqual(date.mp.minute, 46)

        var isLowerComponentsValid: Bool {
            guard date.mp.second == 40 else { return false }
            guard date.mp.nanosecond == 123_450_040 else { return false }
            return true
        }
    }

    func testSecond() {
        let date = Date(timeIntervalSince1970: 100_000.123450040)
        XCTAssertEqual(date.mp.second, 40)

        var isLowerComponentsValid: Bool {
            guard date.mp.nanosecond == 123_450_040 else { return false }
            return true
        }
    }

    func testNanosecond() {
        let date = Date(timeIntervalSince1970: 100_000.123450040)
        XCTAssertEqual(date.mp.nanosecond, 123_450_040)
    }

    func testMillisecond() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.mp.millisecond, 0)
    }
    
    func testIsInToday() {
        XCTAssert(Date().mp.isInToday)
        let tomorrow = Date().mp.adding(.day, value: 1)
        XCTAssertFalse(tomorrow.mp.isInToday)
        let yesterday = Date().mp.adding(.day, value: -1)
        XCTAssertFalse(yesterday.mp.isInToday)
    }
    
    func testIsInYesterday() {
        XCTAssertFalse(Date().mp.isInYesterday)
        let tomorrow = Date().mp.adding(.day, value: 1)
        XCTAssertFalse(tomorrow.mp.isInYesterday)
        let yesterday = Date().mp.adding(.day, value: -1)
        XCTAssert(yesterday.mp.isInYesterday)
    }
    
    func testIsInTomorrow() {
        XCTAssertFalse(Date().mp.isInTomorrow)
        let tomorrow = Date().mp.adding(.day, value: 1)
        XCTAssert(tomorrow.mp.isInTomorrow)
        let yesterday = Date().mp.adding(.day, value: -1)
        XCTAssertFalse(yesterday.mp.isInTomorrow)
    }

    func testIsInWeekend() {
        let date = Date()
        XCTAssertEqual(date.mp.isInWeekend, Calendar.current.isDateInWeekend(date))
    }
    
    func testIsWorkday() {
        let date = Date()
        XCTAssertEqual(date.mp.isWorkday, !Calendar.current.isDateInWeekend(date))
    }

    func testIsInCurrentWeek() {
        let date = Date()
        XCTAssert(date.mp.isInCurrentWeek)
        let dateOneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
        XCTAssertFalse(dateOneYearFromNow.mp.isInCurrentWeek)
    }

    func testIsInCurrentMonth() {
        let date = Date()
        XCTAssert(date.mp.isInCurrentMonth)
        let dateOneYearFromNow = date.mp.adding(.year, value: 1)
        XCTAssertFalse(dateOneYearFromNow.mp.isInCurrentMonth)
    }

    func testIsInCurrentYear() {
        let date = Date()
        XCTAssert(date.mp.isInCurrentYear)
        let dateOneYearFromNow = date.mp.adding(.year, value: 1)
        XCTAssertFalse(dateOneYearFromNow.mp.isInCurrentYear)
    }
    
    func testIsInFuture() {
        let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        let futureDate = Date(timeIntervalSinceNow: 512)

        XCTAssert(futureDate.mp.isInFuture)
        XCTAssertFalse(oldDate.mp.isInFuture)
    }

    func testIsInPast() {
        let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        let futureDate = Date(timeIntervalSinceNow: 512)

        XCTAssert(oldDate.mp.isInPast)
        XCTAssertFalse(futureDate.mp.isInPast)
    }
    
    func testYesterday() {
        let date = Date()
        let yesterday = date.mp.yesterday
        XCTAssertNotNil(yesterday)
        let yesterdayCheck = Calendar.current.date(byAdding: .day, value: -1, to: date)
        XCTAssertEqual(yesterday, yesterdayCheck)
    }

    func testTomorrow() {
        let date = Date()
        let tomorrow = date.mp.tomorrow
        XCTAssertNotNil(tomorrow)
        let tomorrowCheck = Calendar.current.date(byAdding: .day, value: 1, to: date)
        XCTAssertEqual(tomorrow, tomorrowCheck)
    }
    
    func testUnixTimestamp() {
        let date = Date()
        XCTAssertEqual(date.mp.unixTimestamp, date.timeIntervalSince1970)

        let date2 = Date(timeIntervalSince1970: 100)
        XCTAssertEqual(date2.mp.unixTimestamp, 100)
    }
    
    func testAdding() {
        let date = Date(timeIntervalSince1970: 3610) // Jan 1, 1970, 3:00:10 AM

        XCTAssertEqual(date.mp.adding(.day, value: 0), date)
        let date4 = date.mp.adding(.day, value: 2)
        XCTAssertEqual(date4.mp.day, date.mp.day + 2)
        XCTAssertEqual(date4.mp.adding(.day, value: -2), date)

        XCTAssertEqual(date.mp.adding(.weekOfYear, value: 0), date)
        let date5 = date.mp.adding(.weekOfYear, value: 1)
        XCTAssertEqual(date5.mp.day, date.mp.day + 7)
        XCTAssertEqual(date5.mp.adding(.weekOfYear, value: -1), date)

        XCTAssertEqual(date.mp.adding(.weekOfMonth, value: 0), date)
        let date6 = date.mp.adding(.weekOfMonth, value: 1)
        XCTAssertEqual(date6.mp.day, date.mp.day + 7)
        XCTAssertEqual(date6.mp.adding(.weekOfMonth, value: -1), date)

        XCTAssertEqual(date.mp.adding(.month, value: 0), date)
        let date7 = date.mp.adding(.month, value: 2)
        XCTAssertEqual(date7.mp.month, date.mp.month + 2)
        XCTAssertEqual(date7.mp.adding(.month, value: -2), date)

        XCTAssertEqual(date.mp.adding(.year, value: 0), date)
        let date8 = date.mp.adding(.year, value: 4)
        XCTAssertEqual(date8.mp.year, date.mp.year + 4)
        XCTAssertEqual(date8.mp.adding(.year, value: -4), date)
        
        XCTAssertEqual(date.mp.adding(.quarter, value: 0), date)
        let date9 = date.mp.adding(.quarter, value: 2)
        XCTAssertEqual(date9.mp.quarter, date.mp.quarter + 2)
        XCTAssertEqual(date9.mp.adding(.quarter, value: -2), date)
    }
    
    func testDateString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()
        formatter.timeStyle = .none

        formatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual(date.mp.string(withFormat: "dd/MM/yyyy"), formatter.string(from: date))

        formatter.dateFormat = "HH:mm"
        XCTAssertEqual(date.mp.string(withFormat: "HH:mm"), formatter.string(from: date))

        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        XCTAssertEqual(date.mp.string(withFormat: "dd/MM/yyyy HH:mm"), formatter.string(from: date))

        formatter.dateFormat = "iiiii"
        XCTAssertEqual(date.mp.string(withFormat: "iiiii"), formatter.string(from: date))
    }
    
    func testChanging() {
        let date = Date(timeIntervalSince1970: 0)

        XCTAssertNil(date.mp.changing(.nanosecond, value: -10))
        XCTAssertNotNil(date.mp.changing(.nanosecond, value: 123_450_040))
        XCTAssertEqual(date.mp.changing(.nanosecond, value: 123_450_040)?.mp.nanosecond, 123_450_040)

        XCTAssertNil(date.mp.changing(.second, value: -10))
        XCTAssertNil(date.mp.changing(.second, value: 70))
        XCTAssertNotNil(date.mp.changing(.second, value: 20))
        XCTAssertEqual(date.mp.changing(.second, value: 20)?.mp.second, 20)

        XCTAssertNil(date.mp.changing(.minute, value: -10))
        XCTAssertNil(date.mp.changing(.minute, value: 70))
        XCTAssertNotNil(date.mp.changing(.minute, value: 20))
        XCTAssertEqual(date.mp.changing(.minute, value: 20)?.mp.minute, 20)

        XCTAssertNil(date.mp.changing(.hour, value: -2))
        XCTAssertNil(date.mp.changing(.hour, value: 25))
        XCTAssertNotNil(date.mp.changing(.hour, value: 6))
        XCTAssertEqual(date.mp.changing(.hour, value: 6)?.mp.hour, 6)

        XCTAssertNil(date.mp.changing(.day, value: -2))
        XCTAssertNil(date.mp.changing(.day, value: 35))
        XCTAssertNotNil(date.mp.changing(.day, value: 6))
        XCTAssertEqual(date.mp.changing(.day, value: 6)?.mp.day, 6)

        XCTAssertNil(date.mp.changing(.month, value: -2))
        XCTAssertNil(date.mp.changing(.month, value: 13))
        XCTAssertNotNil(date.mp.changing(.month, value: 6))
        XCTAssertEqual(date.mp.changing(.month, value: 6)?.mp.month, 6)

        XCTAssertNil(date.mp.changing(.year, value: -2))
        XCTAssertNil(date.mp.changing(.year, value: 0))
        XCTAssertNotNil(date.mp.changing(.year, value: 2015))
        XCTAssertEqual(date.mp.changing(.year, value: 2015)?.mp.year, 2015)

        let date1 = Date()
        let date2 = date1.mp.changing(.weekOfYear, value: 10)
        XCTAssertEqual(date2, Calendar.current.date(bySetting: .weekOfYear, value: 10, of: date1))
    }
    
    func testIsBetween() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = date1.addingTimeInterval(60)
        let date3 = date2.addingTimeInterval(60)

        XCTAssert(date2.mp.isBetween(date1, date3))
        XCTAssertFalse(date1.mp.isBetween(date2, date3))
        XCTAssert(date1.mp.isBetween(date1, date2, includeBounds: true))
        XCTAssertFalse(date1.mp.isBetween(date1, date2))
    }
    
    func testIsWithin() {
        let date1 = Date(timeIntervalSince1970: 60 * 60 * 24) // 1970-01-01T00:00:00.000Z
        let date2 = date1.addingTimeInterval(60 * 60) // 1970-01-01T00:01:00.000Z, one hour later than date1
        // The regular
        XCTAssertFalse(date1.mp.isWithin(1, .second, of: date2))
        XCTAssertFalse(date1.mp.isWithin(1, .minute, of: date2))
        XCTAssert(date1.mp.isWithin(1, .hour, of: date2))
        XCTAssert(date1.mp.isWithin(1, .day, of: date2))

        // The other way around
        XCTAssertFalse(date2.mp.isWithin(1, .second, of: date1))
        XCTAssertFalse(date2.mp.isWithin(1, .minute, of: date1))
        XCTAssert(date2.mp.isWithin(1, .hour, of: date1))
        XCTAssert(date2.mp.isWithin(1, .day, of: date1))

        // With itself
        XCTAssert(date1.mp.isWithin(1, .second, of: date1))
        XCTAssert(date1.mp.isWithin(1, .minute, of: date1))
        XCTAssert(date1.mp.isWithin(1, .hour, of: date1))
        XCTAssert(date1.mp.isWithin(1, .day, of: date1))

        // Invalid
        XCTAssertFalse(Date().mp.isWithin(1, .calendar, of: Date()))
    }
    
    func testBeginning() {
        #if !os(Linux)
        let date = Date()

        XCTAssertNotNil(date.mp.beginning(of: .second))
        XCTAssertEqual(date.mp.beginning(of: .second).mp.nanosecond, 0)

        XCTAssertNotNil(date.mp.beginning(of: .minute))
        XCTAssertEqual(date.mp.beginning(of: .minute).mp.second, 0)

        XCTAssertNotNil(date.mp.beginning(of: .hour))
        XCTAssertEqual(date.mp.beginning(of: .hour).mp.minute, 0)

        XCTAssertNotNil(date.mp.beginning(of: .day))
        XCTAssertEqual(date.mp.beginning(of: .day).mp.hour, 0)
        XCTAssertEqual(date.mp.beginning(of: .day).mp.isInToday, true)

        let comps = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        let beginningOfWeek = Calendar.current.date(from: comps)
        XCTAssertNotNil(date.mp.beginning(of: .weekOfMonth))
        XCTAssertNotNil(beginningOfWeek)
        XCTAssertEqual(date.mp.beginning(of: .weekOfMonth).mp.day, beginningOfWeek?.mp.day)
        
        var components = DateComponents()
        components.year = 2022
        components.month = 5
        components.day = 1
        let beginningOfMonth = Calendar.current.date(from: components)!
        XCTAssertEqual(date.mp.beginning(of: .month).mp.day, beginningOfMonth.mp.day)

        components.year = 2022
        components.month = 1
        components.hour = 5
        let beginningOfYear = Calendar.current.date(from: components)!
        XCTAssertEqual(date.mp.beginning(of: .year).mp.day, beginningOfYear.mp.day)

        
        let beginningOfQuarter = Calendar.current.date(from: components)!
        XCTAssertEqual(date.mp.beginning(of: .quarter).mp.day, beginningOfQuarter.mp.day)
        #endif
    }
    
    func testEnd() {
        let date = Date(timeIntervalSince1970: 512) // January 1, 1970 at 2:08:32 AM GMT+2
        XCTAssertEqual(date.mp.end(of: .second).mp.second, 32)
        XCTAssertEqual(date.mp.end(of: .hour).mp.minute, 59)
        XCTAssertEqual(date.mp.end(of: .minute).mp.second, 59)

        XCTAssertEqual(date.mp.end(of: .day).mp.hour, 23)
        XCTAssertEqual(date.mp.end(of: .day).mp.minute, 59)
        XCTAssertEqual(date.mp.end(of: .day).mp.second, 59)

        #if !os(Linux)
        let endOfWeek = date.mp.beginning(of: .weekOfYear)
            .mp.adding(.day, value: 7)
            .mp.adding(.second, value: -1)
        XCTAssertEqual(date.mp.end(of: .weekOfYear), endOfWeek)
        #endif

        XCTAssertEqual(date.mp.end(of: .month).mp.day, 31)
        XCTAssertEqual(date.mp.end(of: .month).mp.hour, 23)
        XCTAssertEqual(date.mp.end(of: .month).mp.minute, 59)
        XCTAssertEqual(date.mp.end(of: .month).mp.second, 59)

        XCTAssertEqual(date.mp.end(of: .year).mp.month, 12)
        XCTAssertEqual(date.mp.end(of: .year).mp.day, 31)
        XCTAssertEqual(date.mp.end(of: .year).mp.hour, 23)
        XCTAssertEqual(date.mp.end(of: .year).mp.minute, 59)
        XCTAssertEqual(date.mp.end(of: .year).mp.second, 59)

        XCTAssertEqual(date.mp.end(of: .quarter).mp.year, 1970)
      }
    
    func testIsInCurrent() {
        let date = Date()
        let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        XCTAssert(date.mp.isInCurrent(.second))
        XCTAssertFalse(oldDate.mp.isInCurrent(.second))
        
        XCTAssert(date.mp.isInCurrent(.minute))
        XCTAssertFalse(oldDate.mp.isInCurrent(.minute))
        
        XCTAssert(date.mp.isInCurrent(.hour))
        XCTAssertFalse(oldDate.mp.isInCurrent(.hour))
        
        XCTAssert(date.mp.isInCurrent(.day))
        XCTAssertFalse(oldDate.mp.isInCurrent(.day))
        
        XCTAssert(date.mp.isInCurrent(.weekOfMonth))
        XCTAssertFalse(oldDate.mp.isInCurrent(.weekOfMonth))
        
        XCTAssert(date.mp.isInCurrent(.month))
        XCTAssertFalse(oldDate.mp.isInCurrent(.month))
        
        XCTAssert(date.mp.isInCurrent(.year))
        XCTAssertFalse(oldDate.mp.isInCurrent(.year))
        
        XCTAssert(date.mp.isInCurrent(.era))
    }
    
    func testCompareComponents() {
        let base = Date()
        let end1 = base.mp.adding(.second, value: 1)
        let result1 = base.mp.compare([.second], to: end1).second
        XCTAssertEqual(result1, 1)
        
        let end2 = base.mp.adding(.minute, value: 1)
        let result2 = base.mp.compare([.minute], to: end2).minute
        XCTAssertEqual(result2, 1)
        
        let end3 = base.mp.adding(.hour, value: 1)
        let result3 = base.mp.compare([.hour], to: end3).hour
        XCTAssertEqual(result3, 1)
        
        let end4 = base.mp.adding(.day, value: 1)
        let result4 = base.mp.compare([.day], to: end4).day
        XCTAssertEqual(result4, 1)
        
        let end5 = base.mp.adding(.month, value: 1)
        let result5 = base.mp.compare([.month], to: end5).month
        XCTAssertEqual(result5, 1)
        
        let end6 = base.mp.adding(.quarter, value: 1)
        let result6 = base.mp.compare([.month], to: end6).month
        XCTAssertEqual(result6, 3)
        
        let end7 = base.mp.adding(.year, value: 1)
        let result7 = base.mp.compare([.year], to: end7).year
        XCTAssertEqual(result7, 1)
        
        let end8 = base.mp.adding(.weekOfYear, value: 1)
        let result8 = base.mp.compare([.weekOfYear], to: end8).weekOfYear
        XCTAssertEqual(result8, 1)
    }
    
    func testDifferComponent() {
        let base = Date()
        let end1 = base.mp.adding(.second, value: 1)
        let result1 = base.mp.differ(.second, to: end1)
        XCTAssertEqual(result1, 1)
        
        let end2 = base.mp.adding(.minute, value: 1)
        let result2 = base.mp.differ(.minute, to: end2)
        XCTAssertEqual(result2, 1)
        
        let end3 = base.mp.adding(.hour, value: 1)
        let result3 = base.mp.differ(.hour, to: end3)
        XCTAssertEqual(result3, 1)
        
        let end4 = base.mp.adding(.day, value: 1)
        let result4 = base.mp.differ(.day, to: end4)
        XCTAssertEqual(result4, 1)
        
        let end5 = base.mp.adding(.month, value: 1)
        let result5 = base.mp.differ(.month, to: end5)
        XCTAssertEqual(result5, 1)
        
        let end6 = base.mp.adding(.quarter, value: 1)
        let result6 = base.mp.differ(.quarter, to: end6)
        XCTAssertEqual(result6, 1)
        
        let end7 = base.mp.adding(.year, value: 1)
        let result7 = base.mp.differ(.year, to: end7)
        XCTAssertEqual(result7, 1)
        
        let end8 = base.mp.adding(.weekOfYear, value: 1)
        let result8 = base.mp.differ(.weekOfYear, to: end8)
        XCTAssertEqual(result8, 1)
    }
}
