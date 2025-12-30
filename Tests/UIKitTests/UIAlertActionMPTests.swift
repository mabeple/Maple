//
//  UIAlertActionMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/11/16.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(UIKit)
import UIKit
@MainActor
class UIAlertActionMPTests: XCTestCase {

    func testTitleTextColor() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ActionTitle", style: .destructive, handler: nil)
        alertController.addAction(alertAction)
        alertAction.mp.titleTextColor = UIColor.white
        let color = alertAction.value(forKey: "titleTextColor") as? UIColor
        XCTAssertNotNil(color)
        XCTAssertEqual(color, alertAction.mp.titleTextColor)
        XCTAssertEqual(alertController.actions.count, 1)

        let action = alertController.actions.first
        
        XCTAssertEqual(action?.title, "ActionTitle")
        XCTAssertEqual(action?.style, .destructive)
    }
}
#endif
