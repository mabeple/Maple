//
//  BinaryIntegerExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

// MARK: - Properties

public extension MapleWrapper where Base: BinaryInteger {
    /// The raw bytes of the integer.
    ///
    ///     var number = Int16(-128)
    ///     print(number.mp.bytes)
    ///     // prints "[255, 128]"
    ///
    var bytes: [UInt8] {
        var result = [UInt8]()
        result.reserveCapacity(MemoryLayout<Self>.size)
        var value = base
        for _ in 0..<MemoryLayout<Self>.size {
            result.append(UInt8(truncatingIfNeeded: value))
            value >>= 8
        }
        return result.reversed()
    }
}
