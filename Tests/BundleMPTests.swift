//
//  BundleMPTests.swift
//  Maple
//
//  Created by cy on 2020/6/3.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class BundleMPTests: XCTestCase {
    let iosBundle = Bundle(identifier: "com.cmapu.Maple-iOS")
    let macOSBundle = Bundle(identifier: "com.cmapu.Maple-macOS")
    
    func testDisplayName() {
        #if os(iOS)
        let displayName = iosBundle?.mp.displayName
        XCTAssertNotNil(displayName)
        XCTAssertEqual(displayName, "Maple")
        #elseif os(macOS)
        let displayName = macOSBundle?.mp.displayName
        print(displayName)
        XCTAssertNotNil(displayName)
        XCTAssertEqual(displayName, "Maple")
        #endif
    }
    
    func testBundleIdentifier() {
        #if os(iOS)
        let bundleIdentifier = iosBundle?.mp.bundleIdentifier
        XCTAssertNotNil(bundleIdentifier)
        XCTAssertEqual(bundleIdentifier, "com.cmapu.Maple-iOS")
        #elseif os(macOS)
        let bundleIdentifier = macOSBundle?.mp.bundleIdentifier
        XCTAssertNotNil(bundleIdentifier)
        XCTAssertEqual(bundleIdentifier, "com.cmapu.Maple-macOS")
        #endif
    }
    
    func testBuild() {
        #if os(iOS)
        let build = iosBundle?.mp.build
        XCTAssertNotNil(build)
        XCTAssertEqual(build, "1")
        #elseif os(macOS)
        let build = macOSBundle?.mp.build
        XCTAssertNotNil(build)
        XCTAssertEqual(build, "1")
        #endif
    }
    
    func testVersion() {
        #if os(iOS)
        let build = iosBundle?.mp.version
        XCTAssertNotNil(build)
        XCTAssertEqual(build, "1.0")
        #elseif os(macOS)
        let build = macOSBundle?.mp.version
        XCTAssertNotNil(build)
        XCTAssertEqual(build, "1.0")
        #endif
    }
}