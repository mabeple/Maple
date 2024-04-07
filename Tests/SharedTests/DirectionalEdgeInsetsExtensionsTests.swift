//
//  DirectionalEdgeInsetsExtensionsTests.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copytrailing © 2024 cy. All trailings reserved.
//

import XCTest
@testable import Maple

class DirectionalEdgeInsetsExtensionsTests: XCTestCase {
    
    func testHorizontal() {
        let inset = NSDirectionalEdgeInsets(top: 30.0, leading: 5.0, bottom: 5.0, trailing: 10.0)
        XCTAssertEqual(inset.mp.horizontal, 15.0)
    }
    
    func testVertical() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 5.0, trailing: 10.0)
        XCTAssertEqual(inset.mp.vertical, 15.0)
    }
    
    func testInsetByTop() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let insetByTop = inset.mp.insetBy(top: 5.0)
        XCTAssertNotEqual(inset, insetByTop)
        XCTAssertEqual(insetByTop.top, 15.0)
        XCTAssertEqual(insetByTop.leading, 10.0)
        XCTAssertEqual(insetByTop.bottom, 10.0)
        XCTAssertEqual(insetByTop.trailing, 10.0)
        
        let negativeInsetByTop = inset.mp.insetBy(top: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByTop)
        XCTAssertEqual(negativeInsetByTop.top, 5.0)
        XCTAssertEqual(negativeInsetByTop.leading, 10.0)
        XCTAssertEqual(negativeInsetByTop.bottom, 10.0)
        XCTAssertEqual(negativeInsetByTop.trailing, 10.0)
    }
    
    func testInsetByleading() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let insetByLeading = inset.mp.insetBy(leading: 5.0)
        XCTAssertNotEqual(inset, insetByLeading)
        XCTAssertEqual(insetByLeading.top, 10.0)
        XCTAssertEqual(insetByLeading.leading, 15.0)
        XCTAssertEqual(insetByLeading.bottom, 10.0)
        XCTAssertEqual(insetByLeading.trailing, 10.0)
        
        let negativeInsetByLeading = inset.mp.insetBy(leading: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByLeading)
        XCTAssertEqual(negativeInsetByLeading.top, 10.0)
        XCTAssertEqual(negativeInsetByLeading.leading, 5.0)
        XCTAssertEqual(negativeInsetByLeading.bottom, 10.0)
        XCTAssertEqual(negativeInsetByLeading.trailing, 10.0)
    }
    
    func testInsetByBottom() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let insetByBottom = inset.mp.insetBy(bottom: 5.0)
        XCTAssertNotEqual(inset, insetByBottom)
        XCTAssertEqual(insetByBottom.top, 10.0)
        XCTAssertEqual(insetByBottom.leading, 10.0)
        XCTAssertEqual(insetByBottom.bottom, 15.0)
        XCTAssertEqual(insetByBottom.trailing, 10.0)
        
        let negativeInsetByBottom = inset.mp.insetBy(bottom: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByBottom)
        XCTAssertEqual(negativeInsetByBottom.top, 10.0)
        XCTAssertEqual(negativeInsetByBottom.leading, 10.0)
        XCTAssertEqual(negativeInsetByBottom.bottom, 5.0)
        XCTAssertEqual(negativeInsetByBottom.trailing, 10.0)
    }
    
    func testInsetBytrailing() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let insetByTrailing = inset.mp.insetBy(trailing: 5.0)
        XCTAssertNotEqual(inset, insetByTrailing)
        XCTAssertEqual(insetByTrailing.top, 10.0)
        XCTAssertEqual(insetByTrailing.leading, 10.0)
        XCTAssertEqual(insetByTrailing.bottom, 10.0)
        XCTAssertEqual(insetByTrailing.trailing, 15.0)
        
        let negativeInsetByTrailing = inset.mp.insetBy(trailing: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByTrailing)
        XCTAssertEqual(negativeInsetByTrailing.top, 10.0)
        XCTAssertEqual(negativeInsetByTrailing.leading, 10.0)
        XCTAssertEqual(negativeInsetByTrailing.bottom, 10.0)
        XCTAssertEqual(negativeInsetByTrailing.trailing, 5.0)
    }
    
    func testInsetByHorizontal() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let insetByHorizontal = inset.mp.insetBy(horizontal: 5.0)
        XCTAssertNotEqual(inset, insetByHorizontal)
        XCTAssertEqual(insetByHorizontal.leading, 12.5)
        XCTAssertEqual(insetByHorizontal.trailing, 12.5)
        XCTAssertEqual(insetByHorizontal.top, 10.0)
        XCTAssertEqual(insetByHorizontal.bottom, 10.0)
        
        let negativeInsetByHorizontal = inset.mp.insetBy(horizontal: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByHorizontal)
        XCTAssertEqual(negativeInsetByHorizontal.leading, 7.5)
        XCTAssertEqual(negativeInsetByHorizontal.trailing, 7.5)
        XCTAssertEqual(negativeInsetByHorizontal.top, 10.0)
        XCTAssertEqual(negativeInsetByHorizontal.bottom, 10.0)
    }
    
    func testInsetByVertical() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let insetByVertical = inset.mp.insetBy(vertical: 5.0)
        XCTAssertNotEqual(inset, insetByVertical)
        XCTAssertEqual(insetByVertical.leading, 10.0)
        XCTAssertEqual(insetByVertical.trailing, 10.0)
        XCTAssertEqual(insetByVertical.top, 12.5)
        XCTAssertEqual(insetByVertical.bottom, 12.5)
        
        let negativeInsetByVertical = inset.mp.insetBy(vertical: -5.0)
        XCTAssertNotEqual(inset, negativeInsetByVertical)
        XCTAssertEqual(negativeInsetByVertical.leading, 10.0)
        XCTAssertEqual(negativeInsetByVertical.trailing, 10.0)
        XCTAssertEqual(negativeInsetByVertical.top, 7.5)
        XCTAssertEqual(negativeInsetByVertical.bottom, 7.5)
    }
    
    func testInitInset() {
        let inset = NSDirectionalEdgeInsets(inset: 5.0)
        XCTAssertEqual(inset.top, 5.0)
        XCTAssertEqual(inset.bottom, 5.0)
        XCTAssertEqual(inset.trailing, 5.0)
        XCTAssertEqual(inset.leading, 5.0)
    }
    
    func testInitTop() {
        let inset = NSDirectionalEdgeInsets(top: 5.0)
        XCTAssertEqual(inset.top, 5.0)
        XCTAssertEqual(inset.bottom, 0)
        XCTAssertEqual(inset.trailing, 0)
        XCTAssertEqual(inset.leading, 0)
    }
    
    func testInitLeading() {
        let inset = NSDirectionalEdgeInsets(leading: 5.0)
        XCTAssertEqual(inset.top, 0)
        XCTAssertEqual(inset.bottom, 0)
        XCTAssertEqual(inset.trailing, 0)
        XCTAssertEqual(inset.leading, 5.0)
    }
    
    func testInitBottom() {
        let inset = NSDirectionalEdgeInsets(bottom: 5.0)
        XCTAssertEqual(inset.top, 0)
        XCTAssertEqual(inset.bottom, 5.0)
        XCTAssertEqual(inset.trailing, 0)
        XCTAssertEqual(inset.leading, 0)
    }
    
    func testInitTrailing() {
        let inset = NSDirectionalEdgeInsets(trailing: 5.0)
        XCTAssertEqual(inset.top, 0)
        XCTAssertEqual(inset.bottom, 0)
        XCTAssertEqual(inset.trailing, 5.0)
        XCTAssertEqual(inset.leading, 0)
    }
    
    func testInitVerticalHorizontal() {
        let inset = NSDirectionalEdgeInsets(horizontal: 20.0, vertical: 10.0)
        XCTAssertEqual(inset.top, 10.0)
        XCTAssertEqual(inset.bottom, 10.0)
        XCTAssertEqual(inset.trailing, 20.0)
        XCTAssertEqual(inset.leading, 20.0)
    }
    
    func testInsetComposing() {
        let inset = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let composedInset = inset.mp.insetBy(bottom: 5.0).mp.insetBy(horizontal: 5.0)
        XCTAssertNotEqual(inset, composedInset)
        XCTAssertEqual(composedInset.leading, 12.5)
        XCTAssertEqual(composedInset.trailing, 12.5)
        XCTAssertEqual(composedInset.top, 10)
        XCTAssertEqual(composedInset.bottom, 15.0)

        let negativeComposedInset = inset.mp.insetBy(bottom: -5.0).mp.insetBy(horizontal: -5.0)
        XCTAssertNotEqual(inset, negativeComposedInset)
        XCTAssertEqual(negativeComposedInset.leading, 7.5)
        XCTAssertEqual(negativeComposedInset.trailing, 7.5)
        XCTAssertEqual(negativeComposedInset.top, 10)
        XCTAssertEqual(negativeComposedInset.bottom, 5.0)
    }
    
    func testAddition() {
        let insets1 = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        let insets2 = NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 7, trailing: 8)
        let expected = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 10, trailing: 12)
        XCTAssertEqual(insets1 + insets2, expected)

        let negativeInsets1 = NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4)
        let negativeInsets2 = NSDirectionalEdgeInsets(top: -5, leading: -6, bottom: -7, trailing: -8)
        let negativeExpected = NSDirectionalEdgeInsets(top: -6, leading: -8, bottom: -10, trailing: -12)
        XCTAssertEqual(negativeInsets1 + negativeInsets2, negativeExpected)
    }

    func testInPlaceAddition() {
        var insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        insets += NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 7, trailing: 8)
        let expected = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 10, trailing: 12)
        XCTAssertEqual(insets, expected)

        var negativeInsets = NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4)
        negativeInsets += NSDirectionalEdgeInsets(top: -5, leading: -6, bottom: -7, trailing: -8)
        let negativeExpected = NSDirectionalEdgeInsets(top: -6, leading: -8, bottom: -10, trailing: -12)
        XCTAssertEqual(negativeInsets, negativeExpected)
    }
}
