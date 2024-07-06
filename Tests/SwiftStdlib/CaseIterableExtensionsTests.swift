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
        XCTAssertEqual(TestEnum.three.previous(), TestEnum.two)
        XCTAssertEqual(TestEnum.two.previous(), TestEnum.one)
        XCTAssertEqual(TestEnum.one.previous(), TestEnum.three)
    }
    
    func testNext() {
        XCTAssertEqual(TestEnum.one.next(), TestEnum.two)
        XCTAssertEqual(TestEnum.two.next(), TestEnum.three)
        XCTAssertEqual(TestEnum.three.next(), TestEnum.one)
    }
    
    func testIsLast() {
        XCTAssertFalse(TestEnum.one.isLast())
        XCTAssertFalse(TestEnum.two.isLast())
        XCTAssertTrue(TestEnum.three.isLast())
    }
    
    func testLoopedPrevious() {
        XCTAssertEqual(TestEnum.one.previous(looped: true), TestEnum.three)
        XCTAssertEqual(TestEnum.one.previous(looped: false), TestEnum.one)
    }
    
    func testLoopedNext() {
        XCTAssertEqual(TestEnum.three.next(looped: true), TestEnum.one)
        XCTAssertEqual(TestEnum.three.next(looped: false), TestEnum.three)
    }
}
