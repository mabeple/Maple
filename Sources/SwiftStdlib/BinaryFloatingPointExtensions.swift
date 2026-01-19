//
//  BinaryFloatingPointExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//

#if os(macOS) || os(iOS)
import Darwin
#elseif canImport(Android)
import Android
#elseif os(Linux)
import Glibc
#endif

// MARK: - Methods

public extension MapleWrapper where Base: BinaryFloatingPoint {
    /// Returns a rounded value with the specified number of decimal places and rounding rule.
    ///
    /// If `numberOfDecimalPlaces` is negative, `0` will be used.
    ///
    ///     let num = 3.1415927
    ///     num.mp.rounded(numberOfDecimalPlaces: 3, rule: .up) -> 3.142
    ///     num.mp.rounded(numberOfDecimalPlaces: 3, rule: .down) -> 3.141
    ///     num.mp.rounded(numberOfDecimalPlaces: 2, rule: .awayFromZero) -> 3.15
    ///     num.mp.rounded(numberOfDecimalPlaces: 4, rule: .towardZero) -> 3.1415
    ///     num.mp.rounded(numberOfDecimalPlaces: -1, rule: .toNearestOrEven) -> 3
    ///
    /// - Parameters:
    ///   - numberOfDecimalPlaces: The expected number of decimal places.
    ///   - rule: The rounding rule to use.
    /// - Returns: The rounded value.
    func rounded(numberOfDecimalPlaces: Int, rule: FloatingPointRoundingRule) -> Base {
        let factor = Base(pow(10.0, Double(max(0, numberOfDecimalPlaces))))
        return (base * factor).rounded(rule) / factor
    }
}
