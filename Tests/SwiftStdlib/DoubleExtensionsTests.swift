//
//  DoubleExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class DoubleExtensionsTests: XCTestCase {
    
    func testInt() {
        XCTAssertEqual(Double(-1).mp.int, -1)
        XCTAssertEqual(Double(2).mp.int, 2)
        XCTAssertEqual(Double(4.3).mp.int, 4)
        XCTAssertEqual(Double(4.9).mp.int, 4)
        XCTAssertEqual(Double(-4.9).mp.int, -4)
    }
    
    func testFloat() {
        XCTAssertEqual(Double(-1).mp.float, Float(-1))
        XCTAssertEqual(Double(2).mp.float, Float(2))
        XCTAssertEqual(Double(4.3).mp.float, Float(4.3), accuracy: 0.00001)
    }
    
    func testCGFloat() {
        #if canImport(CoreGraphics)
        XCTAssertEqual(Double(4.3).mp.cgFloat, CGFloat(4.3), accuracy: 0.00001)
        XCTAssertEqual(Double(-1.5).mp.cgFloat, CGFloat(-1.5), accuracy: 0.00001)
        #endif
    }
    
    func testPowerOperator() {
        XCTAssertEqual(4.4 ** 0.5, pow(4.4, 0.5), accuracy: 0.00001)
        XCTAssertEqual(2.0 ** 3.0, 8.0, accuracy: 0.00001)
        XCTAssertEqual(5.0 ** 2.0, 25.0, accuracy: 0.00001)
        XCTAssertEqual(10.0 ** 0.0, 1.0, accuracy: 0.00001)
    }
}

