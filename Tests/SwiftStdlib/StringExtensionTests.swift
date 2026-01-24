//
//  StringExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

@Suite("String Extensions Test Suite")
struct StringExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("String should conform to MapleCompatibleValue")
    func testStringConformsToMapleCompatibleValue() {
        let string = "Hello"
        let wrapper = string.mp
        #expect(wrapper.base == string)
        #expect(type(of: wrapper) == MapleWrapper<String>.self)
    }
    
    // MARK: - Property: base64Decoded
    
    @Test("base64Decoded should decode base64 string")
    func testBase64Decoded() {
        // Test valid base64
        let encoded1 = "SGVsbG8gV29ybGQh"
        let decoded1 = encoded1.mp.base64Decoded
        #expect(decoded1 == "Hello World!")
        
        // Test with padding
        let encoded2 = "SGVsbG8="
        let decoded2 = encoded2.mp.base64Decoded
        #expect(decoded2 == "Hello")
        
        // Test without padding (should auto-add)
        let encoded3 = "SGVsbG8"
        let decoded3 = encoded3.mp.base64Decoded
        #expect(decoded3 == "Hello")
        
        // Test invalid base64
        let invalid = "Not@Base64!"
        let decoded4 = invalid.mp.base64Decoded
        #expect(decoded4 == nil)
        
        // Test empty string
        let empty = ""
        let decoded5 = empty.mp.base64Decoded
        #expect(decoded5 != nil)
    }
    
    // MARK: - Property: base64Encoded
    
    @Test("base64Encoded should encode string to base64")
    func testBase64Encoded() {
        // Test simple string
        let string1 = "Hello World!"
        let encoded1 = string1.mp.base64Encoded
        #expect(encoded1 == "SGVsbG8gV29ybGQh")
        
        // Test with emoji
        let string2 = "Hello 😀"
        let encoded2 = string2.mp.base64Encoded
        #expect(encoded2 != nil)
        
        // Test empty string
        let string3 = ""
        let encoded3 = string3.mp.base64Encoded
        #expect(encoded3 == "")
        
        // Test round-trip
        let original = "Test String"
        let encoded = original.mp.base64Encoded
        let decoded = encoded?.mp.base64Decoded
        #expect(decoded == original)
    }
    
    // MARK: - Property: containEmoji
    
    @Test("containEmoji should detect emojis in string")
    func testContainEmoji() {
        // Test with emoji
        #expect("Hello 😀".mp.containEmoji == true)
        #expect("😀😃😄".mp.containEmoji == true)
        #expect("❤️".mp.containEmoji == true)
        #expect("🚀".mp.containEmoji == true)
        
        // Test without emoji
        #expect("Hello World".mp.containEmoji == false)
        #expect("123456".mp.containEmoji == false)
        #expect("".mp.containEmoji == false)
        
        // Test with mixed content
        #expect("Hello 😀 World".mp.containEmoji == true)
        #expect("Test 🎉".mp.containEmoji == true)
    }
    
    // MARK: - Property: characters
    
    @Test("characters should return array of characters")
    func testCharacters() {
        let string1 = "Hello"
        let chars1 = string1.mp.characters
        #expect(chars1 == ["H", "e", "l", "l", "o"])
        
        let string2 = ""
        let chars2 = string2.mp.characters
        #expect(chars2.isEmpty)
        
        let string3 = "a"
        let chars3 = string3.mp.characters
        #expect(chars3 == ["a"])
        
        let string4 = "Hi 😀"
        let chars4 = string4.mp.characters
        #expect(chars4.count == 4)
    }
    
    // MARK: - Property: isValidUrl
    
    @Test("isValidUrl should validate URL format")
    func testIsValidUrl() {
        // Valid URLs
        #expect("https://google.com".mp.isValidUrl == true)
        #expect("http://example.com".mp.isValidUrl == true)
        #expect("ftp://server.com".mp.isValidUrl == true)
        
        // Invalid URLs
        #expect("".mp.isValidUrl == false)
        #expect("ht!tp://bad".mp.isValidUrl == false)
    }
    
    // MARK: - Property: isValidEmail
    
    @Test("isValidEmail should validate email format")
    func testIsValidEmail() {
        // Valid emails
        #expect("john@doe.com".mp.isValidEmail == true)
        #expect("test@example.org".mp.isValidEmail == true)
        #expect("user+tag@domain.com".mp.isValidEmail == true)
        
        // Invalid emails
        #expect("notanemail".mp.isValidEmail == false)
        #expect("@example.com".mp.isValidEmail == false)
        #expect("user@".mp.isValidEmail == false)
        #expect("".mp.isValidEmail == false)
    }
    
    // MARK: - Property: isValidSchemedUrl
    
    @Test("isValidSchemedUrl should validate URL with scheme")
    func testIsValidSchemedUrl() {
        #expect("https://google.com".mp.isValidSchemedUrl == true)
        #expect("http://example.com".mp.isValidSchemedUrl == true)
        #expect("ftp://server.com".mp.isValidSchemedUrl == true)
        
        #expect("google.com".mp.isValidSchemedUrl == false)
        #expect("www.example.com".mp.isValidSchemedUrl == false)
    }
    
    // MARK: - Property: isValidHttpsUrl
    
    @Test("isValidHttpsUrl should validate HTTPS URLs")
    func testIsValidHttpsUrl() {
        #expect("https://google.com".mp.isValidHttpsUrl == true)
        #expect("https://example.org".mp.isValidHttpsUrl == true)
        
        #expect("http://google.com".mp.isValidHttpsUrl == false)
        #expect("ftp://server.com".mp.isValidHttpsUrl == false)
        #expect("google.com".mp.isValidHttpsUrl == false)
    }
    
    // MARK: - Property: isValidHttpUrl
    
    @Test("isValidHttpUrl should validate HTTP URLs")
    func testIsValidHttpUrl() {
        #expect("http://google.com".mp.isValidHttpUrl == true)
        #expect("http://example.org".mp.isValidHttpUrl == true)
        
        #expect("https://google.com".mp.isValidHttpUrl == false)
        #expect("ftp://server.com".mp.isValidHttpUrl == false)
        #expect("google.com".mp.isValidHttpUrl == false)
    }
    
    // MARK: - Property: isValidFileUrl
    
    @Test("isValidFileUrl should validate file URLs")
    func testIsValidFileUrl() {
        #expect("file://Documents/file.txt".mp.isValidFileUrl == true)
        #expect("file:///path/to/file".mp.isValidFileUrl == true)
        
        #expect("https://example.com".mp.isValidFileUrl == false)
        #expect("not a url".mp.isValidFileUrl == false)
        
        // Test with empty string (should trigger URL(string:) returning nil)
        #expect("".mp.isValidFileUrl == false)
        
        // Test with string that can't be parsed as URL
        let invalidString = String(repeating: " ", count: 100)
        #expect(invalidString.mp.isValidFileUrl == false)
    }
    
    // MARK: - Property: isDigits
    
    @Test("isDigits should check if string contains only digits")
    func testIsDigits() {
        #expect("123".mp.isDigits == true)
        #expect("0".mp.isDigits == true)
        #expect("123456789".mp.isDigits == true)
        
        #expect("1.3".mp.isDigits == false)
        #expect("abc".mp.isDigits == false)
        #expect("12a".mp.isDigits == false)
        #expect("".mp.isDigits == true) // Empty string is superset
    }
    
    // MARK: - Property: bool
    
    @Test("bool should convert string to boolean")
    func testBool() {
        // True values
        #expect("1".mp.bool == true)
        #expect("true".mp.bool == true)
        #expect("True".mp.bool == true)
        #expect("TRUE".mp.bool == true)
        #expect("yes".mp.bool == true)
        #expect("YES".mp.bool == true)
        
        // False values
        #expect("0".mp.bool == false)
        #expect("false".mp.bool == false)
        #expect("False".mp.bool == false)
        #expect("FALSE".mp.bool == false)
        #expect("no".mp.bool == false)
        #expect("NO".mp.bool == false)
        
        // Invalid values
        #expect("Hello".mp.bool == nil)
        #expect("2".mp.bool == nil)
        #expect("".mp.bool == nil)
        
        // With whitespace
        #expect("  true  ".mp.bool == true)
        #expect("  false  ".mp.bool == false)
    }
    
    // MARK: - Property: int
    
    @Test("int should convert string to integer")
    func testInt() {
        #expect("101".mp.int == 101)
        #expect("0".mp.int == 0)
        #expect("-42".mp.int == -42)
        #expect("999999".mp.int == 999999)
        
        #expect("abc".mp.int == nil)
        #expect("12.5".mp.int == nil)
        #expect("".mp.int == nil)
        #expect("12a".mp.int == nil)
    }
    
    // MARK: - Property: url
    
    @Test("url should convert string to URL")
    func testUrl() {
        let url1 = "https://google.com".mp.url
        #expect(url1?.absoluteString == "https://google.com")
        
        let url2 = "http://example.org".mp.url
        #expect(url2 != nil)

        let url3 = "".mp.url
        #expect(url3 == nil)
    }
    
    // MARK: - Property: trimmed
    
    @Test("trimmed should remove leading and trailing whitespace")
    func testTrimmed() {
        #expect("   hello  \n".mp.trimmed == "hello")
        #expect("  test  ".mp.trimmed == "test")
        #expect("\n\ntext\n\n".mp.trimmed == "text")
        #expect("no spaces".mp.trimmed == "no spaces")
        #expect("   ".mp.trimmed == "")
        #expect("".mp.trimmed == "")
    }
    
    // MARK: - Property: urlDecoded
    
    @Test("urlDecoded should decode URL-encoded string")
    func testUrlDecoded() {
        #expect("it's%20easy%20to%20decode%20strings".mp.urlDecoded == "it's easy to decode strings")
        #expect("Hello%20World".mp.urlDecoded == "Hello World")
        #expect("no%2Bencoding".mp.urlDecoded == "no+encoding")
        #expect("normal string".mp.urlDecoded == "normal string")
        #expect("".mp.urlDecoded == "")
        
        // Test with invalid percent encoding (should trigger removingPercentEncoding returning nil)
        #expect("%".mp.urlDecoded == "%")
        #expect("%Z".mp.urlDecoded == "%Z")
        #expect("%ZZ".mp.urlDecoded == "%ZZ")
        #expect("invalid%".mp.urlDecoded == "invalid%")
    }
    
    // MARK: - Property: urlEncoded
    
    @Test("urlEncoded should encode string for URL")
    func testUrlEncoded() {
        let encoded1 = "it's easy to encode strings".mp.urlEncoded
        #expect(encoded1.contains("%20"))
        
        let encoded2 = "Hello World".mp.urlEncoded
        #expect(encoded2.contains("%20"))
        
        let encoded3 = "simple".mp.urlEncoded
        #expect(encoded3 == "simple")
    }
    
    // MARK: - Property: withoutSpacesAndNewLines
    
    @Test("withoutSpacesAndNewLines should remove all spaces and newlines")
    func testWithoutSpacesAndNewLines() {
        #expect("   \n Swifter   \n  Swift  ".mp.withoutSpacesAndNewLines == "SwifterSwift")
        #expect("Hello World".mp.withoutSpacesAndNewLines == "HelloWorld")
        #expect("a b c".mp.withoutSpacesAndNewLines == "abc")
        #expect("no-spaces".mp.withoutSpacesAndNewLines == "no-spaces")
        #expect("".mp.withoutSpacesAndNewLines == "")
    }
    
    // MARK: - Property: isWhitespace
    
    @Test("isWhitespace should check if string contains only whitespace")
    func testIsWhitespace() {
        #expect("   ".mp.isWhitespace == true)
        #expect("\n\n".mp.isWhitespace == true)
        #expect("\t\t".mp.isWhitespace == true)
        #expect("  \n  ".mp.isWhitespace == true)
        #expect("".mp.isWhitespace == true)
        
        #expect("  text  ".mp.isWhitespace == false)
        #expect("a".mp.isWhitespace == false)
        #expect("Hello".mp.isWhitespace == false)
    }
    
    // MARK: - Method: float
    
    @Test("float should convert string to Float")
    func testFloat() {
        #expect("3.14".mp.float() == 3.14)
        #expect("0.5".mp.float() == 0.5)
        #expect("-2.5".mp.float() == -2.5)
        #expect("100".mp.float() == 100.0)
        
        #expect("abc".mp.float() == nil)
        #expect("".mp.float() == nil)
    }
    
    // MARK: - Method: double
    
    @Test("double should convert string to Double")
    func testDouble() {
        #expect("3.14159".mp.double() == 3.14159)
        #expect("0.5".mp.double() == 0.5)
        #expect("-2.5".mp.double() == -2.5)
        #expect("100".mp.double() == 100.0)
        
        #expect("abc".mp.double() == nil)
        #expect("".mp.double() == nil)
    }
    
    // MARK: - Method: cgFloat
    
    @Test("cgFloat should convert string to CGFloat")
    func testCGFloat() {
        let value1 = "3.14".mp.cgFloat()
        #expect(value1 != nil)
        
        let value2 = "100".mp.cgFloat()
        #expect(value2 != nil)
        
        #expect("abc".mp.cgFloat() == nil)
        #expect("".mp.cgFloat() == nil)
    }
    
    // MARK: - Method: lines
    
    @Test("lines should split string by newlines")
    func testLines() {
        let lines1 = "Hello\ntest".mp.lines()
        #expect(lines1 == ["Hello", "test"])
        
        let lines2 = "Line1\nLine2\nLine3".mp.lines()
        #expect(lines2 == ["Line1", "Line2", "Line3"])
        
        let lines3 = "Single".mp.lines()
        #expect(lines3 == ["Single"])
        
        let lines4 = "".mp.lines()
        #expect(lines4 == [])
    }
    
    // MARK: - Method: copyToPasteboard
    
//    #if os(iOS) || os(macOS)
//    @Test("copyToPasteboard should copy string to clipboard")
//    func testCopyToPasteboard() {
//        let testString = "Test String for Clipboard"
//        testString.mp.copyToPasteboard()
//        
//        // Verify it was copied
//        #if os(iOS)
//        let pasteboardContent = UIPasteboard.general.string
//        #elseif os(macOS)
//        let pasteboardContent = NSPasteboard.general.string(forType: .string)
//        #endif
//        
//        #expect(pasteboardContent == testString)
//    }
//    #endif
    
    // MARK: - Method: contains
    
    @Test("contains should check substring with case sensitivity")
    func testContains() {
        #expect("Hello World!".mp.contains("O") == false)
        #expect("Hello World!".mp.contains("o") == true)
        #expect("Hello World!".mp.contains("o", caseSensitive: false) == true)
        #expect("Hello World!".mp.contains("O", caseSensitive: false) == true)
        #expect("Hello World!".mp.contains("Hello") == true)
        #expect("Hello World!".mp.contains("xyz") == false)
    }
    
    // MARK: - Method: camelize
    
    @Test("camelize should convert to camelCase")
    func testCamelize() {
        #expect("sOme vaRiabLe Name".mp.camelize() == "someVariableName")
        #expect("hello world".mp.camelize() == "helloWorld")
        #expect("test".mp.camelize() == "test")
        #expect("ONE TWO THREE".mp.camelize() == "oneTwoThree")
    }
    
    // MARK: - Method: count
    
    @Test("count should return substring occurrence count")
    func testCount() {
        #expect("Hello World!".mp.count(of: "o") == 2)
        #expect("Hello World!".mp.count(of: "l") == 3)
        #expect("Hello World!".mp.count(of: "L", caseSensitive: false) == 3)
        #expect("Hello World!".mp.count(of: "L") == 0)
        #expect("aaa".mp.count(of: "a") == 3)
        #expect("Hello".mp.count(of: "xyz") == 0)
    }
    
    // MARK: - Method: date
    
    @Test("date should create date from string with format")
    func testDate() {
        let date1 = "2017-01-15".mp.date(withFormat: "yyyy-MM-dd")
        #expect(date1 != nil)
        
        let calendar = Calendar.current
        if let d = date1 {
            #expect(calendar.component(.year, from: d) == 2017)
            #expect(calendar.component(.month, from: d) == 1)
            #expect(calendar.component(.day, from: d) == 15)
        }
        
        let date2 = "not date string".mp.date(withFormat: "yyyy-MM-dd")
        #expect(date2 == nil)
        
        let date3 = "2024/12/25".mp.date(withFormat: "yyyy/MM/dd")
        #expect(date3 != nil)
    }
    
    // MARK: - Method: removingPrefix
    
    @Test("removingPrefix should remove prefix from string")
    func testRemovingPrefix() {
        #expect("Hello, World!".mp.removingPrefix("Hello, ") == "World!")
        #expect("test123".mp.removingPrefix("test") == "123")
        #expect("Hello".mp.removingPrefix("Hi") == "Hello")
        #expect("".mp.removingPrefix("prefix") == "")
    }
    
    // MARK: - Method: removingSuffix
    
    @Test("removingSuffix should remove suffix from string")
    func testRemovingSuffix() {
        #expect("Hello, World!".mp.removingSuffix(", World!") == "Hello")
        #expect("test.txt".mp.removingSuffix(".txt") == "test")
        #expect("Hello".mp.removingSuffix("Bye") == "Hello")
        #expect("".mp.removingSuffix("suffix") == "")
    }
    
    // MARK: - Property: nsString
    
    @Test("nsString should return NSString representation")
    func testNSString() {
        let ns = "Hello".mp.nsString
        #expect(ns.isKind(of: NSString.self))
        #expect(ns as String == "Hello")
    }
    
    // MARK: - Property: lastPathComponent
    
    @Test("lastPathComponent should return last path component")
    func testLastPathComponent() {
        #expect("/path/to/file.txt".mp.lastPathComponent == "file.txt")
        #expect("/Users/John/Documents".mp.lastPathComponent == "Documents")
        #expect("file.txt".mp.lastPathComponent == "file.txt")
    }
    
    // MARK: - Property: pathExtension
    
    @Test("pathExtension should return file extension")
    func testPathExtension() {
        #expect("file.txt".mp.pathExtension == "txt")
        #expect("image.png".mp.pathExtension == "png")
        #expect("archive.tar.gz".mp.pathExtension == "gz")
        #expect("noextension".mp.pathExtension == "")
    }
    
    // MARK: - Property: deletingLastPathComponent
    
    @Test("deletingLastPathComponent should remove last component")
    func testDeletingLastPathComponent() {
        #expect("/path/to/file.txt".mp.deletingLastPathComponent == "/path/to")
        #expect("/Users/John".mp.deletingLastPathComponent == "/Users")
        #expect("file.txt".mp.deletingLastPathComponent == "")
    }
    
    // MARK: - Property: deletingPathExtension
    
    @Test("deletingPathExtension should remove extension")
    func testDeletingPathExtension() {
        #expect("file.txt".mp.deletingPathExtension == "file")
        #expect("/path/to/image.png".mp.deletingPathExtension == "/path/to/image")
        #expect("noextension".mp.deletingPathExtension == "noextension")
    }
    
    // MARK: - Property: pathComponents
    
    @Test("pathComponents should return array of path components")
    func testPathComponents() {
        let components1 = "/path/to/file".mp.pathComponents
        #expect(components1.contains("/"))
        #expect(components1.contains("path"))
        #expect(components1.contains("to"))
        #expect(components1.contains("file"))
        
        let components2 = "file.txt".mp.pathComponents
        #expect(components2 == ["file.txt"])
    }
    
    // MARK: - Method: appendingPathComponent
    
    @Test("appendingPathComponent should append path component")
    func testAppendingPathComponent() {
        #expect("/path/to".mp.appendingPathComponent("file.txt") == "/path/to/file.txt")
        #expect("/Users".mp.appendingPathComponent("John") == "/Users/John")
        #expect("".mp.appendingPathComponent("file") == "file")
    }
    
    // MARK: - Method: appendingPathExtension
    
    @Test("appendingPathExtension should append extension")
    func testAppendingPathExtension() {
        #expect("file".mp.appendingPathExtension("txt") == "file.txt")
        #expect("/path/to/file".mp.appendingPathExtension("png") == "/path/to/file.png")
        
        let result = "image".mp.appendingPathExtension("jpg")
        #expect(result == "image.jpg")
    }
    
    // MARK: - Static Method: random
    
    @Test("random should generate random string of given length")
    func testRandom() {
        let random1 = String.random(ofLength: 10)
        #expect(random1.count == 10)
        
        let random2 = String.random(ofLength: 0)
        #expect(random2.isEmpty)
        
        let random3 = String.random(ofLength: 1)
        #expect(random3.count == 1)
        
        // Test uniqueness
        let random4 = String.random(ofLength: 20)
        let random5 = String.random(ofLength: 20)
        #expect(random4 != random5)
    }
}
