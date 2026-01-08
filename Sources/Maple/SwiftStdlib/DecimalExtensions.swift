//
//  DecimalExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

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

extension Decimal: MapleCompatibleValue {}

public extension MapleWrapper where Base == Decimal {
    /// Int.
    var int: Int {
        return NSDecimalNumber(decimal: base).intValue
    }

    /// Double.
    var double: Double {
        return NSDecimalNumber(decimal: base).doubleValue
    }

    #if canImport(CoreGraphics)
    /// CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(NSDecimalNumber(decimal: base).doubleValue)
    }
    #endif
    
    /// Check if the Decimal value is zero
    var isZero: Bool {
        base == 0
    }
    
    /// Check if the Decimal value is positive (> 0)
    var isPositive: Bool {
        base > 0
    }
    
    /// Check if the Decimal value is negative (< 0)
    var isNegative: Bool {
        base < 0
    }
}

public extension MapleWrapper where Base == Decimal {
    /// Round the Decimal to specified number of decimal places with a given rounding mode
    ///
    /// - Parameters:
    ///   - scale: Number of decimal places to keep
    ///   - mode: Rounding mode, default is `.plain` (round half up)
    /// - Returns: A new Decimal rounded to the given scale
    func rounded(scale: Int, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var value = base
        var result = Decimal()
        NSDecimalRound(&result, &value, scale, mode)
        return result
    }
}
