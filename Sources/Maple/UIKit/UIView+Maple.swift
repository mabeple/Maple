//
//  UIView+Maple.swift
//  Maple
//
//  Created by cy on 2020/4/5.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
extension UIView: MapleCompatible { }

// MARK: - Properties
@MainActor
public extension MapleWrapper where Base: UIView {
    
    /// Corner radius of view;
    var cornerRadius: CGFloat {
        get {
            return base.layer.cornerRadius
        }
        set {
            base.layer.masksToBounds = true
            base.layer.cornerRadius = Swift.abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = base
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// Take screenshot of view (if applicable).
    var screenshot: UIImage? {
        let size = base.layer.frame.size
        guard size != .zero else { return nil }
        return UIGraphicsImageRenderer(size: base.layer.frame.size).image { context in
            base.layer.render(in: context.cgContext)
        }
    }
}

// MARK: - Methods
@MainActor
public extension MapleWrapper where Base: UIView {
    
    /// Recursively find the first responder.
    func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: base)
        var i = 0
        repeat {
            let view = views[i]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            i += 1
        } while i < views.count
        return nil
    }
    
    /// Add shadow to view.
    /// - Parameters:
    ///   - color: shadow color (default is #fffff).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = .black, radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowRadius = radius
        base.layer.shadowOpacity = opacity
        base.layer.masksToBounds = false
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: base.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        base.layer.mask = shape
    }
}
#endif
