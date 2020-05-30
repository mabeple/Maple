//
//  EdgeInsetsExtensionsTests.swift
//  Maple
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class EdgeInsetsExtensionsTests: XCTestCase {
    
    func testHorizontal() {
        let inset = EdgeInsets(top: 30.0, left: 5.0, bottom: 5.0, right: 10.0)
        XCTAssertEqual(inset.mp.horizontal, 15.0)
    }
    
    func testVertical() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
        XCTAssertEqual(inset.mp.vertical, 15.0)
    }
    
    func testInsetByTop() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let insetByTop = inset.mp.insetBy(top: 5.0)
        XCTAssertNotEqual(inset, insetByTop)
        XCTAssertEqual(insetByTop.top, 15.0)
        XCTAssertEqual(insetByTop.left, 10.0)
        XCTAssertEqual(insetByTop.bottom, 10.0)
        XCTAssertEqual(insetByTop.right, 10.0)
        
        let negativeInsetByTop = inset.mp.insetBy(top: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByTop)
        XCTAssertEqual(negativeInsetByTop.top, 5.0)
        XCTAssertEqual(negativeInsetByTop.left, 10.0)
        XCTAssertEqual(negativeInsetByTop.bottom, 10.0)
        XCTAssertEqual(negativeInsetByTop.right, 10.0)
    }
    
    func testInsetByLeft() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let insetByLeft = inset.mp.insetBy(left: 5.0)
        XCTAssertNotEqual(inset, insetByLeft)
        XCTAssertEqual(insetByLeft.top, 10.0)
        XCTAssertEqual(insetByLeft.left, 15.0)
        XCTAssertEqual(insetByLeft.bottom, 10.0)
        XCTAssertEqual(insetByLeft.right, 10.0)
        
        let negativeInsetByLeft = inset.mp.insetBy(left: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByLeft)
        XCTAssertEqual(negativeInsetByLeft.top, 10.0)
        XCTAssertEqual(negativeInsetByLeft.left, 5.0)
        XCTAssertEqual(negativeInsetByLeft.bottom, 10.0)
        XCTAssertEqual(negativeInsetByLeft.right, 10.0)
    }
    
    func testInsetByBottom() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let insetByBottom = inset.mp.insetBy(bottom: 5.0)
        XCTAssertNotEqual(inset, insetByBottom)
        XCTAssertEqual(insetByBottom.top, 10.0)
        XCTAssertEqual(insetByBottom.left, 10.0)
        XCTAssertEqual(insetByBottom.bottom, 15.0)
        XCTAssertEqual(insetByBottom.right, 10.0)
        
        let negativeInsetByBottom = inset.mp.insetBy(bottom: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByBottom)
        XCTAssertEqual(negativeInsetByBottom.top, 10.0)
        XCTAssertEqual(negativeInsetByBottom.left, 10.0)
        XCTAssertEqual(negativeInsetByBottom.bottom, 5.0)
        XCTAssertEqual(negativeInsetByBottom.right, 10.0)
    }
    
    func testInsetByRight() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let insetByRight = inset.mp.insetBy(right: 5.0)
        XCTAssertNotEqual(inset, insetByRight)
        XCTAssertEqual(insetByRight.top, 10.0)
        XCTAssertEqual(insetByRight.left, 10.0)
        XCTAssertEqual(insetByRight.bottom, 10.0)
        XCTAssertEqual(insetByRight.right, 15.0)
        
        let negativeInsetByRight = inset.mp.insetBy(right: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByRight)
        XCTAssertEqual(negativeInsetByRight.top, 10.0)
        XCTAssertEqual(negativeInsetByRight.left, 10.0)
        XCTAssertEqual(negativeInsetByRight.bottom, 10.0)
        XCTAssertEqual(negativeInsetByRight.right, 5.0)
    }
    
    func testInsetByHorizontal() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let insetByHorizontal = inset.mp.insetBy(horizontal: 5.0)
        XCTAssertNotEqual(inset, insetByHorizontal)
        XCTAssertEqual(insetByHorizontal.left, 12.5)
        XCTAssertEqual(insetByHorizontal.right, 12.5)
        XCTAssertEqual(insetByHorizontal.top, 10.0)
        XCTAssertEqual(insetByHorizontal.bottom, 10.0)
        
        let negativeInsetByHorizontal = inset.mp.insetBy(horizontal: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByHorizontal)
        XCTAssertEqual(negativeInsetByHorizontal.left, 7.5)
        XCTAssertEqual(negativeInsetByHorizontal.right, 7.5)
        XCTAssertEqual(negativeInsetByHorizontal.top, 10.0)
        XCTAssertEqual(negativeInsetByHorizontal.bottom, 10.0)
    }
    
    func testInsetByVertical() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let insetByVertical = inset.mp.insetBy(vertical: 5.0)
        XCTAssertNotEqual(inset, insetByVertical)
        XCTAssertEqual(insetByVertical.left, 10.0)
        XCTAssertEqual(insetByVertical.right, 10.0)
        XCTAssertEqual(insetByVertical.top, 12.5)
        XCTAssertEqual(insetByVertical.bottom, 12.5)
        
        let negativeInsetByVertical = inset.mp.insetBy(vertical: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByVertical)
        XCTAssertEqual(negativeInsetByVertical.left, 10.0)
        XCTAssertEqual(negativeInsetByVertical.right, 10.0)
        XCTAssertEqual(negativeInsetByVertical.top, 7.5)
        XCTAssertEqual(negativeInsetByVertical.bottom, 7.5)
    }
    func testInitInset() {
        let inset = EdgeInsets(inset: 5.0)
        XCTAssertEqual(inset.top, 5.0)
        XCTAssertEqual(inset.bottom, 5.0)
        XCTAssertEqual(inset.right, 5.0)
        XCTAssertEqual(inset.left, 5.0)
    }
    
    func testInitVerticalHorizontal() {
        let inset = EdgeInsets(horizontal: 20.0, vertical: 10.0)
        XCTAssertEqual(inset.top, 5.0)
        XCTAssertEqual(inset.bottom, 5.0)
        XCTAssertEqual(inset.right, 10.0)
        XCTAssertEqual(inset.left, 10.0)
    }
    
    func testInsetComposing() {
        let inset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let composedInset = inset.mp.insetBy(bottom: 5.0).mp.insetBy(horizontal: 5.0)
        XCTAssertNotEqual(inset, composedInset)
        XCTAssertEqual(composedInset.left, 12.5)
        XCTAssertEqual(composedInset.right, 12.5)
        XCTAssertEqual(composedInset.top, 10)
        XCTAssertEqual(composedInset.bottom, 15.0)

        let negativeComposedInset = inset.mp.insetBy(bottom: -5.0).mp.insetBy(horizontal: -5.0)
        XCTAssertNotEqual(inset, negativeComposedInset)
        XCTAssertEqual(negativeComposedInset.left, 7.5)
        XCTAssertEqual(negativeComposedInset.right, 7.5)
        XCTAssertEqual(negativeComposedInset.top, 10)
        XCTAssertEqual(negativeComposedInset.bottom, 5.0)
    }
    
    func testAddition() {
        XCTAssertEqual(EdgeInsets.zero + EdgeInsets.zero, EdgeInsets.zero)

        let insets1 = EdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        let insets2 = EdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let expected = EdgeInsets(top: 6, left: 8, bottom: 10, right: 12)
        XCTAssertEqual(insets1 + insets2, expected)

        let negativeInsets1 = EdgeInsets(top: -1, left: -2, bottom: -3, right: -4)
        let negativeInsets2 = EdgeInsets(top: -5, left: -6, bottom: -7, right: -8)
        let negativeExpected = EdgeInsets(top: -6, left: -8, bottom: -10, right: -12)
        XCTAssertEqual(negativeInsets1 + negativeInsets2, negativeExpected)
    }

    func testInPlaceAddition() {
        var zero = EdgeInsets.zero
        zero += EdgeInsets.zero
        XCTAssertEqual(zero, EdgeInsets.zero)

        var insets = EdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        insets += EdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let expected = EdgeInsets(top: 6, left: 8, bottom: 10, right: 12)
        XCTAssertEqual(insets, expected)

        var negativeInsets = EdgeInsets(top: -1, left: -2, bottom: -3, right: -4)
        negativeInsets += EdgeInsets(top: -5, left: -6, bottom: -7, right: -8)
        let negativeExpected = EdgeInsets(top: -6, left: -8, bottom: -10, right: -12)
        XCTAssertEqual(negativeInsets, negativeExpected)
    }
}
