//
//  UIBarButtonItemExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIBarButtonItem Extensions Test Suite")
struct UIBarButtonItemExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("UIBarButtonItem should conform to MapleCompatible")
    @MainActor
    func testMapleCompatible() {
        let item = UIBarButtonItem(title: "Test", style: .plain, target: nil, action: nil)
        let wrapper = item.mp
        #expect(type(of: wrapper) == MapleWrapper<UIBarButtonItem>.self)
    }
    
    // MARK: - Method: addTargetForAction
    
    @Test("addTargetForAction should set target and action")
    @MainActor
    func testAddTargetForAction() {
        class TestTarget: NSObject {
            var actionCalled = false
            @objc func testAction() {
                actionCalled = true
            }
        }
        
        let target = TestTarget()
        let item = UIBarButtonItem(title: "Test", style: .plain, target: nil, action: nil)
        
        item.mp.addTargetForAction(target, action: #selector(TestTarget.testAction))
        
        #expect(item.target === target)
        #expect(item.action == #selector(TestTarget.testAction))
    }
    
    // MARK: - Static Property: flexibleSpace
    
    @Test("flexibleSpace should create flexible space bar button item")
    @MainActor
    func testFlexibleSpace() {
        let flexibleSpace = UIBarButtonItem.flexibleSpace
        
        #expect(flexibleSpace.target == nil)
        #expect(flexibleSpace.action == nil)
    }
    
    // MARK: - Static Method: fixedSpace(width:)
    
    @Test("fixedSpace should create fixed space with specified width")
    @MainActor
    func testFixedSpace() {
        let width: CGFloat = 50.0
        let fixedSpace = UIBarButtonItem.fixedSpace(width: width)
        
        #expect(fixedSpace.width == width)
        #expect(fixedSpace.target == nil)
        #expect(fixedSpace.action == nil)
    }
    
    @Test("fixedSpace should work with different widths")
    @MainActor
    func testFixedSpaceDifferentWidths() {
        let width1: CGFloat = 20.0
        let width2: CGFloat = 100.0
        
        let fixedSpace1 = UIBarButtonItem.fixedSpace(width: width1)
        let fixedSpace2 = UIBarButtonItem.fixedSpace(width: width2)
        
        #expect(fixedSpace1.width == width1)
        #expect(fixedSpace2.width == width2)
    }
}
#endif
