//
//  FloatingPointExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("FloatingPoint Extensions Test Suite")
struct FloatingPointExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("FloatingPoint should have mp property")
    func testFloatingPointHasMPProperty() {
        let double: Double = 3.14
        let wrapper = double.mp
        #expect(wrapper.base == double)
    }
    
    // MARK: - Property: abs
    
    @Test("abs should return absolute value")
    func testAbs() {
        #expect((-3.14).mp.abs == 3.14)
        #expect(3.14.mp.abs == 3.14)
        #expect(0.0.mp.abs == 0.0)
        #expect((-0.0).mp.abs == 0.0)
    }
    
    // MARK: - Property: isPositive
    
    @Test("isPositive should check if number is positive")
    func testIsPositive() {
        #expect(3.14.mp.isPositive == true)
        #expect(0.1.mp.isPositive == true)
        #expect(0.0.mp.isPositive == false)
        #expect((-3.14).mp.isPositive == false)
    }
    
    // MARK: - Property: isNegative
    
    @Test("isNegative should check if number is negative")
    func testIsNegative() {
        #expect((-3.14).mp.isNegative == true)
        #expect((-0.1).mp.isNegative == true)
        #expect(0.0.mp.isNegative == false)
        #expect(3.14.mp.isNegative == false)
    }
    
    // MARK: - Property: ceil
    
    @Test("ceil should return ceiling value")
    func testCeil() {
        #expect(3.1.mp.ceil == 4.0)
        #expect(3.9.mp.ceil == 4.0)
        #expect(3.0.mp.ceil == 3.0)
        #expect((-3.1).mp.ceil == -3.0)
        #expect((-3.9).mp.ceil == -3.0)
    }
    
    // MARK: - Property: floor
    
    @Test("floor should return floor value")
    func testFloor() {
        #expect(3.1.mp.floor == 3.0)
        #expect(3.9.mp.floor == 3.0)
        #expect(3.0.mp.floor == 3.0)
        #expect((-3.1).mp.floor == -4.0)
        #expect((-3.9).mp.floor == -4.0)
    }
    
    // MARK: - Property: degreesToRadians
    
    @Test("degreesToRadians should convert degrees to radians")
    func testDegreesToRadians() {
        #expect(abs(180.0.mp.degreesToRadians - Double.pi) < 0.0001)
        #expect(abs(90.0.mp.degreesToRadians - Double.pi / 2) < 0.0001)
        #expect(abs(0.0.mp.degreesToRadians - 0.0) < 0.0001)
        #expect(abs(360.0.mp.degreesToRadians - 2 * Double.pi) < 0.0001)
    }
    
    // MARK: - Property: radiansToDegrees
    
    @Test("radiansToDegrees should convert radians to degrees")
    func testRadiansToDegrees() {
        #expect(abs(Double.pi.mp.radiansToDegrees - 180.0) < 0.0001)
        #expect(abs((Double.pi / 2).mp.radiansToDegrees - 90.0) < 0.0001)
        #expect(abs(0.0.mp.radiansToDegrees - 0.0) < 0.0001)
    }
    
    // MARK: - Operator: ± (infix)
    
    @Test("plus-minus infix operator should return tuple")
    func testPlusMinusInfixOperator() {
        let result1 = 2.5 ± 1.5
        #expect(abs(result1.0 - 4.0) < 0.0001)
        #expect(abs(result1.1 - 1.0) < 0.0001)
        
        let result2 = 10.0 ± 5.0
        #expect(abs(result2.0 - 15.0) < 0.0001)
        #expect(abs(result2.1 - 5.0) < 0.0001)
    }
    
    // MARK: - Operator: ± (prefix)
    
    @Test("plus-minus prefix operator should return tuple")
    func testPlusMinusPrefixOperator() {
        let result1 = ±2.5
        #expect(abs(result1.0 - 2.5) < 0.0001)
        #expect(abs(result1.1 - (-2.5)) < 0.0001)
        
        let result2 = ±10.0
        #expect(abs(result2.0 - 10.0) < 0.0001)
        #expect(abs(result2.1 - (-10.0)) < 0.0001)
    }
    
    // MARK: - Operator: √
    
    @Test("square root operator should calculate square root")
    func testSquareRootOperator() {
        #expect(abs(√4.0 - 2.0) < 0.0001)
        #expect(abs(√9.0 - 3.0) < 0.0001)
        #expect(abs(√16.0 - 4.0) < 0.0001)
        #expect(abs(√25.0 - 5.0) < 0.0001)
        #expect(abs(√0.0 - 0.0) < 0.0001)
    }
}
