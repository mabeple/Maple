//
//  UITextField+Maple.swift
//  Maple
//
//  Created by cy on 2020/5/6.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension MabpleWrapper where Base: UITextField {
    
    /// Check if text field is empty.
    var isEmpty: Bool {
        base.text?.isEmpty == true
    }
    
    /// Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
        base.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Left view tint color.
    var leftViewTintColor: UIColor? {
        get {
            guard let iconView = base.leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = base.leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    /// Right view tint color.
    var rightViewTintColor: UIColor? {
        get {
            guard let iconView = base.rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = base.rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
}

// MARK: - Methods
public extension MabpleWrapper where Base: UITextField {
    
    /// Clear text.
    func clear() {
        base.text = ""
        base.attributedText = NSAttributedString(string: "")
    }
    
    /// Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = base.placeholder, !holder.isEmpty else { return }
        base.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    /// Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: base.frame.height))
        base.leftView = paddingView
        base.leftViewMode = .always
    }
    
    /// Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        base.leftView = imageView
        base.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        base.leftViewMode = .always
    }
}
#endif
