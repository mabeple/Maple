//
//  StringMPTests.swift
//  Maple
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class StringMPTests: XCTestCase {
    var helloWorld = "Hello World!"
    
    func testBase64Decoded() {
        XCTAssertEqual("SGVsbG8gV29ybGQh".mp.base64Decoded, helloWorld)
        XCTAssertEqual("http://example.com/xxx", "aHR0cDovL2V4YW1wbGUuY29tL3h4eA".mp.base64Decoded)
        XCTAssertNil(helloWorld.mp.base64Decoded)
    }
    
    func testBase64Encoded() {
        XCTAssertEqual(helloWorld.mp.base64Encoded, "SGVsbG8gV29ybGQh")
    }
    
    func testCharacters() {
        let str = "Swift"
        let chars = [Character("S"), Character("w"), Character("i"), Character("f"), Character("t")]
        XCTAssertEqual(str.mp.characters, chars)
    }
    
    func testContainEmoji() {
        XCTAssert("Hello 😂".mp.containEmoji)
        XCTAssertFalse("Hello ;)".mp.containEmoji)
    }
    
    func testIsValidUrl() {
        XCTAssert("https://google.com".mp.isValidUrl)
        XCTAssert("http://google.com".mp.isValidUrl)
        XCTAssert("ftp://google.com".mp.isValidUrl)
    }
    
    func testisValidEmail() {
        // https://blogs.msdn.microsoft.com/testing123/2009/02/06/email-address-test-cases/

        XCTAssert("email@domain.com".mp.isValidEmail)
        XCTAssert("firstname.lastname@domain.com".mp.isValidEmail)
        XCTAssert("email@subdomain.domain.com".mp.isValidEmail)
        XCTAssert("firstname+lastname@domain.com".mp.isValidEmail)
        XCTAssert("email@123.123.123.123".mp.isValidEmail)
        XCTAssert("email@[123.123.123.123]".mp.isValidEmail)
        XCTAssert("\"email\"@domain.com".mp.isValidEmail)
        XCTAssert("1234567890@domain.com".mp.isValidEmail)
        XCTAssert("email@domain-one.com".mp.isValidEmail)
        XCTAssert("_______@domain.com".mp.isValidEmail)
        XCTAssert("email@domain.name".mp.isValidEmail)
        XCTAssert("email@domain.co.jp".mp.isValidEmail)
        XCTAssert("firstname-lastname@domain.com".mp.isValidEmail)

        XCTAssertFalse("".mp.isValidEmail)
        XCTAssertFalse("plainaddress".mp.isValidEmail)
        XCTAssertFalse("#@%^%#$@#$@#.com".mp.isValidEmail)
        XCTAssertFalse("@domain.com".mp.isValidEmail)
        XCTAssertFalse("Joe Smith <email@domain.com>".mp.isValidEmail)
        XCTAssertFalse("email.domain.com".mp.isValidEmail)
        XCTAssertFalse("email@domain@domain.com".mp.isValidEmail)
        XCTAssertFalse(".email@domain.com".mp.isValidEmail)
        XCTAssertFalse("email.@domain.com".mp.isValidEmail)
        XCTAssertFalse("email..email@domain.com".mp.isValidEmail)
        XCTAssertFalse("email@domain.com (Joe Smith)".mp.isValidEmail)
        XCTAssertFalse("email@domain".mp.isValidEmail)
        XCTAssertFalse("email@-domain.com".mp.isValidEmail)
        XCTAssertFalse(" email@domain.com".mp.isValidEmail)
        XCTAssertFalse("email@domain.com ".mp.isValidEmail)
        XCTAssertFalse("\nemail@domain.com".mp.isValidEmail)
        XCTAssertFalse("nemail@domain.com   \n\n".mp.isValidEmail)
    }
    
    func testIsValidSchemedUrl() {
        XCTAssertFalse("Hello world!".mp.isValidSchemedUrl)
        XCTAssert("https://google.com".mp.isValidSchemedUrl)
        XCTAssert("ftp://google.com".mp.isValidSchemedUrl)
        XCTAssertFalse("google.com".mp.isValidSchemedUrl)
    }

    func testIsValidHttpsUrl() {
        XCTAssertFalse("Hello world!".mp.isValidHttpsUrl)
        XCTAssert("https://google.com".mp.isValidHttpsUrl)
        XCTAssertFalse("http://google.com".mp.isValidHttpsUrl)
        XCTAssertFalse("google.com".mp.isValidHttpsUrl)
    }

    func testIsValidHttpUrl() {
        XCTAssertFalse("Hello world!".mp.isValidHttpUrl)
        XCTAssert("http://google.com".mp.isValidHttpUrl)
        XCTAssertFalse("google.com".mp.isValidHttpUrl)
    }
    
    func testIsValidFileURL() {
        XCTAssertFalse("Hello world!".mp.isValidFileUrl)
        XCTAssert("file://var/folder/file.txt".mp.isValidFileUrl)
        XCTAssertFalse("google.com".mp.isValidFileUrl)
    }
    
    func testIsDigits() {
        XCTAssert("123".mp.isDigits)
        XCTAssert("987654321".mp.isDigits)
        XCTAssertFalse("123.4".mp.isDigits)
        XCTAssertFalse("1.25e2".mp.isDigits)
        XCTAssertFalse("123abc".mp.isDigits)
    }
    
    func testBool() {
        XCTAssertNotNil("1".mp.bool)
        XCTAssert("1".mp.bool!)

        XCTAssertNotNil("false".mp.bool)
        XCTAssertFalse("false".mp.bool!)
        XCTAssertNil("8s".mp.bool)
    }
    
    func testInt() {
        XCTAssertNotNil("8".mp.int)
        XCTAssertEqual("8".mp.int, 8)

        XCTAssertNil("8s".mp.int)
    }
    
    func testUrl() {
        #if os(Linux)
        XCTAssertNil("hello world".mp.url)
        #else
        if #available(iOS 17.0, macOS 14.0, *) {
            XCTAssertEqual("hello world".mp.url, URL(string: "hello%20world"))
        } else {
            XCTAssertNil("hello world".mp.url)
        }
        #endif

        let google = "https://www.google.com"
        XCTAssertEqual(google.mp.url, URL(string: google))
    }
    
    func testTrimmed() {
        XCTAssertEqual("\n Hello \n ".mp.trimmed, "Hello")
    }

    func testUrlDecoded() {
        XCTAssertEqual("it's%20easy%20to%20encode%20strings".mp.urlDecoded, "it's easy to encode strings")
        XCTAssertEqual("%%".mp.urlDecoded, "%%")
    }

    func testUrlEncoded() {
        XCTAssertEqual("it's easy to encode strings".mp.urlEncoded, "it's%20easy%20to%20encode%20strings")
    }
    
    func testWithoutSpacesAndNewLines() {
        XCTAssertEqual("Hello \n Test".mp.withoutSpacesAndNewLines, "HelloTest")
    }
    
    func testIsWhiteSpaces() {
        var str = "test string"
        XCTAssertEqual(str.mp.isWhitespace, false)

        str = "     "
        XCTAssertEqual(str.mp.isWhitespace, true)

        str = "   \n \n  "
        XCTAssertEqual(str.mp.isWhitespace, true)
    }
    
    func testCopyToPasteboard() {
        let str = "Hello world!"
        #if os(iOS)
//        str.mp.copyToPasteboard()
//        let strFromPasteboard = UIPasteboard.general.string
//        XCTAssertEqual(strFromPasteboard, str)

        #elseif os(macOS)
        str.mp.copyToPasteboard()
        let strFromPasteboard = NSPasteboard.general.string(forType: .string)
        XCTAssertEqual(strFromPasteboard, str)
        #endif
    }
    
    func testFloat() {
        XCTAssertNotNil("8".mp.float())
        XCTAssertEqual("8".mp.float(), 8)

        XCTAssertNotNil("8.23".mp.float(locale: Locale(identifier: "en_US_POSIX")))
        XCTAssertEqual("8.23".mp.float(locale: Locale(identifier: "en_US_POSIX")), Float(8.23))

        #if os(Linux) || targetEnvironment(macCatalyst)
        XCTAssertEqual("8s".mp.float(), 8)
        #else
        XCTAssertNil("8s".mp.float())
        #endif
    }

    func testDouble() {
        XCTAssertNotNil("8".mp.double())
        XCTAssertEqual("8".mp.double(), 8)

        XCTAssertNotNil("8.23".mp.double(locale: Locale(identifier: "en_US_POSIX")))
        XCTAssertEqual("8.23".mp.double(locale: Locale(identifier: "en_US_POSIX")), 8.23)

        #if os(Linux) || targetEnvironment(macCatalyst)
        XCTAssertEqual("8s".mp.double(), 8)
        #else
        XCTAssertNil("8s".mp.double())
        #endif
    }

    func testCgFloat() {
        #if !os(Linux)
        XCTAssertNotNil("8".mp.cgFloat())
        XCTAssertEqual("8".mp.cgFloat(), 8)
        
        XCTAssertNotNil("8.23".mp.cgFloat(locale: Locale(identifier: "en_US_POSIX")))
        XCTAssertEqual("8.23".mp.cgFloat(locale: Locale(identifier: "en_US_POSIX")), CGFloat(8.23))
        
        #if targetEnvironment(macCatalyst)
        XCTAssertEqual("8s".mp.cgFloat(), 8)
        #else
        XCTAssertNil("8s".mp.cgFloat())
        #endif
        #endif
    }
    
    func testLines() {
        #if !os(Linux)
        XCTAssertEqual("Hello\ntest".mp.lines(), ["Hello", "test"])
        #endif
    }
    
    func testLocalized() {
        XCTAssertEqual(helloWorld.mp.localized(), NSLocalizedString(helloWorld, comment: ""))
        XCTAssertEqual(helloWorld.mp.localized(comment: "comment"), NSLocalizedString(helloWorld, comment: "comment"))
    }
    
    func testContain() {
        XCTAssert("Hello Tests".mp.contains("Hello", caseSensitive: true))
        XCTAssert("Hello Tests".mp.contains("hello", caseSensitive: false))
    }
    
    func testCamelize() {
        var str = "Hello test"
        let str1 = str.mp.camelize()
        XCTAssertEqual(str1, "helloTest")

        str = "helloWorld"
        let str2 = str.mp.camelize()
        XCTAssertEqual(str2, "helloworld")
    }
    
    func testCount() {
        XCTAssertEqual("Hello This Tests".mp.count(of: "T"), 2)
        XCTAssertEqual("Hello This Tests".mp.count(of: "t"), 1)
        XCTAssertEqual("Hello This Tests".mp.count(of: "T", caseSensitive: false), 3)
        XCTAssertEqual("Hello This Tests".mp.count(of: "t", caseSensitive: false), 3)
    }
    
    func testDateWithFormat() {
        let dateString = "2012-12-08 17:00:00.0"
        let date = dateString.mp.date(withFormat: "yyyy-dd-MM HH:mm:ss.S")
        XCTAssertNotNil(date)
        XCTAssertNil(dateString.mp.date(withFormat: "Hello world!"))
    }
    
    func testRemovingPrefix() {
        let inputStr = "Hello, World!"
        XCTAssertEqual(inputStr.mp.removingPrefix("Hello, "), "World!")
    }
    
    func testRemovingSuffix() {
        let inputStr = "Hello, World!"
        XCTAssertEqual(inputStr.mp.removingSuffix(", World!"), "Hello")
    }
    
    func testRandom() {
        let str1 = String.random(ofLength: 10)
        XCTAssertEqual(str1.count, 10)

        let str2 = String.random(ofLength: 10)
        XCTAssertEqual(str2.count, 10)

        XCTAssertNotEqual(str1, str2)

        XCTAssertEqual(String.random(ofLength: 0), "")
    }
    
    func testNSString() {
        XCTAssertEqual("Hello".mp.nsString, NSString(string: "Hello"))
    }
    
    func testLastPathComponent() {
        let string = "hello"
        let nsString = NSString(string: "hello")
        XCTAssertEqual(string.mp.lastPathComponent, nsString.lastPathComponent)
    }
    
    func testLastPathExtension() {
        let string = "hello"
        let nsString = NSString(string: "hello")
        XCTAssertEqual(string.mp.pathExtension, nsString.pathExtension)
    }
    
    func testLastDeletingLastPathComponent() {
        let string = "hello"
        let nsString = NSString(string: "hello")
        XCTAssertEqual(string.mp.deletingLastPathComponent, nsString.deletingLastPathComponent)
    }

    func testLastDeletingPathExtension() {
        let string = "hello"
        let nsString = NSString(string: "hello")
        XCTAssertEqual(string.mp.deletingPathExtension, nsString.deletingPathExtension)
    }
    
    func testLastPathComponents() {
        let string = "hello"
        let nsString = NSString(string: "hello")
        XCTAssertEqual(string.mp.pathComponents, nsString.pathComponents)
    }
    
    func testAppendingPathComponent() {
        let string = "hello".mp.appendingPathComponent("world")
        let nsString = NSString(string: "hello").appendingPathComponent("world")
        XCTAssertEqual(string, nsString)
    }
    
    func testAppendingPathExtension() {
        let string = "hello".mp.appendingPathExtension("world")
        let nsString = NSString(string: "hello").appendingPathExtension("world")
        XCTAssertEqual(string, nsString)
    }
    
    func testMD5() {
        if #available(iOS 13.0, OSX 10.15, *) {
            let hash = helloWorld.mp.md5()
            XCTAssertNotEqual(hash, helloWorld)
            XCTAssertNotNil(hash)
            XCTAssertEqual(hash, "ed076287532e86365e841e92bfc50d8c")
            
            let test1 = "“测试MD5....测试md5”"
            let hash1 = test1.mp.md5()
            XCTAssertNotEqual(hash1, test1)
            XCTAssertNotNil(hash1)
            XCTAssertEqual(hash1, "333edda46829a042e36a6fef3321fea0")
            
            let test2 = "//../%¥$.@.测试md5"
            let hash2 = test2.mp.md5()
            XCTAssertNotEqual(hash2, test2)
            XCTAssertNotNil(hash2)
            XCTAssertEqual(hash2, "ae369b15d90c9689801e772c67ea3388")
        }
    }
}
