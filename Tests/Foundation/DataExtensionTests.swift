//
//  DataExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Data Extensions Test Suite")
struct DataExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Data should conform to MapleCompatibleValue")
    func testDataConformsToMapleCompatibleValue() {
        let data = Data([0x01, 0x02, 0x03])
        let wrapper = data.mp
        #expect(wrapper.base == data)
    }
    
    // MARK: - Property: bytes
    
    @Test("bytes should return data as array of bytes")
    func testBytes() {
        // Test with simple data
        let data1 = Data([0x01, 0x02, 0x03, 0x04])
        let bytes1 = data1.mp.bytes
        #expect(bytes1 == [0x01, 0x02, 0x03, 0x04])
        
        // Test with empty data
        let data2 = Data()
        let bytes2 = data2.mp.bytes
        #expect(bytes2.isEmpty)
        
        // Test with single byte
        let data3 = Data([0xFF])
        let bytes3 = data3.mp.bytes
        #expect(bytes3 == [0xFF])
        
        // Test with string data
        let string = "Hello"
        let data4 = string.data(using: .utf8)!
        let bytes4 = data4.mp.bytes
        #expect(bytes4.count == 5)
        #expect(bytes4[0] == 0x48) // 'H'
    }
    
    // MARK: - Method: string
    
    @Test("string should convert data to string with encoding")
    func testString() {
        // Test with UTF-8 string
        let string1 = "Hello, World!"
        let data1 = string1.data(using: .utf8)!
        let result1 = data1.mp.string()
        #expect(result1 == string1)
        
        // Test with different encoding
        let string2 = "Hello"
        let data2 = string2.data(using: .ascii)!
        let result2 = data2.mp.string(encoding: .ascii)
        #expect(result2 == string2)
        
        // Test with emoji
        let string3 = "Hello 😀"
        let data3 = string3.data(using: .utf8)!
        let result3 = data3.mp.string()
        #expect(result3 == string3)
        
        // Test with invalid UTF-8 data
        let invalidData = Data([0xFF, 0xFE, 0xFD])
        let result4 = invalidData.mp.string()
        #expect(result4 == nil)
        
        // Test with empty data
        let emptyData = Data()
        let result5 = emptyData.mp.string()
        #expect(result5 == "")
    }
    
    // MARK: - Method: hexEncodedString
    
    @Test("hexEncodedString should return hex representation")
    func testHexEncodedString() {
        // Test with simple bytes
        let data1 = Data([0x48, 0x65, 0x6C, 0x6C, 0x6F]) // "Hello" in hex
        let hex1 = data1.mp.hexEncodedString()
        #expect(hex1 == "48656c6c6f")
        
        // Test with zero bytes
        let data2 = Data([0x00, 0x00])
        let hex2 = data2.mp.hexEncodedString()
        #expect(hex2 == "0000")
        
        // Test with max byte value
        let data3 = Data([0xFF, 0xFF])
        let hex3 = data3.mp.hexEncodedString()
        #expect(hex3 == "ffff")
        
        // Test with empty data
        let data4 = Data()
        let hex4 = data4.mp.hexEncodedString()
        #expect(hex4 == "")
        
        // Test with mixed values
        let data5 = Data([0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF])
        let hex5 = data5.mp.hexEncodedString()
        #expect(hex5 == "0123456789abcdef")
    }
    
    // MARK: - Method: jsonObject
    
    @Test("jsonObject should parse JSON data")
    func testJsonObject() throws {
        // Test with valid JSON object
        let json1 = #"{"name":"John","age":30}"#
        let data1 = json1.data(using: .utf8)!
        let obj1 = try data1.mp.jsonObject() as? [String: Any]
        #expect(obj1 != nil)
        #expect(obj1?["name"] as? String == "John")
        #expect(obj1?["age"] as? Int == 30)
        
        // Test with JSON array
        let json2 = "[1,2,3,4,5]"
        let data2 = json2.data(using: .utf8)!
        let obj2 = try data2.mp.jsonObject() as? [Int]
        #expect(obj2 == [1, 2, 3, 4, 5])
        
        // Test with nested JSON
        let json3 = #"{"user":{"name":"Alice","id":123}}"#
        let data3 = json3.data(using: .utf8)!
        let obj3 = try data3.mp.jsonObject() as? [String: Any]
        let user = obj3?["user"] as? [String: Any]
        #expect(user?["name"] as? String == "Alice")
        #expect(user?["id"] as? Int == 123)
        
        // Test with boolean and null
        let json4 = #"{"active":true,"value":null}"#
        let data4 = json4.data(using: .utf8)!
        let obj4 = try data4.mp.jsonObject() as? [String: Any]
        #expect(obj4?["active"] as? Bool == true)
        #expect(obj4?["value"] is NSNull)
        
        // Test with empty object
        let json5 = "{}"
        let data5 = json5.data(using: .utf8)!
        let obj5 = try data5.mp.jsonObject() as? [String: Any]
        #expect(obj5?.isEmpty == true)
    }
}
