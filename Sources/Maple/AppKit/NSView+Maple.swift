//
//  NSView+Maple.swift
//  Maple
//
//  Created by cy on 2020/5/10.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
extension NSView: MapleCompatible { }

// MARK: - Properties
public extension MapleWrapper where Base: NSView {
    
    /// Corner radius of view; also inspectable from Storyboard.
    var cornerRadius: CGFloat {
        get {
            return base.layer?.cornerRadius ?? 0
        }
        set {
            base.wantsLayer = true
            base.layer?.masksToBounds = true
            base.layer?.cornerRadius = Swift.abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// Background color of the view; also inspectable from Storyboard.
    var backgroundColor: NSColor? {
        get {
            if let colorRef = base.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            base.wantsLayer = true
            base.layer?.backgroundColor = newValue?.cgColor
        }
    }
}

// MARK: - Methods
public extension MapleWrapper where Base: NSView {
    
    /// Add shadow to view.
    /// - Parameters:
    ///   - color: shadow color (default is #fffff).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: NSColor = .black, radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        base.wantsLayer = true
        base.layer?.shadowColor = color.cgColor
        base.layer?.shadowOffset = offset
        base.layer?.shadowRadius = radius
        base.layer?.shadowOpacity = opacity
        base.layer?.masksToBounds = false
    }
}
#endif
