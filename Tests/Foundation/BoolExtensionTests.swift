//
//  BoolExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Bool Extensions Test Suite")
struct BoolExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Bool should conform to MapleCompatibleValue")
    func testBoolConformsToMapleCompatibleValue() {
        let bool = true
        let wrapper = bool.mp
        #expect(wrapper.base == bool)
        #expect(type(of: wrapper) == MapleWrapper<Bool>.self)
    }
    
    // MARK: - Property: int
    
    @Test("int should return 1 for true and 0 for false")
    func testInt() {
        #expect(false.mp.int == 0)
        #expect(true.mp.int == 1)
    }
    
    // MARK: - Property: string
    
    @Test("string should return string representation")
    func testString() {
        #expect(false.mp.string == "false")
        #expect(true.mp.string == "true")
    }
}
