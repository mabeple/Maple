//
//  UISwitchExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UISwitch Extensions Test Suite")
struct UISwitchExtensionTests {
    
    // MARK: - Method: toggle
    
    @Test("toggle should change switch state")
    @MainActor
    func testToggle() {
        let switchControl = UISwitch()
        switchControl.setOn(false, animated: false)
        
        let initialState = switchControl.isOn
        switchControl.mp.toggle(animated: false)
        
        #expect(switchControl.isOn != initialState)
    }
    
    @Test("toggle should work with animated parameter")
    @MainActor
    func testToggleAnimated() {
        let switchControl = UISwitch()
        switchControl.setOn(true, animated: false)
        
        switchControl.mp.toggle(animated: true)
        #expect(switchControl.isOn == false)
        
        switchControl.mp.toggle(animated: false)
        #expect(switchControl.isOn == true)
    }
    
    @Test("toggle should work multiple times")
    @MainActor
    func testToggleMultipleTimes() {
        let switchControl = UISwitch()
        switchControl.setOn(false, animated: false)
        
        #expect(switchControl.isOn == false)
        
        switchControl.mp.toggle(animated: false)
        #expect(switchControl.isOn == true)
        
        switchControl.mp.toggle(animated: false)
        #expect(switchControl.isOn == false)
        
        switchControl.mp.toggle(animated: false)
        #expect(switchControl.isOn == true)
    }
}
#endif
