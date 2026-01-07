//
//  ComparableExtensionsTests.swift
//  Maple
//
//  Created by cy on 2024/9/23.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple
final class ComparableExtensionsTests: XCTestCase {
    func testIsBetween() {
        XCTAssertFalse(1.mp.isBetween(5...7), "number range")
        XCTAssert(7.mp.isBetween(6...12), "number range")
        XCTAssert(0.32.mp.isBetween(0.31...0.33), "float range")
        XCTAssert("c".mp.isBetween("a"..."d"), "string range")

        let date = Date()
        XCTAssert(date.mp.isBetween(date...date.addingTimeInterval(1000)), "date range")
    }

    func testClamped() {
        XCTAssertEqual(1.mp.clamped(to: 3...8), 3)
        XCTAssertEqual(4.mp.clamped(to: 3...7), 4)
        XCTAssertEqual("c".mp.clamped(to: "e"..."g"), "e")
        XCTAssertEqual(0.32.mp.clamped(to: 0.37...0.42), 0.37)
    }
}
