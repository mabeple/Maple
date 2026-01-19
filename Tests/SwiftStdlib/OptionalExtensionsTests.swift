//
//  OptionalExtensionsTests.swift
//  Maple
//
//  Created by cy on 2023/2/22.
//  Copyright © 2023 cy. All rights reserved.
//

@testable import Maple
import XCTest

private enum OptionalTestError: Error {
    case optionalIsNil
}

final class OptionalExtensionsTests: XCTestCase {
    func testIsNilOrEmpty() {
        // Test with String (Collection)
        var str: String? = nil
        XCTAssertTrue(str.mp.isNilOrEmpty())
        
        str = ""
        XCTAssertTrue(str.mp.isNilOrEmpty())
        
        str = "swift"
        XCTAssertFalse(str.mp.isNilOrEmpty())
        
        // Test with Array
        var array: [Int]? = nil
        XCTAssertTrue(array.mp.isNilOrEmpty())
        
        array = []
        XCTAssertTrue(array.mp.isNilOrEmpty())
        
        array = [1, 2, 3]
        XCTAssertFalse(array.mp.isNilOrEmpty())
        
        // Test with Set
        var set: Set<String>? = nil
        XCTAssertTrue(set.mp.isNilOrEmpty())
        
        set = []
        XCTAssertTrue(set.mp.isNilOrEmpty())
        
        set = ["a", "b", "c"]
        XCTAssertFalse(set.mp.isNilOrEmpty())
        
        // Test with Dictionary
        var dict: [String: Int]? = nil
        XCTAssertTrue(dict.mp.isNilOrEmpty())
        
        dict = [:]
        XCTAssertTrue(dict.mp.isNilOrEmpty())
        
        dict = ["a": 1, "b": 2]
        XCTAssertFalse(dict.mp.isNilOrEmpty())
    }
    
    func testUnwrappedOrDefault() {
        var str: String?
        XCTAssertEqual(str.mp.unwrapped(or: "swift"), "swift")
        
        str = "swifterswift"
        XCTAssertEqual(str.mp.unwrapped(or: "swift"), "swifterswift")
    }
    
    func testUnwrappedOrError() {
        let null: String? = nil
        try XCTAssertThrowsError(null.mp.unwrapped(or: OptionalTestError.optionalIsNil))
        
        let some: String? = "I exist"
        try XCTAssertNoThrow(some.mp.unwrapped(or: OptionalTestError.optionalIsNil))
    }
}
