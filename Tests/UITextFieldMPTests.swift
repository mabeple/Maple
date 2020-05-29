//
//  UITextFieldMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/5/29.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class UITextFieldMPTests: XCTestCase {
    
    func testIsEmpty() {
        let textField = UITextField()
        XCTAssert(textField.mp.isEmpty)
        textField.text = "Hello"
        XCTAssertFalse(textField.mp.isEmpty)
        textField.text = nil
        XCTAssert(textField.mp.isEmpty)
    }
}
