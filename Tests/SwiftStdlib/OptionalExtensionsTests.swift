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
