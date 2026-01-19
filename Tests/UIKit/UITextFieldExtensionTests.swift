//
//  UITextFieldExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UITextField Extensions Test Suite")
struct UITextFieldExtensionTests {
    
    // MARK: - Test Helpers
    
    /// Load test image from resources
    static func loadTestImage() -> UIImage {
        guard let image = UIImage(named: "TestImage", in: Bundle.module, compatibleWith: nil) else {
            // Fallback to creating a simple test image if resource not found
            return UIImage(color: .red, size: CGSize(width: 20, height: 20))
        }
        return image
    }
    
    // MARK: - Property: isEmpty
    
    @Test("isEmpty should return true for empty text field")
    @MainActor
    func testIsEmpty() {
        let textField = UITextField()
        textField.text = ""
        
        #expect(textField.mp.isEmpty == true)
    }
    
    @Test("isEmpty should return false for non-empty text field")
    @MainActor
    func testIsNotEmpty() {
        let textField = UITextField()
        textField.text = "Test"
        
        #expect(textField.mp.isEmpty == false)
    }
    
    @Test("isEmpty should return true when text is nil")
    @MainActor
    func testIsEmptyNil() {
        let textField = UITextField()
        textField.text = nil
        
        #expect(textField.mp.isEmpty == true)
    }
    
    // MARK: - Property: trimmedText
    
    @Test("trimmedText should remove leading and trailing whitespace")
    @MainActor
    func testTrimmedText() {
        let textField = UITextField()
        textField.text = "  Test  "
        
        #expect(textField.mp.trimmedText == "Test")
    }
    
    @Test("trimmedText should remove newlines")
    @MainActor
    func testTrimmedTextNewlines() {
        let textField = UITextField()
        textField.text = "\nTest\n"
        
        #expect(textField.mp.trimmedText == "Test")
    }
    
    @Test("trimmedText should return nil or empty string when text is nil")
    @MainActor
    func testTrimmedTextNil() {
        let textField = UITextField()
        textField.text = nil
        
        // UITextField.text may return empty string instead of nil after setting to nil
        // So trimmedText may return empty string instead of nil
        let trimmed = textField.mp.trimmedText
        #expect(trimmed == nil || trimmed == "")
    }
    
    // MARK: - Property: leftViewTintColor
    
    @Test("leftViewTintColor should get and set color for UIImageView")
    @MainActor
    func testLeftViewTintColor() {
        let textField = UITextField()
        let imageView = UIImageView(image: Self.loadTestImage())
        textField.leftView = imageView
        textField.leftViewMode = .always
        
        let testColor = UIColor.red
        textField.mp.leftViewTintColor = testColor
        
        #expect(textField.mp.leftViewTintColor == testColor)
    }
    
    @Test("leftViewTintColor should return nil for non-UIImageView")
    @MainActor
    func testLeftViewTintColorNonImageView() {
        let textField = UITextField()
        let view = UIView()
        textField.leftView = view
        textField.leftViewMode = .always
        
        #expect(textField.mp.leftViewTintColor == nil)
    }
    
    // MARK: - Property: rightViewTintColor
    
    @Test("rightViewTintColor should get and set color for UIImageView")
    @MainActor
    func testRightViewTintColor() {
        let textField = UITextField()
        let imageView = UIImageView(image: Self.loadTestImage())
        textField.rightView = imageView
        textField.rightViewMode = .always
        
        let testColor = UIColor.blue
        textField.mp.rightViewTintColor = testColor
        
        #expect(textField.mp.rightViewTintColor == testColor)
    }
    
    @Test("rightViewTintColor should return nil for non-UIImageView")
    @MainActor
    func testRightViewTintColorNonImageView() {
        let textField = UITextField()
        let view = UIView()
        textField.rightView = view
        textField.rightViewMode = .always
        
        #expect(textField.mp.rightViewTintColor == nil)
    }
    
    // MARK: - Method: clear
    
    @Test("clear should remove text and attributed text")
    @MainActor
    func testClear() {
        let textField = UITextField()
        textField.text = "Test text"
        textField.attributedText = NSAttributedString(string: "Attributed text")
        
        textField.mp.clear()
        
        #expect(textField.text == "")
        #expect(textField.attributedText?.string == "")
    }
    
    // MARK: - Method: setPlaceHolderTextColor
    
    @Test("setPlaceHolderTextColor should set placeholder color")
    @MainActor
    func testSetPlaceHolderTextColor() {
        let textField = UITextField()
        textField.placeholder = "Test placeholder"
        let testColor = UIColor.green
        
        textField.mp.setPlaceHolderTextColor(testColor)
        
        #expect(textField.attributedPlaceholder != nil)
        if let attributedPlaceholder = textField.attributedPlaceholder {
            let color = attributedPlaceholder.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
            #expect(color == testColor)
        }
    }
    
    @Test("setPlaceHolderTextColor should not set color when placeholder is empty")
    @MainActor
    func testSetPlaceHolderTextColorEmpty() {
        let textField = UITextField()
        textField.placeholder = ""
        
        // Store initial attributedPlaceholder state
        let initialAttributedPlaceholder = textField.attributedPlaceholder
        
        textField.mp.setPlaceHolderTextColor(.red)
        
        // Should not crash, and should not set attributedPlaceholder when placeholder is empty
        // UITextField may convert empty string to nil, so check both cases
        #expect(textField.placeholder == "" || textField.placeholder == nil)
        // attributedPlaceholder should remain unchanged (nil or original value)
        #expect(textField.attributedPlaceholder == initialAttributedPlaceholder)
    }
    
    // MARK: - Method: addPaddingLeft
    
    @Test("addPaddingLeft should add left padding view")
    @MainActor
    func testAddPaddingLeft() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let padding: CGFloat = 10.0
        
        textField.mp.addPaddingLeft(padding)
        
        #expect(textField.leftView != nil)
        #expect(textField.leftViewMode == .always)
        #expect(textField.leftView?.frame.width == padding)
    }
    
    // MARK: - Method: addPaddingLeftIcon
    
    @Test("addPaddingLeftIcon should add left icon with padding")
    @MainActor
    func testAddPaddingLeftIcon() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let image = Self.loadTestImage()
        let padding: CGFloat = 5.0
        
        textField.mp.addPaddingLeftIcon(image, padding: padding)
        
        #expect(textField.leftView != nil)
        #expect(textField.leftView is UIImageView)
        #expect(textField.leftViewMode == .always)
    }
    
    // MARK: - Method: addPaddingRight
    
    @Test("addPaddingRight should add right padding view")
    @MainActor
    func testAddPaddingRight() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let padding: CGFloat = 15.0
        
        textField.mp.addPaddingRight(padding)
        
        #expect(textField.rightView != nil)
        #expect(textField.rightViewMode == .always)
        #expect(textField.rightView?.frame.width == padding)
    }
    
    // MARK: - Method: addPaddingRightIcon
    
    @Test("addPaddingRightIcon should add right icon with padding")
    @MainActor
    func testAddPaddingRightIcon() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let image = Self.loadTestImage()
        let padding: CGFloat = 8.0
        
        textField.mp.addPaddingRightIcon(image, padding: padding)
        
        #expect(textField.rightView != nil)
        #expect(textField.rightView is UIImageView)
        #expect(textField.rightViewMode == .always)
    }
}
#endif
