//
//  FloatExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class FloatExtensionsTests: XCTestCase {
    func testInt() {
        XCTAssertEqual(Float(-1).mp.int, -1)
        XCTAssertEqual(Float(2).mp.int, 2)
        XCTAssertEqual(Float(4.3).mp.int, 4)
    }

    func testDouble() {
        XCTAssertEqual(Float(-1).mp.double, Double(-1))
        XCTAssertEqual(Float(2).mp.double, Double(2))
        XCTAssertEqual(Float(4.3).mp.double, Double(4.3), accuracy: 0.00001)
    }

    func testCGFloat() {
        #if canImport(CoreGraphics)
        XCTAssertEqual(Float(4.3).mp.cgFloat, CGFloat(4.3), accuracy: 0.00001)
        #endif
    }

    func testOperators() {
        XCTAssertEqual(Float(5.0) ** Float(2.0), Float(25.0))
    }
}
