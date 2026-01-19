//
//  UIApplicationExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIApplication Extensions Test Suite")
struct UIApplicationExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("UIApplication should conform to MapleCompatible")
    @MainActor
    func testMapleCompatible() {
        let app = UIApplication.shared
        let wrapper = app.mp
        #expect(type(of: wrapper) == MapleWrapper<UIApplication>.self)
    }
    
    // MARK: - Property: safeAreaInsets
    
    @Test("safeAreaInsets should return UIEdgeInsets")
    @MainActor
    func testSafeAreaInsets() {
        let app = UIApplication.shared
        let insets = app.mp.safeAreaInsets
        
        // Should return valid UIEdgeInsets (may be .zero in test environment)
        #expect(type(of: insets) == UIEdgeInsets.self)
    }
    
    // MARK: - Property: statusBarFrame
    
    @Test("statusBarFrame should return CGRect")
    @MainActor
    func testStatusBarFrame() {
        let app = UIApplication.shared
        let frame = app.mp.statusBarFrame
        
        // Should return valid CGRect (may be .zero in test environment)
        #expect(type(of: frame) == CGRect.self)
    }
    
    // MARK: - Property: allEnvironments
    
    @Test("allEnvironments should return all environment cases")
    @MainActor
    func testAllEnvironments() {
        let app = UIApplication.shared
        let allEnvironments = app.mp.allEnvironments
        
        #expect(allEnvironments.count == 3)
        #expect(allEnvironments.contains(.debug))
        #expect(allEnvironments.contains(.testFlight))
        #expect(allEnvironments.contains(.appStore))
    }
    
    // MARK: - Property: environment
    
    @Test("environment should return valid environment")
    @MainActor
    func testEnvironment() {
        let app = UIApplication.shared
        let environment = app.mp.environment
        
        // In test environment, should typically be .debug
        #expect([.debug, .testFlight, .appStore].contains(environment))
    }
    
    @Test("Environment should be CaseIterable")
    func testEnvironmentCaseIterable() {
        let allCases = MapleWrapper<UIApplication>.Environment.allCases
        #expect(allCases.count == 3)
        #expect(allCases.contains(.debug))
        #expect(allCases.contains(.testFlight))
        #expect(allCases.contains(.appStore))
    }
}
#endif
