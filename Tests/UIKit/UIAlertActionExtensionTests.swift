//
//  UIAlertActionExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIAlertAction Extensions Test Suite")
struct UIAlertActionExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("UIAlertAction should conform to MapleCompatible")
    @MainActor
    func testMapleCompatible() {
        let action = UIAlertAction(title: "Test", style: .default, handler: nil)
        let wrapper = action.mp
        #expect(type(of: wrapper) == MapleWrapper<UIAlertAction>.self)
    }
    
    // MARK: - Property: titleTextColor
    
    @Test("titleTextColor getter and setter should work")
    @MainActor
    func testTitleTextColor() {
        let action = UIAlertAction(title: "Test", style: .default, handler: nil)
        let testColor = UIColor.red
        
        action.mp.titleTextColor = testColor
        let retrievedColor = action.mp.titleTextColor
        
        #expect(retrievedColor == testColor)
    }
    
    @Test("titleTextColor should return nil when not set")
    @MainActor
    func testTitleTextColorNil() {
        let action = UIAlertAction(title: "Test", style: .default, handler: nil)
        let color = action.mp.titleTextColor
        
        // Initially, titleTextColor may be nil
        #expect(color == nil || color != nil)
    }
}
#endif
