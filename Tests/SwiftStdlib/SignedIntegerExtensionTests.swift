//
//  SignedIntegerExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("SignedInteger Extensions Test Suite")
struct SignedIntegerExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("SignedInteger should have mp property")
    func testSignedIntegerHasMPProperty() {
        let int: Int = 42
        let wrapper = int.mp
        #expect(wrapper.base == int)
    }
    
    // MARK: - Property: abs
    
    @Test("abs should return absolute value")
    func testAbs() {
        #expect((-5).mp.abs == 5)
        #expect(5.mp.abs == 5)
        #expect(0.mp.abs == 0)
    }
    
    // MARK: - Property: isPositive
    
    @Test("isPositive should check if integer is positive")
    func testIsPositive() {
        #expect(5.mp.isPositive == true)
        #expect(1.mp.isPositive == true)
        #expect(0.mp.isPositive == false)
        #expect((-5).mp.isPositive == false)
    }
    
    // MARK: - Property: isNegative
    
    @Test("isNegative should check if integer is negative")
    func testIsNegative() {
        #expect((-5).mp.isNegative == true)
        #expect((-1).mp.isNegative == true)
        #expect(0.mp.isNegative == false)
        #expect(5.mp.isNegative == false)
    }
    
    // MARK: - Property: isEven
    
    @Test("isEven should check if integer is even")
    func testIsEven() {
        #expect(0.mp.isEven == true)
        #expect(2.mp.isEven == true)
        #expect(4.mp.isEven == true)
        #expect((-2).mp.isEven == true)
        #expect(1.mp.isEven == false)
        #expect(3.mp.isEven == false)
        #expect((-1).mp.isEven == false)
    }
    
    // MARK: - Property: isOdd
    
    @Test("isOdd should check if integer is odd")
    func testIsOdd() {
        #expect(1.mp.isOdd == true)
        #expect(3.mp.isOdd == true)
        #expect((-1).mp.isOdd == true)
        #expect((-3).mp.isOdd == true)
        #expect(0.mp.isOdd == false)
        #expect(2.mp.isOdd == false)
        #expect((-2).mp.isOdd == false)
    }
}
