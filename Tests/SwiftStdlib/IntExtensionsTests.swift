//
//  IntExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class IntExtensionsTests: XCTestCase {
    func testCountableRange() {
        XCTAssertEqual(10.mp.countableRange, 0..<10)
    }

    func testDegreesToRadians() {
        XCTAssertEqual(180.mp.degreesToRadians, Double.pi)
    }

    func testRadiansToDegrees() {
        XCTAssertEqual(Int(3.mp.radiansToDegrees), 171)
    }

    func testUInt() {
        XCTAssertEqual(Int(10).mp.uInt, UInt(10))
    }

    func testDouble() {
        XCTAssertEqual((-1).mp.double, Double(-1))
        XCTAssertEqual(2.mp.double, Double(2))
    }

    func testFloat() {
        XCTAssertEqual((-1).mp.float, Float(-1))
        XCTAssertEqual(2.mp.float, Float(2))
    }

    func testCGFloat() {
        #if canImport(CoreGraphics)
        XCTAssertEqual(1.mp.cgFloat, CGFloat(1))
        #endif
    }

    func testDigits() {
        let number = -123
        XCTAssertEqual(number.mp.digits, [1, 2, 3])
        XCTAssertEqual(123.mp.digits, [1, 2, 3])
        XCTAssertEqual(0.mp.digits, [0])
    }

    func testDigitsCount() {
        let number = -123
        XCTAssertEqual(number.mp.digitsCount, 3)
        XCTAssertEqual(180.mp.digitsCount, 3)
        XCTAssertEqual(0.mp.digitsCount, 1)
        XCTAssertEqual(1.mp.digitsCount, 1)
    }

    func testIsPrime() {
        // Prime number
        XCTAssert(2.mp.isPrime())
        XCTAssert(3.mp.isPrime())
        XCTAssert(7.mp.isPrime())
        XCTAssert(19.mp.isPrime())
        XCTAssert(577.mp.isPrime())
        XCTAssert(1999.mp.isPrime())

        // Composite number
        XCTAssertFalse(4.mp.isPrime())
        XCTAssertFalse(21.mp.isPrime())
        XCTAssertFalse(81.mp.isPrime())
        XCTAssertFalse(121.mp.isPrime())
        XCTAssertFalse(9409.mp.isPrime())

        // Others
        XCTAssertFalse((-1).mp.isPrime())
        XCTAssertFalse(0.mp.isPrime())
        XCTAssertFalse(1.mp.isPrime())
    }

    func testRomanNumeral() {
        XCTAssertEqual(10.mp.romanNumeral(), "X")
        XCTAssertEqual(2784.mp.romanNumeral(), "MMDCCLXXXIV")
        XCTAssertNil((-1).mp.romanNumeral())
    }

    func testRoundToNearest() {
        XCTAssertEqual(12.mp.roundToNearest(5), 10)
        XCTAssertEqual(63.mp.roundToNearest(25), 75)
        XCTAssertEqual(42.mp.roundToNearest(0), 42)
    }

    func testOperators() {
        XCTAssertEqual(5 ** 2, 25)
        XCTAssert((5 ± 2) == (3, 7) || (5 ± 2) == (7, 3))
        XCTAssert((±2) == (2, -2) || (-2, 2) == ±2)
        XCTAssertEqual(√25, 5.0)
    }
}
