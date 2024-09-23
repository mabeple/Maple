//
//  CollectionExtensionsTests.swift
//  Maple
//
//  Created by cy on 2024/9/23.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple
class CollectionExtensionsTests: XCTestCase {
    let collection = [1, 2, 3, 4, 5]
    
    func testSafeSubscript() {
        XCTAssertNotNil(collection[safe: 2])
        XCTAssertEqual(collection[safe: 2], 3)
        XCTAssertNil(collection[safe: 10])
    }
    
    func testGroupBySize() {
        // A slice with value zero
        var array: [String] = ["james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        var slices = array.group(by: 0)
        XCTAssertNil(slices)

        // A slice that divide the total evenly
        array = ["james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        slices = array.group(by: 2)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 3)

        // A slice that does not divide the total evenly
        array = ["james", "irving", "jordan", "jonshon", "iverson", "shaq", "bird"]
        slices = array.group(by: 2)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 4)

        // A slice greater than the array count
        array = ["james", "irving", "jordan", "jonshon"]
        slices = array.group(by: 6)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 1)
    }
    
    func testAverage() {
        XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average(), 3.4)
        XCTAssertEqual([Double]().average(), 0)

        XCTAssertEqual([1, 2, 3, 4, 5].average(), 3)
        XCTAssertEqual([Int]().average(), 0)
    }
}
