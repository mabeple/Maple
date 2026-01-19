//
//  OptionalExtensions.swift
//  Maple
//
//  Created by cy on 2023/2/22.
//  Copyright © 2023 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

extension Optional: MapleCompatibleValue { }

// MARK: - Methods
public extension MapleWrapper {
    
    /// Check if optional collection is nil or empty.
    ///
    ///        let foo: String? = nil
    ///        foo.mp.isNilOrEmpty() -> true
    ///
    ///        let bar: String? = ""
    ///        bar.mp.isNilOrEmpty() -> true
    ///
    ///        let baz: String? = "baz"
    ///        baz.mp.isNilOrEmpty() -> false
    ///
    ///        let array: [Int]? = []
    ///        array.mp.isNilOrEmpty() -> true
    ///
    ///        let numbers: [Int]? = [1, 2, 3]
    ///        numbers.mp.isNilOrEmpty() -> false
    ///
    /// - Returns: `true` if the optional is `nil` or the collection is empty, `false` otherwise.
    func isNilOrEmpty<Wrapped: Collection>() -> Bool where Base == Optional<Wrapped> {
        base?.isEmpty ?? true
    }
    
    /// Get self of default value (if self is nil).
    ///
    ///        let foo: String? = nil
    ///        print(foo.unwrapped(or: "bar")) -> "bar"
    ///
    ///        let bar: String? = "bar"
    ///        print(bar.unwrapped(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: default value to return if self is nil.
    /// - Returns: self if not nil or default value if nil.
    func unwrapped<Wrapped>(or defaultValue: Wrapped) -> Wrapped where Base == Optional<Wrapped> {
        // http://www.russbishop.net/improving-optionals
        return base ?? defaultValue
    }
    
    /// Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.mp.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.mp.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Throws: The error passed in.
    /// - Returns: The value wrapped by the optional.
    func unwrapped<Wrapped>(or error: Error) throws -> Wrapped where Base == Optional<Wrapped> {
        guard let wrapped = base else { throw error }
        return wrapped
    }
}
