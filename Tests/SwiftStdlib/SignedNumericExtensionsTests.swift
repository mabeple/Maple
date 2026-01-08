//
//  SignedNumericExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class SignedNumericExtensionsTests: XCTestCase {
    func testString() {
        let number1: Double = -1.2
        XCTAssertEqual(number1.mp.string, "-1.2")

        let number2: Float = 2.3
        XCTAssertEqual(number2.mp.string, "2.3")
    }
}
