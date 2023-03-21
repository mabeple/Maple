//
//  String+Maple.swift
//  Maple
//
//  Created by cy on 2020/4/6.
//  Copyright © 2020 cy. All rights reserved.
//
#if canImport(Foundation)
import Foundation
#endif

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif
extension String: MabpleCompatibleValue { }

// MARK: - Properties
public extension MabpleWrapper where Base == String {
    
    #if canImport(Foundation)
    /// String decoded from base64 (if applicable).
    ///
    ///     "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    var base64Decoded: String? {
        //        guard let decodedData = Data(base64Encoded: base) else {return nil}
        //        return String(data: decodedData, encoding: String.Encoding.utf8)
        let remainder = base.count % 4
        var padding = ""
        if remainder > 0 {
        padding = String(repeating: "=", count: 4 - remainder)
        }
        
        guard let data = Data(base64Encoded: base + padding,
        options: .ignoreUnknownCharacters) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    #endif
    
    
    #if canImport(Foundation)
    /// String encoded in base64 (if applicable).
    ///
    ///        "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    var base64Encoded: String? {
        let plainData = base.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    #endif
    
    
    /// Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in base.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF, // Misc symbols
            0x2700...0x27BF, // Dingbats
            0xE0020...0xE007F, // Tags
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            127000...127600, // Various asian characters
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// Array of characters of a string.
    var characters: [Character] {
        Array(base)
    }
    
    #if canImport(Foundation)
    /// Check if string is a valid URL.
    ///
    ///        "https://google.com".isValidUrl -> true
    ///
    var isValidUrl: Bool {
        URL(string: base) != nil
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string is valid email format.
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///        "john@doe.com".isValidEmail -> true
    ///
    var isValidEmail: Bool {
        // http://emailregex.com/
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return base.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string is a valid schemed URL.
    ///
    ///        "https://google.com".isValidSchemedUrl -> true
    ///        "google.com".isValidSchemedUrl -> false
    ///
    var isValidSchemedUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme != nil
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string is a valid https URL.
    ///
    ///        "https://google.com".isValidHttpsUrl -> true
    ///
    var isValidHttpsUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme == "https"
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string is a valid http URL.
    ///
    ///        "http://google.com".isValidHttpUrl -> true
    ///
    var isValidHttpUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme == "http"
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string is a valid file URL.
    ///
    ///        "file://Documents/file.txt".isValidFileUrl -> true
    ///
    var isValidFileUrl: Bool {
        URL(string: base)?.isFileURL ?? false
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string only contains digits.
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    var isDigits: Bool {
        CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: base))
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Bool value from string (if applicable).
    ///
    ///        "1".bool -> true
    ///        "False".bool -> false
    ///        "Hello".bool = nil
    ///
    var bool: Bool? {
        let selfLowercased = base.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Integer value from string (if applicable).
    ///
    ///        "101".int -> 101
    ///
    var int: Int? {
        Int(base)
    }
    #endif
    
    
    #if canImport(Foundation)
    /// URL from string (if applicable).
    ///
    ///        "https://google.com".url -> URL(string: "https://google.com")
    ///        "not url".url -> nil
    ///
    var url: URL? {
        URL(string: base)
    }
    #endif
    
    
    #if canImport(Foundation)
    /// String with no spaces or new lines in beginning and end.
    ///
    ///        "   hello  \n".trimmed -> "hello"
    ///
    var trimmed: String {
        base.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    var urlDecoded: String {
        base.removingPercentEncoding ?? base
    }
    #endif
    
    
    #if canImport(Foundation)
    /// URL escaped string.
    ///
    ///        "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    var urlEncoded: String {
        base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    #endif
    
    
    #if canImport(Foundation)
    /// String without spaces and new lines.
    ///
    ///        "   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    var withoutSpacesAndNewLines: String {
        base.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if the given string contains only white spaces
    var isWhitespace: Bool {
        base.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    #endif
    
}

// MARK: - Methods
public extension MabpleWrapper where Base == String {
    
    #if os(iOS) || os(macOS)
    /// Copy string to global pasteboard.
    ///
    ///        "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = base
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(base, forType: .string)
        #endif
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Float value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: base)?.floatValue
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Double value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: base)?.doubleValue
    }
    #endif
    
    
    #if canImport(CoreGraphics) && canImport(Foundation)
    /// CGFloat value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional CGFloat value from given string.
    func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: base) as? CGFloat
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Array of strings separated by new lines.
    ///
    ///        "Hello\ntest".lines() -> ["Hello", "test"]
    ///
    /// - Returns: Strings separated by new lines.
    func lines() -> [String] {
        var result = [String]()
        base.enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Returns a localized string, with an optional comment for translators.
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    func localized(comment: String = "") -> String {
        return NSLocalizedString(base, comment: comment)
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Check if string contains one or more instance of substring.
    ///
    ///        "Hello World!".contain("O") -> false
    ///        "Hello World!".contain("o", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return base.range(of: string, options: .caseInsensitive) != nil
        }
        return base.range(of: string) != nil
    }
    #endif
    
    
    /// Converts string format to CamelCase.
    ///
    ///        var str = "sOme vaRiabLe Name"
    ///        str.camelize()
    ///        print(str) // prints "someVariableName"
    ///
    func camelize() -> String {
        let source = base.lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    
    #if canImport(Foundation)
    /// Count of substring in string.
    ///
    ///        "Hello World!".count(of: "o") -> 2
    ///        "Hello World!".count(of: "L", caseSensitive: false) -> 3
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return base.lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return base.components(separatedBy: string).count - 1
    }
    #endif
    
    
    #if canImport(Foundation)
    /// Date object from string of date format.
    ///
    ///        "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///        "not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: base)
    }
    #endif
    
    /// Removes given prefix from the string.
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    ///
    /// - Parameter prefix: Prefix to remove from the string.
    /// - Returns: The string after prefix removing.
    func removingPrefix(_ prefix: String) -> String {
        guard base.hasPrefix(prefix) else { return base }
        return String(base.dropFirst(prefix.count))
    }
    
    /// Removes given suffix from the string.
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    ///
    /// - Parameter suffix: Suffix to remove from the string.
    /// - Returns: The string after suffix removing.
    func removingSuffix(_ suffix: String) -> String {
        guard base.hasSuffix(suffix) else { return base }
        return String(base.dropLast(suffix.count))
    }
}


#if canImport(Foundation)
public extension String {
    /// Random string of given length.
    ///
    ///        String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
}
#endif

// MARK: - NSString extensions
#if canImport(Foundation)
public extension MabpleWrapper where Base == String {
    
    /// NSString from a string.
    var nsString: NSString {
        NSString(string: base)
    }
    
    /// NSString lastPathComponent.
    var lastPathComponent: String {
        (base as NSString).lastPathComponent
    }
    
    /// NSString pathExtension.
    var pathExtension: String {
        (base as NSString).pathExtension
    }
    
    /// NSString deletingLastPathComponent.
    var deletingLastPathComponent: String {
        (base as NSString).deletingLastPathComponent
    }
    
    /// NSString deletingPathExtension.
    var deletingPathExtension: String {
        (base as NSString).deletingPathExtension
    }
    
    /// NSString pathComponents.
    var pathComponents: [String] {
        (base as NSString).pathComponents
    }
    
    /// NSString appendingPathComponent(str: String)
    ///
    /// - Note: This method only works with file paths (not, for example, string representations of URLs.
    ///   See NSString [appendingPathComponent(_:)](https://developer.apple.com/documentation/foundation/nsstring/1417069-appendingpathcomponent)
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    func appendingPathComponent(_ str: String) -> String {
        (base as NSString).appendingPathComponent(str)
    }
    
    /// NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    func appendingPathExtension(_ str: String) -> String? {
        (base as NSString).appendingPathExtension(str)
    }
}
#endif


#if canImport(Foundation) && canImport(CryptoKit)
// MARK: - Crypto
import CryptoKit
import Foundation

public extension MabpleWrapper where Base == String {
    
    /// Crypto md5
    @available(iOS 13.0, OSX 10.15, watchOS 6.0, tvOS 13.0, *)
    func md5() -> String {
        let hash = Insecure.MD5.hash(data: Data(base.utf8))
        return hash
            .map { String(format: "%02hhx", $0) }
            .joined()
    }
}
#endif
