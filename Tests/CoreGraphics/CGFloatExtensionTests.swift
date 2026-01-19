//
//  CGFloatExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(CoreGraphics)
import CoreGraphics
import Testing
@testable import Maple

#if canImport(Foundation)
import Foundation
#endif

@Suite("CGFloat Extensions Test Suite")
struct CGFloatExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("CGFloat should conform to MapleCompatibleValue")
    func testCGFloatConformsToMapleCompatibleValue() {
        let value: CGFloat = 10.5
        let wrapper = value.mp
        #expect(wrapper.base == 10.5)
    }
    
    // MARK: - Property: abs
    
    @Test("abs should return absolute value")
    func testAbs() {
        #expect((CGFloat(-5.5)).mp.abs == 5.5)
        #expect(CGFloat(5.5).mp.abs == 5.5)
        #expect(CGFloat(0.0).mp.abs == 0.0)
        #expect((CGFloat(-0.0)).mp.abs == 0.0)
    }
    
    #if canImport(Foundation)
    // MARK: - Property: ceil
    
    @Test("ceil should return ceiling value")
    func testCeil() {
        #expect(CGFloat(5.1).mp.ceil == 6.0)
        #expect(CGFloat(5.9).mp.ceil == 6.0)
        #expect(CGFloat(5.0).mp.ceil == 5.0)
        #expect(CGFloat(-5.1).mp.ceil == -5.0)
        #expect(CGFloat(-5.9).mp.ceil == -5.0)
    }
    #endif
    
    // MARK: - Property: degreesToRadians
    
    @Test("degreesToRadians should convert degrees to radians")
    func testDegreesToRadians() {
        let tolerance: CGFloat = 0.0001
        #expect(abs(CGFloat(0.0).mp.degreesToRadians - 0.0) < tolerance)
        #expect(abs(CGFloat(90.0).mp.degreesToRadians - CGFloat.pi / 2) < tolerance)
        #expect(abs(CGFloat(180.0).mp.degreesToRadians - CGFloat.pi) < tolerance)
        #expect(abs(CGFloat(360.0).mp.degreesToRadians - 2 * CGFloat.pi) < tolerance)
        #expect(abs(CGFloat(45.0).mp.degreesToRadians - CGFloat.pi / 4) < tolerance)
    }
    
    #if canImport(Foundation)
    // MARK: - Property: floor
    
    @Test("floor should return floor value")
    func testFloor() {
        #expect(CGFloat(5.1).mp.floor == 5.0)
        #expect(CGFloat(5.9).mp.floor == 5.0)
        #expect(CGFloat(5.0).mp.floor == 5.0)
        #expect(CGFloat(-5.1).mp.floor == -6.0)
        #expect(CGFloat(-5.9).mp.floor == -6.0)
    }
    #endif
    
    // MARK: - Property: isPositive
    
    @Test("isPositive should check if value is positive")
    func testIsPositive() {
        #expect(CGFloat(5.5).mp.isPositive == true)
        #expect(CGFloat(0.1).mp.isPositive == true)
        #expect(CGFloat(0.0).mp.isPositive == false)
        #expect(CGFloat(-5.5).mp.isPositive == false)
    }
    
    // MARK: - Property: isNegative
    
    @Test("isNegative should check if value is negative")
    func testIsNegative() {
        #expect(CGFloat(-5.5).mp.isNegative == true)
        #expect(CGFloat(-0.1).mp.isNegative == true)
        #expect(CGFloat(0.0).mp.isNegative == false)
        #expect(CGFloat(5.5).mp.isNegative == false)
    }
    
    // MARK: - Property: int
    
    @Test("int should convert to Int")
    func testInt() {
        #expect(CGFloat(5.5).mp.int == 5)
        #expect(CGFloat(5.9).mp.int == 5)
        #expect(CGFloat(5.0).mp.int == 5)
        #expect(CGFloat(-5.5).mp.int == -5)
        #expect(CGFloat(-5.9).mp.int == -5)
    }
    
    // MARK: - Property: float
    
    @Test("float should convert to Float")
    func testFloat() {
        #expect(CGFloat(5.5).mp.float == 5.5)
        #expect(CGFloat(10.25).mp.float == 10.25)
        #expect(CGFloat(-5.5).mp.float == -5.5)
    }
    
    // MARK: - Property: double
    
    @Test("double should convert to Double")
    func testDouble() {
        #expect(CGFloat(5.5).mp.double == 5.5)
        #expect(CGFloat(10.25).mp.double == 10.25)
        #expect(CGFloat(-5.5).mp.double == -5.5)
    }
    
    // MARK: - Property: radiansToDegrees
    
    @Test("radiansToDegrees should convert radians to degrees")
    func testRadiansToDegrees() {
        let tolerance: CGFloat = 0.0001
        #expect(abs(CGFloat(0.0).mp.radiansToDegrees - 0.0) < tolerance)
        #expect(abs((CGFloat.pi / 2).mp.radiansToDegrees - 90.0) < tolerance)
        #expect(abs(CGFloat.pi.mp.radiansToDegrees - 180.0) < tolerance)
        #expect(abs((2 * CGFloat.pi).mp.radiansToDegrees - 360.0) < tolerance)
        #expect(abs((CGFloat.pi / 4).mp.radiansToDegrees - 45.0) < tolerance)
    }
}

#endif
