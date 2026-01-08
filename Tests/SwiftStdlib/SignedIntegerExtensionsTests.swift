//
//  SignedIntegerExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class SignedIntegerExtensionsTests: XCTestCase {
    func testAbs() {
        XCTAssertEqual((-9).mp.abs, 9)
    }

    func testIsPositive() {
        XCTAssert(1.mp.isPositive)
        XCTAssertFalse(0.mp.isPositive)
        XCTAssertFalse((-1).mp.isPositive)
    }

    func testIsNegative() {
        XCTAssert((-1).mp.isNegative)
        XCTAssertFalse(0.mp.isNegative)
        XCTAssertFalse(1.mp.isNegative)
    }

    func testIsEven() {
        XCTAssert(2.mp.isEven)
        XCTAssertFalse(3.mp.isEven)
    }

    func testIsOdd() {
        XCTAssert(3.mp.isOdd)
        XCTAssertFalse(2.mp.isOdd)
    }

    func testString() {
        XCTAssertEqual(2.mp.string, "2")
    }
}
