//
//  BoolExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class BoolExtensionsTests: XCTestCase {
    
    func testInt() {
        // Test true returns 1
        XCTAssertEqual(true.mp.int, 1)
        
        // Test false returns 0
        XCTAssertEqual(false.mp.int, 0)
    }
    
    func testString() {
        // Test true returns "true"
        XCTAssertEqual(true.mp.string, "true")
        
        // Test false returns "false"
        XCTAssertEqual(false.mp.string, "false")
    }
}

