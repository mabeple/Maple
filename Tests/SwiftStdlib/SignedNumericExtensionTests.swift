//
//  SignedNumericExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("SignedNumeric Extensions Test Suite")
struct SignedNumericExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("SignedNumeric should have mp property")
    func testSignedNumericHasMPProperty() {
        let int: Int = 42
        let wrapper = int.mp
        #expect(wrapper.base == int)
        
        let double: Double = 3.14
        let wrapper2 = double.mp
        #expect(wrapper2.base == double)
    }
    
    // MARK: - Property: string
    
    @Test("string should return string representation")
    func testString() {
        #expect(42.mp.string == "42")
        #expect((-42).mp.string == "-42")
        #expect(0.mp.string == "0")
        #expect(3.14.mp.string.contains("3.14"))
        #expect((-3.14).mp.string.contains("-3.14"))
    }
}
