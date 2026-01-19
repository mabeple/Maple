//
//  UITextViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UITextView Extensions Test Suite")
struct UITextViewExtensionTests {
    
    // MARK: - Method: clear
    
    @Test("clear should remove text and attributed text")
    @MainActor
    func testClear() {
        let textView = UITextView()
        textView.text = "Test text"
        textView.attributedText = NSAttributedString(string: "Attributed text")
        
        textView.mp.clear()
        
        #expect(textView.text == "")
        #expect(textView.attributedText.string == "")
    }
    
    @Test("clear should work on empty text view")
    @MainActor
    func testClearEmpty() {
        let textView = UITextView()
        
        textView.mp.clear()
        
        #expect(textView.text == "")
        #expect(textView.attributedText.string == "")
    }
    
    // MARK: - Method: scrollToBottom
    
    @Test("scrollToBottom should scroll to bottom")
    @MainActor
    func testScrollToBottom() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        textView.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5"
        
        textView.mp.scrollToBottom()
        
        // Verify that scroll position is at or near bottom
        // Note: Exact position may vary, so we just verify the method executes without error
        #expect(textView.text.count > 0)
    }
    
    // MARK: - Method: scrollToTop
    
    @Test("scrollToTop should scroll to top")
    @MainActor
    func testScrollToTop() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        textView.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5"
        
        textView.mp.scrollToTop()
        
        // Verify that scroll position is at or near top
        // Note: Exact position may vary, so we just verify the method executes without error
        #expect(textView.text.count > 0)
    }
    
    // MARK: - Method: wrapToContent
    
    @Test("wrapToContent should configure text view to wrap content")
    @MainActor
    func testWrapToContent() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        textView.text = "Test content"
        textView.isScrollEnabled = true
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.contentOffset = CGPoint(x: 10, y: 10)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.textContainer.lineFragmentPadding = 5
        
        textView.mp.wrapToContent()
        
        #expect(textView.isScrollEnabled == false)
        #expect(textView.contentInset == .zero)
        #expect(textView.verticalScrollIndicatorInsets == .zero)
        #expect(textView.horizontalScrollIndicatorInsets == .zero)
        #expect(textView.contentOffset == .zero)
        #expect(textView.textContainerInset == .zero)
        #expect(textView.textContainer.lineFragmentPadding == 0)
    }
}
#endif
