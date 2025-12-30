//
//  CGRect+Maple.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics

extension CGRect: MapleCompatibleValue { }

// MARK: - Methods

public extension MapleWrapper where Base == CGRect {
    /// Return center of rect.
    var center: CGPoint {
        CGPoint(x: base.midX, y: base.midY)
    }
    
    /// Create a new `CGRect` by resizing with specified anchor.
    /// - Parameters:
    ///   - size: new size to be applied.
    ///   - anchor: specified anchor, a point in normalized coordinates -
    ///     '(0, 0)' is the top left corner of rect，'(1, 1)' is the bottom right corner of rect,
    ///     defaults to '(0.5, 0.5)'. Example:
    ///
    ///          anchor = CGPoint(x: 0.0, y: 1.0):
    ///
    ///                       A2------B2
    ///          A----B       |        |
    ///          |    |  -->  |        |
    ///          C----D       C-------D2
    ///
    func resizing(to size: CGSize, anchor: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> CGRect {
        let sizeDelta = CGSize(width: size.width - base.width, height: size.height - base.height)
        return CGRect(origin: CGPoint(x: base.minX - sizeDelta.width * anchor.x,
                                      y: base.minY - sizeDelta.height * anchor.y),
                      size: size)
    }
}

// MARK: - Initializers

public extension CGRect {
    /// Create a `CGRect` instance with center and size.
    /// - Parameters:
    ///   - center: center of the new rect.
    ///   - size: size of the new rect.
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
}

#endif
