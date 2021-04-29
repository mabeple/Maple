//
//  DataMPTests.swift
//  Maple
//
//  Created by cy on 2021/4/29.
//  Copyright © 2021 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(Foundation)
import Foundation
class DataMPTests: XCTestCase {
    
    func testString() {
        let dataFromString = "hello".data(using: .utf8)
        XCTAssertNotNil(dataFromString)
        XCTAssertNotNil(dataFromString?.mp.string(encoding: .utf8))
        XCTAssertEqual(dataFromString?.mp.string(encoding: .utf8), "hello")
    }
    
    // https://codebeautify.org/string-hex-converter
    func testhexEncodedString() {
        let dataFromString1 = "hello".data(using: .utf8)
        let hexEncodedString1 = "68656c6c6f"
        XCTAssertNotNil(dataFromString1)
        XCTAssertNotNil(dataFromString1?.mp.hexEncodedString())
        XCTAssertEqual(dataFromString1?.mp.hexEncodedString(), hexEncodedString1)
        
        let dataFromString2 = "world".data(using: .utf8)
        let hexEncodedString2 = "776f726c64"
        XCTAssertNotNil(dataFromString2)
        XCTAssertNotNil(dataFromString2?.mp.hexEncodedString())
        XCTAssertEqual(dataFromString2?.mp.hexEncodedString(), hexEncodedString2)
    }
    
    func testBytes() {
        let dataFromString = "hello".data(using: .utf8)
        let bytes = dataFromString?.mp.bytes
        XCTAssertNotNil(bytes)
        XCTAssertEqual(bytes?.count, 5)
    }
    
    func testJsonObject() {
        let invalidData = "hello".data(using: .utf8)
        XCTAssertThrowsError(try invalidData?.mp.jsonObject())
        XCTAssertThrowsError(try invalidData?.mp.jsonObject(options: [.allowFragments]))
        
        let stringData = "\"hello\"".data(using: .utf8)
        XCTAssertThrowsError(try stringData?.mp.jsonObject())
        XCTAssertEqual((try? stringData?.mp.jsonObject(options: [.allowFragments])) as? String, "hello")
        
        let objectData = "{\"message\": \"hello\"}".data(using: .utf8)
        let object = (try? objectData?.mp.jsonObject()) as? [String: String]
        XCTAssertNotNil(object)
        XCTAssertEqual(object?["message"], "hello")
        
        let arrayData = "[\"hello\"]".data(using: .utf8)
        let array = (try? arrayData?.mp.jsonObject()) as? [String]
        XCTAssertNotNil(array)
        XCTAssertEqual(array?.first, "hello")
    }
}
#endif
