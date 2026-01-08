//
//  DecimalExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class DecimalExtensionsTests: XCTestCase {
    
    func testInt() {
        XCTAssertEqual(Decimal(123).mp.int, 123)
        XCTAssertEqual(Decimal(-456).mp.int, -456)
        XCTAssertEqual(Decimal(4.9).mp.int, 4)
        XCTAssertEqual(Decimal(-4.9).mp.int, -4)
    }
    
    func testDouble() {
        XCTAssertEqual(Decimal(123).mp.double, 123.0, accuracy: 0.00001)
        XCTAssertEqual(Decimal(-456.789).mp.double, -456.789, accuracy: 0.00001)
        XCTAssertEqual(Decimal(4.3).mp.double, 4.3, accuracy: 0.00001)
    }
    
    func testCGFloat() {
        #if canImport(CoreGraphics)
        XCTAssertEqual(Decimal(4.3).mp.cgFloat, CGFloat(4.3), accuracy: 0.00001)
        XCTAssertEqual(Decimal(-1.5).mp.cgFloat, CGFloat(-1.5), accuracy: 0.00001)
        #endif
    }
    
    func testIsZero() {
        XCTAssertTrue(Decimal(0).mp.isZero)
        XCTAssertTrue(Decimal(0.0).mp.isZero)
        XCTAssertFalse(Decimal(1).mp.isZero)
        XCTAssertFalse(Decimal(-1).mp.isZero)
        XCTAssertFalse(Decimal(0.1).mp.isZero)
    }
    
    func testIsPositive() {
        XCTAssertTrue(Decimal(1).mp.isPositive)
        XCTAssertTrue(Decimal(0.1).mp.isPositive)
        XCTAssertTrue(Decimal(100).mp.isPositive)
        XCTAssertFalse(Decimal(0).mp.isPositive)
        XCTAssertFalse(Decimal(-1).mp.isPositive)
        XCTAssertFalse(Decimal(-0.1).mp.isPositive)
    }
    
    func testIsNegative() {
        XCTAssertTrue(Decimal(-1).mp.isNegative)
        XCTAssertTrue(Decimal(-0.1).mp.isNegative)
        XCTAssertTrue(Decimal(-100).mp.isNegative)
        XCTAssertFalse(Decimal(0).mp.isNegative)
        XCTAssertFalse(Decimal(1).mp.isNegative)
        XCTAssertFalse(Decimal(0.1).mp.isNegative)
    }
    
    func testRounded() {
        // Test rounding to 2 decimal places
        let value1 = Decimal(123.456)
        let rounded1 = value1.mp.rounded(scale: 2)
        XCTAssertEqual(rounded1.mp.double, 123.46, accuracy: 0.00001)
        
        // Test rounding to 0 decimal places (integer)
        let value2 = Decimal(123.456)
        let rounded2 = value2.mp.rounded(scale: 0)
        XCTAssertEqual(rounded2.mp.double, 123.0, accuracy: 0.00001)
        
        // Test rounding with different modes
        let value3 = Decimal(123.455)
        let rounded3 = value3.mp.rounded(scale: 2, mode: .plain)
        XCTAssertEqual(rounded3.mp.double, 123.46, accuracy: 0.00001)
        
        // Test rounding down
        let value4 = Decimal(123.456)
        let rounded4 = value4.mp.rounded(scale: 2, mode: .down)
        XCTAssertEqual(rounded4.mp.double, 123.45, accuracy: 0.00001)
        
        // Test rounding up
        let value5 = Decimal(123.451)
        let rounded5 = value5.mp.rounded(scale: 2, mode: .up)
        XCTAssertEqual(rounded5.mp.double, 123.46, accuracy: 0.00001)
        
        // Test negative values
        let value6 = Decimal(-123.456)
        let rounded6 = value6.mp.rounded(scale: 2)
        XCTAssertEqual(rounded6.mp.double, -123.46, accuracy: 0.00001)
    }
}

