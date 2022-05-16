//
//  Data+Maple.swift
//  Maple
//
//  Created by cy on 2021/4/29.
//  Copyright © 2021 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
extension Data: MabpleCompatibleValue { }

// MARK: - Properties
public extension MabpleWrapper where Base == Data {
    
    /// Return data as an array of bytes.
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        [UInt8](base)
    }
}

// MARK: - Methods
public extension MabpleWrapper where Base == Data {
    
    /// String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    func string(encoding: String.Encoding = .utf8) -> String? {
        String(data: base, encoding: encoding)
    }
    
    /// Hex encoded string by encoding Data using the given encoding.
    ///
    /// - Returns: Hex encoded string.
    func hexEncodedString() -> String {
        base.map { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        try JSONSerialization.jsonObject(with: base, options: options)
    }
}
#endif
