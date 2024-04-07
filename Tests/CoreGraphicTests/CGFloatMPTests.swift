//
//  CGFloatMPTests.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(CoreGraphics)
import CoreGraphics

class CGFloatExtensionsTests: XCTestCase {
    func testAbs() {
        XCTAssertEqual(CGFloat(-9.3).mp.abs, CGFloat(9.3))
    }

    func testCeil() {
        XCTAssertEqual(CGFloat(9.3).mp.ceil, CGFloat(10.0))
    }

    func testDegreesToRadians() {
        XCTAssertEqual(CGFloat(180).mp.degreesToRadians, CGFloat.pi)
    }

    func testIsPositive() {
        XCTAssert(CGFloat(9.3).mp.isPositive)
        XCTAssertFalse(CGFloat(0).mp.isPositive)
        XCTAssertFalse(CGFloat(-9.2).mp.isPositive)
    }

    func testIsNegative() {
        XCTAssert(CGFloat(-9.3).mp.isNegative)
        XCTAssertFalse(CGFloat(0).mp.isNegative)
        XCTAssertFalse(CGFloat(9.3).mp.isNegative)
    }

    func testInt() {
        XCTAssertEqual(CGFloat(9.3).mp.int, Int(9))
    }

    func testDouble() {
        XCTAssertEqual(CGFloat(9.3).mp.double, Double(9.3))
    }

    func testFloat() {
        XCTAssertEqual(CGFloat(9.3).mp.float, Float(9.3))
    }

    func testFloor() {
        XCTAssertEqual(CGFloat(9.3).mp.floor, CGFloat(9.0))
    }

    func testRadiansToDegrees() {
        XCTAssertEqual(CGFloat.pi.mp.radiansToDegrees, CGFloat(180))
    }
}

#endif
