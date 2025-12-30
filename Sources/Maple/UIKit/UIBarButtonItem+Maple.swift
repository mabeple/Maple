//
//  UIBarButtonItem+Maple.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIBarButtonItem: MapleCompatible { }

// MARK: - Methods
@MainActor
public extension MapleWrapper where Base: UIBarButtonItem {
    /// Add Target to UIBarButtonItem.
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        base.target = target
        base.action = action
    }
}

// MARK: - Extensions
@MainActor
public extension UIBarButtonItem {
    /// Creates a flexible space UIBarButtonItem.
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    /// Creates a fixed space UIBarButtonItem with a specific width.
    ///
    /// - Parameter width: Width of the UIBarButtonItem.
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
}
#endif

