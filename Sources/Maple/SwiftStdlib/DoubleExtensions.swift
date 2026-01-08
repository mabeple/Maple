//
//  DoubleExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif canImport(Android)
import Android
#elseif os(Linux)
import Glibc
#endif

extension Double: MapleCompatibleValue {}

// MARK: - Properties

public extension MapleWrapper where Base == Double {
    /// Int.
    var int: Int {
        return Int(base)
    }

    /// Float.
    var float: Float {
        return Float(base)
    }

    #if canImport(CoreGraphics)
    /// CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(base)
    }
    #endif
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

