//
//  DecimalExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

#if canImport(CoreGraphics)
import CoreGraphics
#endif

@Suite("Decimal Extensions Test Suite")
struct DecimalExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Decimal should conform to MapleCompatibleValue")
    func testDecimalConformsToMapleCompatibleValue() {
        let decimal = Decimal(42)
        let wrapper = decimal.mp
        #expect(wrapper.base == decimal)
        #expect(type(of: wrapper) == MapleWrapper<Decimal>.self)
    }
    
    // MARK: - Property: int
    
    @Test("int should convert Decimal to Int")
    func testInt() {
        #expect(Decimal(42).mp.int == 42)
        #expect(Decimal(0).mp.int == 0)
        #expect(Decimal(100).mp.int == 100)
        #expect(Decimal(3.14).mp.int == 3)
        #expect(Decimal(-5.9).mp.int == -5)
    }
    
    // MARK: - Property: double
    
    @Test("double should convert Decimal to Double")
    func testDouble() {
        #expect(abs(Decimal(42).mp.double - 42.0) < 0.0001)
        #expect(abs(Decimal(3.14).mp.double - 3.14) < 0.0001)
        #expect(abs(Decimal(0).mp.double - 0.0) < 0.0001)
    }
    
    // MARK: - Property: cgFloat
    
    #if canImport(CoreGraphics)
    @Test("cgFloat should convert Decimal to CGFloat")
    func testCGFloat() {
        #expect(abs(Decimal(42).mp.cgFloat - 42.0) < 0.0001)
        #expect(abs(Decimal(3.14).mp.cgFloat - 3.14) < 0.0001)
        #expect(abs(Decimal(0).mp.cgFloat - 0.0) < 0.0001)
    }
    #endif
    
    // MARK: - Property: isZero
    
    @Test("isZero should check if Decimal is zero")
    func testIsZero() {
        #expect(Decimal(0).mp.isZero == true)
        #expect(Decimal(42).mp.isZero == false)
        #expect(Decimal(-5).mp.isZero == false)
        #expect(Decimal(0.0).mp.isZero == true)
    }
    
    // MARK: - Property: isPositive
    
    @Test("isPositive should check if Decimal is positive")
    func testIsPositive() {
        #expect(Decimal(42).mp.isPositive == true)
        #expect(Decimal(0.1).mp.isPositive == true)
        #expect(Decimal(0).mp.isPositive == false)
        #expect(Decimal(-5).mp.isPositive == false)
    }
    
    // MARK: - Property: isNegative
    
    @Test("isNegative should check if Decimal is negative")
    func testIsNegative() {
        #expect(Decimal(-5).mp.isNegative == true)
        #expect(Decimal(-0.1).mp.isNegative == true)
        #expect(Decimal(0).mp.isNegative == false)
        #expect(Decimal(42).mp.isNegative == false)
    }
    
    // MARK: - Method: rounded
    
    @Test("rounded should round to specified decimal places")
    func testRounded() {
        let value1 = Decimal(3.14159)
        let rounded1 = value1.mp.rounded(scale: 2)
        #expect(abs(rounded1.mp.double - 3.14) < 0.01)
        
        let value2 = Decimal(3.145)
        let rounded2 = value2.mp.rounded(scale: 2)
        #expect(abs(rounded2.mp.double - 3.15) < 0.01)
        
        let value3 = Decimal(3.14159)
        let rounded3 = value3.mp.rounded(scale: 0)
        #expect(abs(rounded3.mp.double - 3.0) < 0.1)
        
        let value4 = Decimal(2.5)
        let rounded4 = value4.mp.rounded(scale: 0, mode: .plain)
        #expect(abs(rounded4.mp.double - 3.0) < 0.1)
        
        let value5 = Decimal(2.5)
        let rounded5 = value5.mp.rounded(scale: 0, mode: .down)
        #expect(abs(rounded5.mp.double - 2.0) < 0.1)
        
        let value6 = Decimal(2.5)
        let rounded6 = value6.mp.rounded(scale: 0, mode: .up)
        #expect(abs(rounded6.mp.double - 3.0) < 0.1)
    }
}
