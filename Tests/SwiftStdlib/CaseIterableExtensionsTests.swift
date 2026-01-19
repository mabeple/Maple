//
//  CaseIterableExtensionsTests.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple
class CaseIterableExtensionsTests: XCTestCase {
    enum TestEnum: CaseIterable {
        case one, two, three
    }
    
    func testPrevious() {
        XCTAssertEqual(TestEnum.three.mp.previous(), TestEnum.two)
        XCTAssertEqual(TestEnum.two.mp.previous(), TestEnum.one)
        XCTAssertEqual(TestEnum.one.mp.previous(), TestEnum.three)
    }
    
    func testNext() {
        XCTAssertEqual(TestEnum.one.mp.next(), TestEnum.two)
        XCTAssertEqual(TestEnum.two.mp.next(), TestEnum.three)
        XCTAssertEqual(TestEnum.three.mp.next(), TestEnum.one)
    }
    
    func testIsFirst() {
        XCTAssertTrue(TestEnum.one.mp.isFirst())
        XCTAssertFalse(TestEnum.two.mp.isFirst())
        XCTAssertFalse(TestEnum.three.mp.isFirst())
    }
    
    func testIsLast() {
        XCTAssertFalse(TestEnum.one.mp.isLast())
        XCTAssertFalse(TestEnum.two.mp.isLast())
        XCTAssertTrue(TestEnum.three.mp.isLast())
    }
    
    func testLoopedPrevious() {
        XCTAssertEqual(TestEnum.one.mp.previous(looped: true), TestEnum.three)
        XCTAssertEqual(TestEnum.one.mp.previous(looped: false), TestEnum.one)
    }
    
    func testLoopedNext() {
        XCTAssertEqual(TestEnum.three.mp.next(looped: true), TestEnum.one)
        XCTAssertEqual(TestEnum.three.mp.next(looped: false), TestEnum.three)
    }
    
    func testIndex() {
        XCTAssertEqual(TestEnum.one.mp.index(), 0)
        XCTAssertEqual(TestEnum.two.mp.index(), 1)
        XCTAssertEqual(TestEnum.three.mp.index(), 2)
    }
    
    func testCount() {
        XCTAssertEqual(TestEnum.one.mp.count, 3)
        XCTAssertEqual(TestEnum.two.mp.count, 3)
        XCTAssertEqual(TestEnum.three.mp.count, 3)
    }
    
    func testOffset() {
        // Forward offset
        XCTAssertEqual(TestEnum.one.mp.offset(by: 1), TestEnum.two)
        XCTAssertEqual(TestEnum.one.mp.offset(by: 2), TestEnum.three)
        
        // Backward offset
        XCTAssertEqual(TestEnum.three.mp.offset(by: -1), TestEnum.two)
        XCTAssertEqual(TestEnum.three.mp.offset(by: -2), TestEnum.one)
        
        // Looped offset
        XCTAssertEqual(TestEnum.three.mp.offset(by: 1, looped: true), TestEnum.one)
        XCTAssertEqual(TestEnum.one.mp.offset(by: -1, looped: true), TestEnum.three)
        
        // Non-looped offset (out of bounds)
        XCTAssertNil(TestEnum.three.mp.offset(by: 1, looped: false))
        XCTAssertNil(TestEnum.one.mp.offset(by: -1, looped: false))
        
        // Non-looped offset (in bounds)
        XCTAssertEqual(TestEnum.one.mp.offset(by: 1, looped: false), TestEnum.two)
        XCTAssertEqual(TestEnum.two.mp.offset(by: -1, looped: false), TestEnum.one)
    }
    
    func testDistance() {
        XCTAssertEqual(TestEnum.one.mp.distance(to: TestEnum.two), 1)
        XCTAssertEqual(TestEnum.one.mp.distance(to: TestEnum.three), 2)
        XCTAssertEqual(TestEnum.two.mp.distance(to: TestEnum.one), -1)
        XCTAssertEqual(TestEnum.three.mp.distance(to: TestEnum.one), -2)
        XCTAssertEqual(TestEnum.one.mp.distance(to: TestEnum.one), 0)
    }
}
