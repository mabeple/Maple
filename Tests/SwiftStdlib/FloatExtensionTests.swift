//
//  FloatExtensionTests.swift
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

@Suite("Float Extensions Test Suite")
struct FloatExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Float should conform to MapleCompatibleValue")
    func testFloatConformsToMapleCompatibleValue() {
        let float: Float = 42.0
        let wrapper = float.mp
        #expect(wrapper.base == float)
        #expect(type(of: wrapper) == MapleWrapper<Float>.self)
    }
    
    // MARK: - Property: int
    
    @Test("int should convert Float to Int")
    func testInt() {
        #expect(Float(42.0).mp.int == 42)
        #expect(Float(3.14).mp.int == 3)
        #expect(Float(0.0).mp.int == 0)
        #expect(Float(-5.9).mp.int == -5)
    }
    
    // MARK: - Property: double
    
    @Test("double should convert Float to Double")
    func testDouble() {
        #expect(abs(Float(42.0).mp.double - 42.0) < 0.0001)
        #expect(abs(Float(3.14).mp.double - 3.14) < 0.0001)
        #expect(abs(Float(0.0).mp.double - 0.0) < 0.0001)
    }
    
    // MARK: - Property: cgFloat
    
    #if canImport(CoreGraphics)
    @Test("cgFloat should convert Float to CGFloat")
    func testCGFloat() {
        #expect(abs(Float(42.0).mp.cgFloat - 42.0) < 0.0001)
        #expect(abs(Float(3.14).mp.cgFloat - 3.14) < 0.0001)
        #expect(abs(Float(0.0).mp.cgFloat - 0.0) < 0.0001)
    }
    #endif
    
    // MARK: - Operator: **
    
    @Test("exponentiation operator should calculate power")
    func testExponentiationOperator() {
        #expect(abs((Float(4.4) ** Float(0.5)) - 2.0976176963) < 0.0001)
        #expect(abs((Float(2.0) ** Float(3.0)) - 8.0) < 0.0001)
        #expect(abs((Float(5.0) ** Float(0.0)) - 1.0) < 0.0001)
        #expect(abs((Float(10.0) ** Float(2.0)) - 100.0) < 0.0001)
    }
}
