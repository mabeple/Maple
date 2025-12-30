//
//  UITextFieldMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/5/29.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple

@MainActor
class UITextFieldMPTests: XCTestCase {
    
    func testIsEmpty() {
        let textField = UITextField()
        XCTAssert(textField.mp.isEmpty)
        textField.text = "Hello"
        XCTAssertFalse(textField.mp.isEmpty)
        textField.text = nil
        XCTAssert(textField.mp.isEmpty)
    }
    
    func testTrimmedText() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let textField = UITextField(frame: frame)
        textField.text = "Hello \n    \n"
        XCTAssertNotNil(textField.mp.trimmedText)
        XCTAssertEqual(textField.mp.trimmedText!, "Hello")
    }
    
    func testLeftViewTintColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let textField = UITextField(frame: frame)

        let imageView = UIImageView()
        imageView.tintColor = .red

        textField.leftView = imageView
        XCTAssertEqual(textField.mp.leftViewTintColor, .red)

        textField.mp.leftViewTintColor = .blue
        XCTAssertEqual(textField.mp.leftViewTintColor, .blue)

        textField.leftView = nil
        XCTAssertNil(textField.mp.leftViewTintColor)

        textField.mp.leftViewTintColor = .yellow
        XCTAssertNil(textField.mp.leftViewTintColor)
    }
    
    func testRightViewTintColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let textField = UITextField(frame: frame)

        let imageView = UIImageView()
        imageView.tintColor = .red

        textField.rightView = imageView
        XCTAssertEqual(textField.mp.rightViewTintColor, .red)

        textField.mp.rightViewTintColor = .blue
        XCTAssertEqual(textField.mp.rightViewTintColor, .blue)

        textField.rightView = nil
        XCTAssertNil(textField.mp.rightViewTintColor)

        textField.mp.rightViewTintColor = .yellow
        XCTAssertNil(textField.mp.rightViewTintColor)
    }

    func testClear() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let textField = UITextField(frame: frame)
        textField.text = "Hello"
        textField.mp.clear()
        XCTAssertEqual(textField.text!, "")
    }

    func testSetPlaceHolderTextColor() {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Attributed Placeholder")
        textField.mp.setPlaceHolderTextColor(.blue)
        let color = textField.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        XCTAssertEqual(color, .blue)

        textField.placeholder = nil
        textField.mp.setPlaceHolderTextColor(.yellow)
        let emptyColor = textField.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        XCTAssertNil(emptyColor)
    }
    
    func testAddPaddingLeft() {
        let textfield = UITextField()
        textfield.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        textfield.mp.addPaddingLeft(40)
        XCTAssertEqual(textfield.leftView?.frame.width, 40)
    }
    
    func testAddPaddingLeftIcon() {
        let textfield = UITextField()
        textfield.frame = CGRect(x: 0, y: 0, width: 100, height: 44)

        let bundle = Bundle.init(for: UITextFieldMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        textfield.mp.addPaddingLeftIcon(image, padding: 5)
        XCTAssertEqual(textfield.leftView?.frame.width, image.size.width + 5)
    }
    
    func testAddPaddingRight() {
        let textfield = UITextField()
        textfield.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        textfield.mp.addPaddingRight(40)
        XCTAssertEqual(textfield.rightView?.frame.width, 40)
    }
    
    func testAddPaddingRightIcon() {
        let textfield = UITextField()
        textfield.frame = CGRect(x: 0, y: 0, width: 100, height: 44)

        let bundle = Bundle.init(for: UITextFieldMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        textfield.mp.addPaddingRightIcon(image, padding: 5)
        XCTAssertEqual(textfield.rightView?.frame.width, image.size.width + 5)
    }
}
