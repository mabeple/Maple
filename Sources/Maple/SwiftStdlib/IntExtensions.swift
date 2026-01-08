//
//  IntExtensions.swift
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

extension Int: MapleCompatibleValue {}

// MARK: - Properties

public extension MapleWrapper where Base == Int {
    /// CountableRange 0..<Int.
    var countableRange: CountableRange<Int> {
        return 0..<base
    }

    /// Radian value of degree input.
    var degreesToRadians: Double {
        return Double.pi * Double(base) / 180.0
    }

    /// Degree value of radian input.
    var radiansToDegrees: Double {
        return Double(base) * 180 / Double.pi
    }

    /// UInt.
    var uInt: UInt {
        return UInt(base)
    }

    /// Double.
    var double: Double {
        return Double(base)
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

    /// Array of digits of integer value.
    var digits: [Int] {
        guard base != 0 else { return [0] }
        var digits = [Int]()
        var number = base.mp.abs

        while number != 0 {
            let xNumber = number % 10
            digits.append(xNumber)
            number /= 10
        }

        digits.reverse()
        return digits
    }

    /// Number of digits of integer value.
    var digitsCount: Int {
        guard base != 0 else { return 1 }
        let number = Double(abs)
        return Int(log10(number) + 1)
    }
}

// MARK: - Methods

public extension MapleWrapper where Base == Int {
    /// check if given integer prime or not. Warning: Using big numbers can be computationally expensive!
    /// - Returns: true or false depending on prime-ness.
    func isPrime() -> Bool {
        // To improve speed on latter loop :)
        if base == 2 { return true }

        guard base > 1, base % 2 != 0 else { return false }

        // Explanation: It is enough to check numbers until
        // the square root of that number. If you go up from N by one,
        // other multiplier will go 1 down to get similar result
        // (integer-wise operation) such way increases speed of operation
        let through = Int(sqrt(Double(base)))
        for int in Swift.stride(from: 3, through: through, by: 2) where base % int == 0 {
            return false
        }
        return true
    }

    /// Roman numeral string from integer (if applicable).
    ///
    ///     10.romanNumeral() -> "X"
    ///
    /// - Returns: The roman numeral string.
    func romanNumeral() -> String? {
        // https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
        guard base > 0 else { // there is no roman numeral for 0 or negative numbers
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

        var romanValue = ""
        var startingValue = base

        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            for _ in 0..<div {
                romanValue.append(romanChar)
            }
            startingValue -= arabicValue * div
        }
        return romanValue
    }

    /// Rounds to the closest multiple of n.
    func roundToNearest(_ number: Int) -> Int {
        return number == 0 ? base : Int(round(Double(base) / Double(number))) * number
    }
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
/// Value of exponentiation.
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ** 3 = 8).
public func ** (lhs: Int, rhs: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(Double(lhs), Double(rhs))
}


prefix operator √
/// Square root of integer.
///
/// - Parameter int: integer value to find square root for.
/// - Returns: square root of given integer.
public prefix func √ (int: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(Double(int))
}


infix operator ±
/// Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: integer number.
///   - rhs: integer number.
/// - Returns: tuple of plus-minus operation (example: 2 ± 3 -> (5, -1)).
public func ± (lhs: Int, rhs: Int) -> (Int, Int) {
    // http://nshipster.com/swift-operators/
    return (lhs + rhs, lhs - rhs)
}


prefix operator ±
/// Tuple of plus-minus operation.
///
/// - Parameter int: integer number.
/// - Returns: tuple of plus-minus operation (example: ± 2 -> (2, -2)).
public prefix func ± (int: Int) -> (Int, Int) {
    // http://nshipster.com/swift-operators/
    return (int, -int)
}
