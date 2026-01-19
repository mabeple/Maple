//
//  CalendarExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Calendar Extensions Test Suite")
struct CalendarExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Calendar should conform to MapleCompatibleValue")
    func testCalendarConformsToMapleCompatibleValue() {
        let calendar = Calendar.current
        let wrapper = calendar.mp
        #expect(wrapper.base.identifier == calendar.identifier)
        #expect(type(of: wrapper) == MapleWrapper<Calendar>.self)
    }
    
    // MARK: - Method: numberOfDaysInMonth
    
    @Test("numberOfDaysInMonth should return correct number of days")
    func testNumberOfDaysInMonth() {
        let calendar = Calendar.current
        
        // Test January (31 days)
        let jan = calendar.date(from: DateComponents(year: 2024, month: 1, day: 15))!
        let janDays = calendar.mp.numberOfDaysInMonth(for: jan)
        #expect(janDays == 31)
        
        // Test February in leap year (29 days)
        let feb2024 = calendar.date(from: DateComponents(year: 2024, month: 2, day: 15))!
        let feb2024Days = calendar.mp.numberOfDaysInMonth(for: feb2024)
        #expect(feb2024Days == 29)
        
        // Test February in non-leap year (28 days)
        let feb2023 = calendar.date(from: DateComponents(year: 2023, month: 2, day: 15))!
        let feb2023Days = calendar.mp.numberOfDaysInMonth(for: feb2023)
        #expect(feb2023Days == 28)
        
        // Test April (30 days)
        let apr = calendar.date(from: DateComponents(year: 2024, month: 4, day: 15))!
        let aprDays = calendar.mp.numberOfDaysInMonth(for: apr)
        #expect(aprDays == 30)
        
        // Test December (31 days)
        let dec = calendar.date(from: DateComponents(year: 2024, month: 12, day: 15))!
        let decDays = calendar.mp.numberOfDaysInMonth(for: dec)
        #expect(decDays == 31)
        
        // Test with current date
        let now = Date()
        let currentMonthDays = calendar.mp.numberOfDaysInMonth(for: now)
        #expect(currentMonthDays >= 28 && currentMonthDays <= 31)
    }
}
