//
//  UIStackView+Maple.swift
//  Maple-iOS
//
//  Created by cy on 2024/1/6.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension MabpleWrapper where Base: UIStackView {
    /// Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { base.addArrangedSubview($0) }
    }

    /// Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        base.arrangedSubviews.forEach { base.removeArrangedSubview($0) }
    }
}

public extension UIStackView {
    /// Initialize an UIStackView with an array of UIView and common parameters.
    ///
    ///     let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - axis: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views (default:
    /// 0.0).
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis (default: .fill).
    ///   - distribution: The distribution of the arranged views along the stack view’s axis (default: .fill).
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}

#endif
