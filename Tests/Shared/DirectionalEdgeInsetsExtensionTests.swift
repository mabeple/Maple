//
//  DirectionalEdgeInsetsExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

import Testing
@testable import Maple

@Suite("DirectionalEdgeInsets Extensions Test Suite")
struct DirectionalEdgeInsetsExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("DirectionalEdgeInsets should conform to MapleCompatibleValue")
    func testDirectionalEdgeInsetsConformsToMapleCompatibleValue() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let wrapper = insets.mp
        #expect(wrapper.base.top == 10)
        #expect(wrapper.base.leading == 20)
        #expect(wrapper.base.bottom == 30)
        #expect(wrapper.base.trailing == 40)
    }
    
    // MARK: - Equatable Conformance
    
    @Test("DirectionalEdgeInsets should conform to Equatable")
    func testDirectionalEdgeInsetsConformsToEquatable() {
        let insets1 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let insets2 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let insets3 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 50)
        
        // Test equality
        #expect(insets1 == insets2)
        
        // Test inequality
        #expect(insets1 != insets3)
        
        // Test with zero insets
        let zero1 = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let zero2 = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        #expect(zero1 == zero2)
        
        // Test with different values
        let insets4 = DirectionalEdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 20)
        let insets5 = DirectionalEdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 20)
        #expect(insets4 == insets5)
        
        // Test inequality with different top
        let insets6 = DirectionalEdgeInsets(top: 1, leading: 20, bottom: 30, trailing: 40)
        #expect(insets1 != insets6)
        
        // Test inequality with different leading
        let insets7 = DirectionalEdgeInsets(top: 10, leading: 1, bottom: 30, trailing: 40)
        #expect(insets1 != insets7)
        
        // Test inequality with different bottom
        let insets8 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 40)
        #expect(insets1 != insets8)
        
        // Test inequality with different trailing
        let insets9 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 1)
        #expect(insets1 != insets9)
    }
    
    // MARK: - Property: vertical
    
    @Test("vertical should return sum of top and bottom")
    func testVertical() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        #expect(insets.mp.vertical == 40)
        
        let insets2 = DirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        #expect(insets2.mp.vertical == 10)
        
        let insets3 = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        #expect(insets3.mp.vertical == 0)
    }
    
    // MARK: - Property: horizontal
    
    @Test("horizontal should return sum of leading and trailing")
    func testHorizontal() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        #expect(insets.mp.horizontal == 60)
        
        let insets2 = DirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        #expect(insets2.mp.horizontal == 20)
        
        let insets3 = DirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        #expect(insets3.mp.horizontal == 0)
    }
    
    // MARK: - Method: insetBy(top:)
    
    @Test("insetBy(top:) should add offset to top")
    func testInsetByTop() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let result = insets.mp.insetBy(top: 5)
        #expect(result.top == 15)
        #expect(result.leading == 20)
        #expect(result.bottom == 30)
        #expect(result.trailing == 40)
        
        let result2 = insets.mp.insetBy(top: -5)
        #expect(result2.top == 5)
    }
    
    // MARK: - Method: insetBy(leading:)
    
    @Test("insetBy(leading:) should add offset to leading")
    func testInsetByLeading() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let result = insets.mp.insetBy(leading: 5)
        #expect(result.top == 10)
        #expect(result.leading == 25)
        #expect(result.bottom == 30)
        #expect(result.trailing == 40)
        
        let result2 = insets.mp.insetBy(leading: -5)
        #expect(result2.leading == 15)
    }
    
    // MARK: - Method: insetBy(bottom:)
    
    @Test("insetBy(bottom:) should add offset to bottom")
    func testInsetByBottom() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let result = insets.mp.insetBy(bottom: 5)
        #expect(result.top == 10)
        #expect(result.leading == 20)
        #expect(result.bottom == 35)
        #expect(result.trailing == 40)
        
        let result2 = insets.mp.insetBy(bottom: -5)
        #expect(result2.bottom == 25)
    }
    
    // MARK: - Method: insetBy(trailing:)
    
    @Test("insetBy(trailing:) should add offset to trailing")
    func testInsetByTrailing() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let result = insets.mp.insetBy(trailing: 5)
        #expect(result.top == 10)
        #expect(result.leading == 20)
        #expect(result.bottom == 30)
        #expect(result.trailing == 45)
        
        let result2 = insets.mp.insetBy(trailing: -5)
        #expect(result2.trailing == 35)
    }
    
    // MARK: - Method: insetBy(horizontal:)
    
    @Test("insetBy(horizontal:) should add offset to leading and trailing")
    func testInsetByHorizontal() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let result = insets.mp.insetBy(horizontal: 10)
        #expect(result.top == 10)
        #expect(result.leading == 25)
        #expect(result.bottom == 30)
        #expect(result.trailing == 45)
        
        let result2 = insets.mp.insetBy(horizontal: -10)
        #expect(result2.leading == 15)
        #expect(result2.trailing == 35)
    }
    
    // MARK: - Method: insetBy(vertical:)
    
    @Test("insetBy(vertical:) should add offset to top and bottom")
    func testInsetByVertical() {
        let insets = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let result = insets.mp.insetBy(vertical: 10)
        #expect(result.top == 15)
        #expect(result.leading == 20)
        #expect(result.bottom == 35)
        #expect(result.trailing == 40)
        
        let result2 = insets.mp.insetBy(vertical: -10)
        #expect(result2.top == 5)
        #expect(result2.bottom == 25)
    }
    
    // MARK: - Initializer: init(inset:)
    
    @Test("init(inset:) should create insets with same value for all edges")
    func testInitWithInset() {
        let insets = DirectionalEdgeInsets(inset: 10)
        #expect(insets.top == 10)
        #expect(insets.leading == 10)
        #expect(insets.bottom == 10)
        #expect(insets.trailing == 10)
        
        let insets2 = NSDirectionalEdgeInsets(inset: 0)
        #expect(insets2.top == 0)
        #expect(insets2.leading == 0)
        #expect(insets2.bottom == 0)
        #expect(insets2.trailing == 0)
    }
    
    // MARK: - Initializer: init(top:left:bottom:right:)
    
    @Test("init(top:left:bottom:right:) should create insets with specified values")
    func testInitWithTopLeftBottomRight() {
        // Test with all parameters
        let insets = DirectionalEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        #expect(insets.top == 10)
        #expect(insets.leading == 20)
        #expect(insets.bottom == 30)
        #expect(insets.trailing == 40)
        
        // Test with only top
        let insets2 = DirectionalEdgeInsets(top: 10)
        #expect(insets2.top == 10)
        #expect(insets2.leading == 0)
        #expect(insets2.bottom == 0)
        #expect(insets2.trailing == 0)
        
        // Test with only left
        let insets3 = DirectionalEdgeInsets(left: 20)
        #expect(insets3.top == 0)
        #expect(insets3.leading == 20)
        #expect(insets3.bottom == 0)
        #expect(insets3.trailing == 0)
        
        // Test with only bottom
        let insets4 = DirectionalEdgeInsets(bottom: 30)
        #expect(insets4.top == 0)
        #expect(insets4.leading == 0)
        #expect(insets4.bottom == 30)
        #expect(insets4.trailing == 0)
        
        // Test with only right
        let insets5 = DirectionalEdgeInsets(right: 40)
        #expect(insets5.top == 0)
        #expect(insets5.leading == 0)
        #expect(insets5.bottom == 0)
        #expect(insets5.trailing == 40)
        
        // Test with default values (all zeros)
        let insets6 = DirectionalEdgeInsets()
        #expect(insets6.top == 0)
        #expect(insets6.leading == 0)
        #expect(insets6.bottom == 0)
        #expect(insets6.trailing == 0)
        
        // Test with top and bottom
        let insets7 = DirectionalEdgeInsets(top: 10, bottom: 30)
        #expect(insets7.top == 10)
        #expect(insets7.leading == 0)
        #expect(insets7.bottom == 30)
        #expect(insets7.trailing == 0)
        
        // Test with left and right
        let insets8 = DirectionalEdgeInsets(left: 20, right: 40)
        #expect(insets8.top == 0)
        #expect(insets8.leading == 20)
        #expect(insets8.bottom == 0)
        #expect(insets8.trailing == 40)
    }
    
    // MARK: - Initializer: init(horizontal:vertical:)
    
    @Test("init(horizontal:vertical:) should create insets with horizontal and vertical values")
    func testInitWithHorizontalAndVertical() {
        let insets = DirectionalEdgeInsets(horizontal: 20, vertical: 10)
        #expect(insets.top == 10)
        #expect(insets.leading == 20)
        #expect(insets.bottom == 10)
        #expect(insets.trailing == 20)
        
        let insets2 = DirectionalEdgeInsets(horizontal: 0, vertical: 0)
        #expect(insets2.top == 0)
        #expect(insets2.leading == 0)
        #expect(insets2.bottom == 0)
        #expect(insets2.trailing == 0)
        
        // Test with default values
        let insets3 = DirectionalEdgeInsets(horizontal: 0)
        #expect(insets3.top == 0)
        #expect(insets3.leading == 0)
        #expect(insets3.bottom == 0)
        #expect(insets3.trailing == 0)
    }
    
    // MARK: - Operator: + (DirectionalEdgeInsets, DirectionalEdgeInsets)
    
    @Test("+ operator should add two DirectionalEdgeInsets")
    func testAddOperator() {
        let insets1 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let insets2 = DirectionalEdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 20)
        let result = insets1 + insets2
        #expect(result.top == 15)
        #expect(result.leading == 30)
        #expect(result.bottom == 45)
        #expect(result.trailing == 60)
    }
    
    // MARK: - Operator: += (inout DirectionalEdgeInsets, DirectionalEdgeInsets)
    
    @Test("+= operator should add DirectionalEdgeInsets to self")
    func testAddAssignmentOperator() {
        var insets1 = DirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)
        let insets2 = DirectionalEdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 20)
        insets1 += insets2
        #expect(insets1.top == 15)
        #expect(insets1.leading == 30)
        #expect(insets1.bottom == 45)
        #expect(insets1.trailing == 60)
    }
}

#endif
