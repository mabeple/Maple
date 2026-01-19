//
//  EdgeInsetsExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import Foundation
#endif

import Testing
@testable import Maple

@Suite("EdgeInsets Extensions Test Suite")
struct EdgeInsetsExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("EdgeInsets should conform to MapleCompatibleValue")
    func testEdgeInsetsConformsToMapleCompatibleValue() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let wrapper = insets.mp
        #expect(wrapper.base.top == 10)
        #expect(wrapper.base.left == 20)
        #expect(wrapper.base.bottom == 30)
        #expect(wrapper.base.right == 40)
    }
    
    // MARK: - Equatable Conformance
    
    @Test("EdgeInsets should conform to Equatable")
    func testEdgeInsetsConformsToEquatable() {
        let insets1 = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let insets2 = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let insets3 = EdgeInsets(top: 10, left: 20, bottom: 30, right: 50)
        
        // Test equality
        #expect(insets1 == insets2)
        
        // Test inequality
        #expect(insets1 != insets3)
        
        // Test with zero insets
        let zero1 = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let zero2 = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        #expect(zero1 == zero2)
        
        // Test with different values
        let insets4 = EdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        let insets5 = EdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        #expect(insets4 == insets5)
        
        // Test inequality with different top
        let insets6 = EdgeInsets(top: 1, left: 20, bottom: 30, right: 40)
        #expect(insets1 != insets6)
        
        // Test inequality with different left
        let insets7 = EdgeInsets(top: 10, left: 1, bottom: 30, right: 40)
        #expect(insets1 != insets7)
        
        // Test inequality with different bottom
        let insets8 = EdgeInsets(top: 10, left: 20, bottom: 1, right: 40)
        #expect(insets1 != insets8)
        
        // Test inequality with different right
        let insets9 = EdgeInsets(top: 10, left: 20, bottom: 30, right: 1)
        #expect(insets1 != insets9)
    }
    
    // MARK: - Property: vertical
    
    @Test("vertical should return sum of top and bottom")
    func testVertical() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        #expect(insets.mp.vertical == 40)
        
        let insets2 = EdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        #expect(insets2.mp.vertical == 10)
        
        let insets3 = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        #expect(insets3.mp.vertical == 0)
    }
    
    // MARK: - Property: horizontal
    
    @Test("horizontal should return sum of left and right")
    func testHorizontal() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        #expect(insets.mp.horizontal == 60)
        
        let insets2 = EdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        #expect(insets2.mp.horizontal == 20)
        
        let insets3 = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        #expect(insets3.mp.horizontal == 0)
    }
    
    // MARK: - Method: insetBy(top:)
    
    @Test("insetBy(top:) should add offset to top")
    func testInsetByTop() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let result = insets.mp.insetBy(top: 5)
        #expect(result.top == 15)
        #expect(result.left == 20)
        #expect(result.bottom == 30)
        #expect(result.right == 40)
        
        let result2 = insets.mp.insetBy(top: -5)
        #expect(result2.top == 5)
    }
    
    // MARK: - Method: insetBy(left:)
    
    @Test("insetBy(left:) should add offset to left")
    func testInsetByLeft() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let result = insets.mp.insetBy(left: 5)
        #expect(result.top == 10)
        #expect(result.left == 25)
        #expect(result.bottom == 30)
        #expect(result.right == 40)
        
        let result2 = insets.mp.insetBy(left: -5)
        #expect(result2.left == 15)
    }
    
    // MARK: - Method: insetBy(bottom:)
    
    @Test("insetBy(bottom:) should add offset to bottom")
    func testInsetByBottom() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let result = insets.mp.insetBy(bottom: 5)
        #expect(result.top == 10)
        #expect(result.left == 20)
        #expect(result.bottom == 35)
        #expect(result.right == 40)
        
        let result2 = insets.mp.insetBy(bottom: -5)
        #expect(result2.bottom == 25)
    }
    
    // MARK: - Method: insetBy(right:)
    
    @Test("insetBy(right:) should add offset to right")
    func testInsetByRight() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let result = insets.mp.insetBy(right: 5)
        #expect(result.top == 10)
        #expect(result.left == 20)
        #expect(result.bottom == 30)
        #expect(result.right == 45)
        
        let result2 = insets.mp.insetBy(right: -5)
        #expect(result2.right == 35)
    }
    
    // MARK: - Method: insetBy(horizontal:)
    
    @Test("insetBy(horizontal:) should add offset to left and right")
    func testInsetByHorizontal() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let result = insets.mp.insetBy(horizontal: 10)
        #expect(result.top == 10)
        #expect(result.left == 25)
        #expect(result.bottom == 30)
        #expect(result.right == 45)
        
        let result2 = insets.mp.insetBy(horizontal: -10)
        #expect(result2.left == 15)
        #expect(result2.right == 35)
    }
    
    // MARK: - Method: insetBy(vertical:)
    
    @Test("insetBy(vertical:) should add offset to top and bottom")
    func testInsetByVertical() {
        let insets = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let result = insets.mp.insetBy(vertical: 10)
        #expect(result.top == 15)
        #expect(result.left == 20)
        #expect(result.bottom == 35)
        #expect(result.right == 40)
        
        let result2 = insets.mp.insetBy(vertical: -10)
        #expect(result2.top == 5)
        #expect(result2.bottom == 25)
    }
    
    // MARK: - Initializer: init(inset:)
    
    @Test("init(inset:) should create insets with same value for all edges")
    func testInitWithInset() {
        let insets = EdgeInsets(inset: 10)
        #expect(insets.top == 10)
        #expect(insets.left == 10)
        #expect(insets.bottom == 10)
        #expect(insets.right == 10)
        
        let insets2 = EdgeInsets(inset: 0)
        #expect(insets2.top == 0)
        #expect(insets2.left == 0)
        #expect(insets2.bottom == 0)
        #expect(insets2.right == 0)
    }
    
    // MARK: - Initializer: init(top:leading:bottom:trailing:)
    
    @Test("init(top:leading:bottom:trailing:) should create insets with specified values")
    func testInitWithTopLeadingBottomTrailing() {
        // Test with all parameters
        let insets = EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        #expect(insets.top == 10)
        #expect(insets.left == 20)
        #expect(insets.bottom == 30)
        #expect(insets.right == 40)
        
        // Test with only top
        let insets2 = EdgeInsets(top: 10)
        #expect(insets2.top == 10)
        #expect(insets2.left == 0)
        #expect(insets2.bottom == 0)
        #expect(insets2.right == 0)
        
        // Test with only leading
        let insets3 = EdgeInsets(leading: 20)
        #expect(insets3.top == 0)
        #expect(insets3.left == 20)
        #expect(insets3.bottom == 0)
        #expect(insets3.right == 0)
        
        // Test with only bottom
        let insets4 = EdgeInsets(bottom: 30)
        #expect(insets4.top == 0)
        #expect(insets4.left == 0)
        #expect(insets4.bottom == 30)
        #expect(insets4.right == 0)
        
        // Test with only trailing
        let insets5 = EdgeInsets(trailing: 40)
        #expect(insets5.top == 0)
        #expect(insets5.left == 0)
        #expect(insets5.bottom == 0)
        #expect(insets5.right == 40)
        
        // Test with default values (all zeros)
        let insets6 = EdgeInsets()
        #expect(insets6.top == 0)
        #expect(insets6.left == 0)
        #expect(insets6.bottom == 0)
        #expect(insets6.right == 0)
        
        // Test with top and bottom
        let insets7 = EdgeInsets(top: 10, bottom: 30)
        #expect(insets7.top == 10)
        #expect(insets7.left == 0)
        #expect(insets7.bottom == 30)
        #expect(insets7.right == 0)
        
        // Test with leading and trailing
        let insets8 = EdgeInsets(leading: 20, trailing: 40)
        #expect(insets8.top == 0)
        #expect(insets8.left == 20)
        #expect(insets8.bottom == 0)
        #expect(insets8.right == 40)
    }
    
    // MARK: - Initializer: init(horizontal:vertical:)
    
    @Test("init(horizontal:vertical:) should create insets with horizontal and vertical values")
    func testInitWithHorizontalAndVertical() {
        let insets = EdgeInsets(horizontal: 20, vertical: 10)
        #expect(insets.top == 10)
        #expect(insets.left == 20)
        #expect(insets.bottom == 10)
        #expect(insets.right == 20)
        
        let insets2 = EdgeInsets(horizontal: 0, vertical: 0)
        #expect(insets2.top == 0)
        #expect(insets2.left == 0)
        #expect(insets2.bottom == 0)
        #expect(insets2.right == 0)
        
        // Test with default values
        let insets3 = EdgeInsets(horizontal: 0)
        #expect(insets3.top == 0)
        #expect(insets3.left == 0)
        #expect(insets3.bottom == 0)
        #expect(insets3.right == 0)
    }
    
    // MARK: - Operator: + (EdgeInsets, EdgeInsets)
    
    @Test("+ operator should add two EdgeInsets")
    func testAddOperator() {
        let insets1 = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let insets2 = EdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        let result = insets1 + insets2
        #expect(result.top == 15)
        #expect(result.left == 30)
        #expect(result.bottom == 45)
        #expect(result.right == 60)
    }
    
    // MARK: - Operator: += (inout EdgeInsets, EdgeInsets)
    
    @Test("+= operator should add EdgeInsets to self")
    func testAddAssignmentOperator() {
        var insets1 = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        let insets2 = EdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        insets1 += insets2
        #expect(insets1.top == 15)
        #expect(insets1.left == 30)
        #expect(insets1.bottom == 45)
        #expect(insets1.right == 60)
    }
}

#endif
