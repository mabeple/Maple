//
//  SignedIntegerExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties

public extension MapleWrapper where Base: SignedInteger {
    /// SwifterSwift: Absolute value of integer number.
    var abs: Base {
        return Swift.abs(base)
    }

    /// SwifterSwift: Check if integer is positive.
    var isPositive: Bool {
        return base > 0
    }

    /// SwifterSwift: Check if integer is negative.
    var isNegative: Bool {
        return base < 0
    }

    /// SwifterSwift: Check if integer is even.
    var isEven: Bool {
        return (base % 2) == 0
    }

    /// SwifterSwift: Check if integer is odd.
    var isOdd: Bool {
        return (base % 2) != 0
    }
}
