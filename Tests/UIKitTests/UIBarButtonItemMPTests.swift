//
//  UIBarButtonItemMPTests.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(UIKit) && !os(watchOS)
import UIKit

@MainActor
final class UIBarButtonExtensionsTests: XCTestCase {
    func testFlexibleSpace() {
        let space1 = UIBarButtonItem.flexibleSpace
        let space2 = UIBarButtonItem.flexibleSpace
        // Make sure two different instances are created
        XCTAssert(space1 !== space2)
    }

    func testSelector() {}

    func testAddTargetForAction() {
        let barButton = UIBarButtonItem()
        let selector = #selector(testSelector)

        barButton.mp.addTargetForAction(self, action: selector)

        let target = barButton.target as? UIBarButtonExtensionsTests

        XCTAssertEqual(target, self)
        XCTAssertEqual(barButton.action, selector)
    }

    func testFixedSpace() {
        let width: CGFloat = 120
        let barButtonItem = UIBarButtonItem.fixedSpace(width: width)
        XCTAssertEqual(barButtonItem.width, width)
    }
}

#endif
