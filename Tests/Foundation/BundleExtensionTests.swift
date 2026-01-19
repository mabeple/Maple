//
//  BundleExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Bundle Extensions Test Suite")
struct BundleExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Bundle should conform to MapleCompatible")
    func testBundleConformsToMapleCompatible() {
        let bundle = Bundle.main
        let wrapper = bundle.mp
        #expect(wrapper.base === bundle)
        #expect(type(of: wrapper) == MapleWrapper<Bundle>.self)
    }
    
    // MARK: - Property: displayName
    
    @Test("displayName should return application name")
    func testDisplayName() {
        // Test with Foundation bundle (always available)
        if let foundationBundle = Bundle(identifier: "com.apple.Foundation") {
            let displayName = foundationBundle.mp.displayName
            #expect(displayName != nil)
            if let name = displayName {
                #expect(!name.isEmpty)
            }
        }
        
        // Also test with main bundle for coverage
        let mainDisplayName = Bundle.main.mp.displayName
        if let name = mainDisplayName {
            #expect(!name.isEmpty)
        }
    }
    
    // MARK: - Property: bundleIdentifier
    
    @Test("bundleIdentifier should return bundle identifier")
    func testBundleIdentifier() {
        // Test with Foundation bundle (always available)
        if let foundationBundle = Bundle(identifier: "com.apple.Foundation") {
            let identifier = foundationBundle.mp.bundleIdentifier
            #expect(identifier == "com.apple.Foundation")
            #expect(identifier == foundationBundle.bundleIdentifier)
        }
        
        // Also test with main bundle for coverage
        let mainIdentifier = Bundle.main.mp.bundleIdentifier
        if let id = mainIdentifier {
            #expect(!id.isEmpty)
            #expect(id == Bundle.main.bundleIdentifier)
        }
    }
    
    // MARK: - Property: build
    
    @Test("build should return build number")
    func testBuild() {
        // Test with Foundation bundle
        if let foundationBundle = Bundle(identifier: "com.apple.Foundation") {
            let build = foundationBundle.mp.build
            // Foundation bundle might have build number
            if let buildNumber = build {
                #expect(!buildNumber.isEmpty)
            }
        }
        
        // Also test with main bundle for coverage
        let mainBuild = Bundle.main.mp.build
        if let buildNumber = mainBuild {
            #expect(!buildNumber.isEmpty)
        }
    }
    
    // MARK: - Property: version
    
    @Test("version should return version number")
    func testVersion() {
        // Test with Foundation bundle
        if let foundationBundle = Bundle(identifier: "com.apple.Foundation") {
            let version = foundationBundle.mp.version
            // Foundation bundle should have version
            if let versionNumber = version {
                #expect(!versionNumber.isEmpty)
            }
        }
        
        // Also test with main bundle for coverage
        let mainVersion = Bundle.main.mp.version
        if let versionNumber = mainVersion {
            #expect(!versionNumber.isEmpty)
        }
    }
}
