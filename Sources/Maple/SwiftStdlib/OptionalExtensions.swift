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

// MARK: - Properties
public extension Optional {
    /// Check if optional is nil.
    ///
    ///        let foo: String? = nil
    ///        foo.isNil -> true
    ///
    ///        let bar: String? = "bar"
    ///        bar.isNil -> false
    ///
    var isNil: Bool {
        return self == nil
    }
}

// MARK: - Methods
public extension Optional {
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
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        // http://www.russbishop.net/improving-optionals
        return self ?? defaultValue
    }
    
    /// Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Throws: The error passed in.
    /// - Returns: The value wrapped by the optional.
    func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }
}
