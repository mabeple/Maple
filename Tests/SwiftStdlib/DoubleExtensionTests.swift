//
//  DoubleExtensionTests.swift
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

@Suite("Double Extensions Test Suite")
struct DoubleExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Double should conform to MapleCompatibleValue")
    func testDoubleConformsToMapleCompatibleValue() {
        let double = 42.0
        let wrapper = double.mp
        #expect(wrapper.base == double)
        #expect(type(of: wrapper) == MapleWrapper<Double>.self)
    }
    
    // MARK: - Property: int
    
    @Test("int should convert Double to Int")
    func testInt() {
        #expect(42.0.mp.int == 42)
        #expect(3.14.mp.int == 3)
        #expect(0.0.mp.int == 0)
        #expect(-5.9.mp.int == -5)
    }
    
    // MARK: - Property: float
    
    @Test("float should convert Double to Float")
    func testFloat() {
        #expect(abs(42.0.mp.float - 42.0) < 0.0001)
        #expect(abs(3.14.mp.float - 3.14) < 0.0001)
        #expect(abs(0.0.mp.float - 0.0) < 0.0001)
    }
    
    // MARK: - Property: cgFloat
    
    #if canImport(CoreGraphics)
    @Test("cgFloat should convert Double to CGFloat")
    func testCGFloat() {
        #expect(abs(42.0.mp.cgFloat - 42.0) < 0.0001)
        #expect(abs(3.14.mp.cgFloat - 3.14) < 0.0001)
        #expect(abs(0.0.mp.cgFloat - 0.0) < 0.0001)
    }
    #endif
    
    // MARK: - Operator: **
    
    @Test("exponentiation operator should calculate power")
    func testExponentiationOperator() {
        #expect(abs((4.4 ** 0.5) - 2.0976176963) < 0.0001)
        #expect(abs((2.0 ** 3.0) - 8.0) < 0.0001)
        #expect(abs((5.0 ** 0.0) - 1.0) < 0.0001)
        #expect(abs((10.0 ** 2.0) - 100.0) < 0.0001)
    }
}
