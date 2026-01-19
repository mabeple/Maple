//
//  BinaryFloatingPointExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(Foundation)
final class BinaryFloatingPointExtensionsTests: XCTestCase {
    func testRounded() {
        let num = 3.1415927
        
        // Test with different decimal places
        XCTAssertEqual(num.mp.rounded(numberOfDecimalPlaces: 3, rule: .up), 3.142, accuracy: 0.0001)
        XCTAssertEqual(num.mp.rounded(numberOfDecimalPlaces: 3, rule: .down), 3.141, accuracy: 0.0001)
        XCTAssertEqual(num.mp.rounded(numberOfDecimalPlaces: 2, rule: .awayFromZero), 3.15, accuracy: 0.0001)
        XCTAssertEqual(num.mp.rounded(numberOfDecimalPlaces: 4, rule: .towardZero), 3.1415, accuracy: 0.0001)
        XCTAssertEqual(num.mp.rounded(numberOfDecimalPlaces: -1, rule: .toNearestOrEven), 3.0, accuracy: 0.0001)
        
        // Test with Float
        let floatNum: Float = 3.1415927
        XCTAssertEqual(floatNum.mp.rounded(numberOfDecimalPlaces: 3, rule: .up), 3.142, accuracy: 0.0001)
        XCTAssertEqual(floatNum.mp.rounded(numberOfDecimalPlaces: 3, rule: .down), 3.141, accuracy: 0.0001)
        
        // Test with CGFloat
        #if canImport(CoreGraphics)
        let cgFloatNum: CGFloat = 3.1415927
        XCTAssertEqual(cgFloatNum.mp.rounded(numberOfDecimalPlaces: 3, rule: .up), 3.142, accuracy: 0.0001)
        XCTAssertEqual(cgFloatNum.mp.rounded(numberOfDecimalPlaces: 3, rule: .down), 3.141, accuracy: 0.0001)
        #endif
        
        // Test edge cases
        XCTAssertEqual(0.0.mp.rounded(numberOfDecimalPlaces: 2, rule: .toNearestOrEven), 0.0)
        XCTAssertEqual((-3.1415927).mp.rounded(numberOfDecimalPlaces: 2, rule: .awayFromZero), -3.15, accuracy: 0.0001)
        XCTAssertEqual((-3.1415927).mp.rounded(numberOfDecimalPlaces: 2, rule: .towardZero), -3.14, accuracy: 0.0001)
    }
}
#endif
