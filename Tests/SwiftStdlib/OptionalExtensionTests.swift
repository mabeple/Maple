//
//  OptionalExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Optional Extensions Test Suite")
struct OptionalExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Optional should conform to MapleCompatibleValue")
    func testOptionalConformsToMapleCompatibleValue() {
        let optional: String? = "test"
        let wrapper = optional.mp
        #expect(wrapper.base == optional)
        #expect(type(of: wrapper) == MapleWrapper<Optional<String>>.self)
    }
    
    // MARK: - Method: isNilOrEmpty
    
    @Test("isNilOrEmpty should return true for nil optional")
    func testIsNilOrEmptyWithNil() {
        let nilString: String? = nil
        #expect(nilString.mp.isNilOrEmpty() == true)
        
        let nilArray: [Int]? = nil
        #expect(nilArray.mp.isNilOrEmpty() == true)
    }
    
    @Test("isNilOrEmpty should return true for empty collection")
    func testIsNilOrEmptyWithEmptyCollection() {
        let emptyString: String? = ""
        #expect(emptyString.mp.isNilOrEmpty() == true)
        
        let emptyArray: [Int]? = []
        #expect(emptyArray.mp.isNilOrEmpty() == true)
        
        let emptySet: Set<String>? = []
        #expect(emptySet.mp.isNilOrEmpty() == true)
    }
    
    @Test("isNilOrEmpty should return false for non-empty collection")
    func testIsNilOrEmptyWithNonEmptyCollection() {
        let nonEmptyString: String? = "test"
        #expect(nonEmptyString.mp.isNilOrEmpty() == false)
        
        let nonEmptyArray: [Int]? = [1, 2, 3]
        #expect(nonEmptyArray.mp.isNilOrEmpty() == false)
        
        let nonEmptySet: Set<String>? = ["a", "b"]
        #expect(nonEmptySet.mp.isNilOrEmpty() == false)
    }
    
    // MARK: - Method: unwrapped (with default value)
    
    @Test("unwrapped should return value when not nil")
    func testUnwrappedWithValue() {
        let optional: String? = "test"
        #expect(optional.mp.unwrapped(or: "default") == "test")
        
        let optionalInt: Int? = 42
        #expect(optionalInt.mp.unwrapped(or: 0) == 42)
    }
    
    @Test("unwrapped should return default value when nil")
    func testUnwrappedWithNil() {
        let nilString: String? = nil
        #expect(nilString.mp.unwrapped(or: "default") == "default")
        
        let nilInt: Int? = nil
        #expect(nilInt.mp.unwrapped(or: 0) == 0)
    }
    
    // MARK: - Method: unwrapped (with error)
    
    @Test("unwrapped should return value when not nil")
    func testUnwrappedWithErrorWhenNotNil() throws {
        let optional: String? = "test"
        let value = try optional.mp.unwrapped(or: TestError.notFound)
        #expect(value == "test")
        
        let optionalInt: Int? = 42
        let intValue = try optionalInt.mp.unwrapped(or: TestError.notFound)
        #expect(intValue == 42)
    }
    
    @Test("unwrapped should throw error when nil")
    func testUnwrappedWithErrorWhenNil() {
        let nilString: String? = nil
        #expect(throws: TestError.notFound) {
            try nilString.mp.unwrapped(or: TestError.notFound)
        }
        
        let nilInt: Int? = nil
        #expect(throws: TestError.notFound) {
            try nilInt.mp.unwrapped(or: TestError.notFound)
        }
    }
}

enum TestError: Error {
    case notFound
}
