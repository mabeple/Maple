//
//  FloatingPointExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

final class FloatingPointExtensionsTests: XCTestCase {
    func testAbs() {
        XCTAssertEqual(Float(-9.3).mp.abs, Float(9.3))
        XCTAssertEqual(Double(-9.3).mp.abs, Double(9.3))
    }
    
    func testIsPositive() {
        XCTAssert(Float(1).mp.isPositive)
        XCTAssertFalse(Float(0).mp.isPositive)
        XCTAssertFalse(Float(-1).mp.isPositive)
        
        XCTAssert(Double(1).mp.isPositive)
        XCTAssertFalse(Double(0).mp.isPositive)
        XCTAssertFalse(Double(-1).mp.isPositive)
    }
    
    func testIsNegative() {
        XCTAssert(Float(-1).mp.isNegative)
        XCTAssertFalse(Float(0).mp.isNegative)
        XCTAssertFalse(Float(1).mp.isNegative)
        
        XCTAssert(Double(-1).mp.isNegative)
        XCTAssertFalse(Double(0).mp.isNegative)
        XCTAssertFalse(Double(1).mp.isNegative)
    }
    
    func testCeil() {
        XCTAssertEqual(Float(-1.0).mp.ceil, Float(-1.0))
        XCTAssertEqual(Float(-0.75).mp.ceil, Float(0.0))
        XCTAssertEqual(Float(-0.5).mp.ceil, Float(0.0))
        XCTAssertEqual(Float(-0.25).mp.ceil, Float(0.0))
        XCTAssertEqual(Float(-0.0).mp.ceil, Float(0.0))
        XCTAssertEqual(Float(0.0).mp.ceil, Float(0.0))
        XCTAssertEqual(Float(0.25).mp.ceil, Float(1.0))
        XCTAssertEqual(Float(0.5).mp.ceil, Float(1.0))
        XCTAssertEqual(Float(0.75).mp.ceil, Float(1.0))
        XCTAssertEqual(Float(1.0).mp.ceil, Float(1.0))
        
        XCTAssertEqual(Double(-1.0).mp.ceil, Double(-1.0))
        XCTAssertEqual(Double(-0.75).mp.ceil, Double(0.0))
        XCTAssertEqual(Double(-0.5).mp.ceil, Double(0.0))
        XCTAssertEqual(Double(-0.25).mp.ceil, Double(0.0))
        XCTAssertEqual(Double(-0.0).mp.ceil, Double(0.0))
        XCTAssertEqual(Double(0.0).mp.ceil, Double(0.0))
        XCTAssertEqual(Double(0.25).mp.ceil, Double(1.0))
        XCTAssertEqual(Double(0.5).mp.ceil, Double(1.0))
        XCTAssertEqual(Double(0.75).mp.ceil, Double(1.0))
        XCTAssertEqual(Double(1.0).mp.ceil, Double(1.0))
    }
    
    func testFloor() {
        XCTAssertEqual(Float(-1.0).mp.floor, Float(-1.0))
        XCTAssertEqual(Float(-0.75).mp.floor, Float(-1.0))
        XCTAssertEqual(Float(-0.5).mp.floor, Float(-1.0))
        XCTAssertEqual(Float(-0.25).mp.floor, Float(-1.0))
        XCTAssertEqual(Float(-0.0).mp.floor, Float(0.0))
        XCTAssertEqual(Float(0.0).mp.floor, Float(0.0))
        XCTAssertEqual(Float(0.25).mp.floor, Float(0.0))
        XCTAssertEqual(Float(0.5).mp.floor, Float(0.0))
        XCTAssertEqual(Float(0.75).mp.floor, Float(0.0))
        XCTAssertEqual(Float(1.0).mp.floor, Float(1.0))
        
        XCTAssertEqual(Double(-1.0).mp.floor, Double(-1.0))
        XCTAssertEqual(Double(-0.75).mp.floor, Double(-1.0))
        XCTAssertEqual(Double(-0.5).mp.floor, Double(-1.0))
        XCTAssertEqual(Double(-0.25).mp.floor, Double(-1.0))
        XCTAssertEqual(Double(-0.0).mp.floor, Double(0.0))
        XCTAssertEqual(Double(0.0).mp.floor, Double(0.0))
        XCTAssertEqual(Double(0.25).mp.floor, Double(0.0))
        XCTAssertEqual(Double(0.5).mp.floor, Double(0.0))
        XCTAssertEqual(Double(0.75).mp.floor, Double(0.0))
        XCTAssertEqual(Double(1.0).mp.floor, Double(1.0))
    }
    
    func testRadiansToDegrees() {
        XCTAssertEqual(Float.pi.mp.radiansToDegrees, Float(180))
        XCTAssertEqual(Double.pi.mp.radiansToDegrees, Double(180))
    }
    
    func testOperators() {
        XCTAssert((Float(5.0) ± Float(2.0)) == (Float(3.0), Float(7.0)) || (Float(5.0) ± Float(2.0)) ==
                  (Float(7.0), Float(3.0)))
        XCTAssert((±Float(2.0)) == (Float(2.0), Float(-2.0)) || ±Float(2.0) == (Float(-2.0), Float(2.0)))
        XCTAssertEqual(√Float(25.0), Float(5.0))
        
        XCTAssert((Double(5.0) ± Double(2.0)) == (Double(3.0), Double(7.0)) || (Double(5.0) ± Double(2.0)) ==
                  (Double(7.0), Double(3.0)))
        XCTAssert((±Double(2.0)) == (Double(2.0), Double(-2.0)) || ±Double(2.0) == (Double(-2.0), Double(2.0)))
        XCTAssertEqual(√Double(25.0), Double(5.0))
    }
}
