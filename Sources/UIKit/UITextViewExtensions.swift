//
//  UITextViewExtensions.swift
//  Maple
//
//  Created by cy on 2024/7/6.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

@MainActor
public extension MapleWrapper where Base: UITextView {
    /// Clear text.
    func clear() {
        base.text = ""
        base.attributedText = NSAttributedString(string: "")
    }

    /// Scroll to the bottom of text view.
    func scrollToBottom() {
        let range = NSRange(location: (base.text as NSString).length - 1, length: 1)
        base.scrollRangeToVisible(range)
    }

    /// Scroll to the top of text view.
    func scrollToTop() {
        let range = NSRange(location: 0, length: 1)
        base.scrollRangeToVisible(range)
    }

    /// Wrap to the content (Text / Attributed Text).
    func wrapToContent() {
        base.isScrollEnabled = false
        base.contentInset = .zero
        if #available(iOS 13.0, *) {
            base.verticalScrollIndicatorInsets = .zero
            base.horizontalScrollIndicatorInsets = .zero
        } else {
            base.scrollIndicatorInsets = .zero
        }
        base.contentOffset = .zero
        base.textContainerInset = .zero
        base.textContainer.lineFragmentPadding = 0
        base.sizeToFit()
    }
}

#endif
