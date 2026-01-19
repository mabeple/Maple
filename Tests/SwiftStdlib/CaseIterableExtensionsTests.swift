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
}
