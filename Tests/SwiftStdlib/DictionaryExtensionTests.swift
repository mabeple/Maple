//
//  DictionaryExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Dictionary Extensions Test Suite")
struct DictionaryExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Dictionary should conform to MapleCompatibleValue")
    func testDictionaryConformsToMapleCompatibleValue() {
        let dict: [String: Int] = ["key": 1]
        let wrapper = dict.mp
        #expect(wrapper.base == dict)
        #expect(type(of: wrapper) == MapleWrapper<[String: Int]>.self)
    }
    
    // MARK: - Method: has
    
    @Test("has should check if key exists in dictionary")
    func testHas() {
        let dict: [String: Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
        #expect(dict.mp.has(key: "testKey") == true)
        #expect(dict.mp.has(key: "anotherKey") == false)
        #expect(dict.mp.has(key: "testArrayKey") == true)
    }
    
    // MARK: - Method: jsonData
    
    #if canImport(Foundation)
    @Test("jsonData should convert dictionary to JSON data")
    func testJsonData() {
        let dict: [String: Any] = ["key1": "value1", "key2": 42]
        let jsonData = dict.mp.jsonData()
        #expect(jsonData != nil)
        
        // Test prettify=false (default)
        let jsonDataNotPrettified = dict.mp.jsonData(prettify: false)
        #expect(jsonDataNotPrettified != nil)
        
        let invalidDict: [String: Any] = ["key": Date()]
        let invalidJsonData = invalidDict.mp.jsonData()
        #expect(invalidJsonData == nil)
        
        let prettified = dict.mp.jsonData(prettify: true)
        #expect(prettified != nil)
    }
    #endif
    
    // MARK: - Method: jsonString
    
    #if canImport(Foundation)
    @Test("jsonString should convert dictionary to JSON string")
    func testJsonString() {
        let dict: [String: Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
        let jsonString = dict.mp.jsonString()
        #expect(jsonString != nil)
        #expect(jsonString?.contains("testKey") == true)
        
        // Test prettify=false (default)
        let jsonStringNotPrettified = dict.mp.jsonString(prettify: false)
        #expect(jsonStringNotPrettified != nil)
        #expect(jsonStringNotPrettified?.contains("testKey") == true)
        
        let prettified = dict.mp.jsonString(prettify: true)
        #expect(prettified != nil)
        #expect(prettified?.contains("\n") == true)
        
        let invalidDict: [String: Any] = ["key": Date()]
        let invalidJsonString = invalidDict.mp.jsonString()
        #expect(invalidJsonString == nil)
    }
    #endif
    
    // MARK: - Method: pick
    
    @Test("pick should create dictionary with specified keys")
    func testPick() {
        let dict: [String: Int] = ["key1": 1, "key2": 2, "key3": 3, "key4": 4]
        let picked = dict.mp.pick(keys: ["key1", "key3", "key4"])
        #expect(picked.count == 3)
        #expect(picked["key1"] == 1)
        #expect(picked["key3"] == 3)
        #expect(picked["key4"] == 4)
        #expect(picked["key2"] == nil)
        
        let picked2 = dict.mp.pick(keys: ["key2"])
        #expect(picked2.count == 1)
        #expect(picked2["key2"] == 2)
        
        let picked3 = dict.mp.pick(keys: ["nonexistent"])
        #expect(picked3.isEmpty)
    }
    
    // MARK: - Method: keys
    
    @Test("keys should return all keys for given value")
    func testKeys() {
        let dict: [String: String] = ["key1": "value1", "key2": "value1", "key3": "value2"]
        let keys1 = dict.mp.keys(forValue: "value1")
        #expect(keys1.count == 2)
        #expect(keys1.contains("key1"))
        #expect(keys1.contains("key2"))
        
        let keys2 = dict.mp.keys(forValue: "value2")
        #expect(keys2.count == 1)
        #expect(keys2.contains("key3"))
        
        let keys3 = dict.mp.keys(forValue: "value3")
        #expect(keys3.isEmpty)
    }
    
    // MARK: - Method: mapKeysAndValues
    
    @Test("mapKeysAndValues should transform dictionary")
    func testMapKeysAndValues() {
        let dict: [String: Int] = ["a": 1, "b": 2, "c": 3]
        let mapped = dict.mp.mapKeysAndValues { (key, value) in
            (key.uppercased(), value * 2)
        }
        #expect(mapped["A"] == 2)
        #expect(mapped["B"] == 4)
        #expect(mapped["C"] == 6)
        #expect(mapped.count == 3)
        
        // Test changing key and value types
        let dict2: [String: Int] = ["a": 1, "bb": 2, "ccc": 3]
        let mapped2 = dict2.mp.mapKeysAndValues { (key, value) in
            (key.count, String(value))
        }
        #expect(mapped2[1] == "1") // "a" has count 1
        #expect(mapped2[2] == "2") // "bb" has count 2
        #expect(mapped2[3] == "3") // "ccc" has count 3
        #expect(mapped2.count == 3)
    }
    
    // MARK: - Method: compactMapKeysAndValues
    
    @Test("compactMapKeysAndValues should transform and filter dictionary")
    func testCompactMapKeysAndValues() {
        let dict: [String: Int] = ["a": 1, "b": 2, "c": 3]
        let compacted = dict.mp.compactMapKeysAndValues { (key, value) in
            value > 1 ? (key.uppercased(), value * 2) : nil
        }
        #expect(compacted.count == 2)
        #expect(compacted["B"] == 4)
        #expect(compacted["C"] == 6)
        #expect(compacted["A"] == nil)
        
        // Test all nil
        let allNil: [String: Int] = dict.mp.compactMapKeysAndValues { (key, value) in
            nil as (String, Int)?
        }
        #expect(allNil.isEmpty)
    }
    
    // MARK: - Method: lowercaseAllKeys
    
    @Test("lowercaseAllKeys should lowercase all keys")
    func testLowercaseAllKeys() {
        let dict: [String: Int] = ["tEstKeY": 1, "ANOTHER": 2]
        let lowercased = dict.mp.lowercaseAllKeys()
        #expect(lowercased["testkey"] == 1)
        #expect(lowercased["another"] == 2)
        #expect(lowercased["tEstKeY"] == nil)
        
        // Test empty dictionary
        let emptyDict: [String: Int] = [:]
        let emptyLowercased = emptyDict.mp.lowercaseAllKeys()
        #expect(emptyLowercased.isEmpty)
        
        // Test with Substring keys (StringProtocol)
        let substringDict: [String: Int] = ["Test": 1, "Key": 2]
        let substringLowercased = substringDict.mp.lowercaseAllKeys()
        #expect(substringLowercased["test"] == 1)
        #expect(substringLowercased["key"] == 2)
    }
    
    // MARK: - Initializer: grouping
    
    @Test("grouping initializer should group sequence by key path")
    func testGroupingInitializer() {
        struct Person {
            let name: String
            let age: Int
        }
        
        let people = [
            Person(name: "Alice", age: 20),
            Person(name: "Bob", age: 20),
            Person(name: "Charlie", age: 30)
        ]
        
        let grouped: [Int: [Person]] = Dictionary(grouping: people, by: \.age)
        #expect(grouped[20]?.count == 2)
        #expect(grouped[30]?.count == 1)
    }
    
    // MARK: - Method: removeAll (keys)
    
    @Test("removeAll keys should remove specified keys")
    func testRemoveAllKeys() {
        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        dict.removeAll(keys: ["key1", "key2"])
        #expect(dict.keys.contains("key3"))
        #expect(!dict.keys.contains("key1"))
        #expect(!dict.keys.contains("key2"))
        
        // Test empty sequence
        var dict2: [String: String] = ["key1": "value1"]
        dict2.removeAll(keys: [])
        #expect(dict2.keys.contains("key1"))
        
        // Test removing non-existent keys
        var dict3: [String: String] = ["key1": "value1"]
        dict3.removeAll(keys: ["nonexistent"])
        #expect(dict3.keys.contains("key1"))
    }
    
    // MARK: - Method: removeValueForRandomKey
    
    @Test("removeValueForRandomKey should remove random key")
    func testRemoveValueForRandomKey() {
        var dict: [String: Int] = ["key1": 1, "key2": 2, "key3": 3]
        let originalCount = dict.count
        let removed = dict.removeValueForRandomKey()
        #expect(removed != nil)
        #expect(dict.count == originalCount - 1)
        
        var emptyDict: [String: Int] = [:]
        let removedFromEmpty = emptyDict.removeValueForRandomKey()
        #expect(removedFromEmpty == nil)
    }
    
    // MARK: - Subscript: path
    
    @Test("path subscript should access nested dictionary")
    func testPathSubscript() {
        var dict: [String: Any] = ["key": ["key1": ["key2": "value"]]]
        
        // Test get with valid nested path
        let value = dict[path: ["key", "key1", "key2"]] as? String
        #expect(value == "value")
        
        // Test get with single key
        let singleValue = dict[path: ["key"]] as? [String: Any]
        #expect(singleValue != nil)
        
        // Test set with path.count == 1 (direct assignment)
        var dict2: [String: Any] = ["key1": "value1"]
        dict2[path: ["key1"]] = "newValue1"
        let newValue1 = dict2[path: ["key1"]] as? String
        #expect(newValue1 == "newValue1")
        
        // Test set with nested path (existing nested dictionary)
        dict[path: ["key", "key1", "key2"]] = "newValue"
        let newValue = dict[path: ["key", "key1", "key2"]] as? String
        #expect(newValue == "newValue")
        
        // Test set with nested path where nested exists
        var dict3: [String: Any] = ["key": ["key1": "value1"]]
        dict3[path: ["key", "key1"]] = "updatedValue"
        let updatedValue = dict3[path: ["key", "key1"]] as? String
        #expect(updatedValue == "updatedValue")
        
        // Test set creating deeper nested path (only works when intermediate values are dictionaries)
        var dict4: [String: Any] = ["key": ["key1": ["key2": [:]]]]
        dict4[path: ["key", "key1", "key2", "key3"]] = "deepValue"
        let deepValue = dict4[path: ["key", "key1", "key2", "key3"]] as? String
        #expect(deepValue == "deepValue")
        
        // Test that setting fails when intermediate value is not a dictionary
        var dict4b: [String: Any] = ["key": ["key1": ["key2": "value"]]]
        dict4b[path: ["key", "key1", "key2", "key3"]] = "deepValue"
        // When key2 is a string, cannot create deeper path, so key3 won't exist
        let shouldBeNil = dict4b[path: ["key", "key1", "key2", "key3"]] as? String
        #expect(shouldBeNil == nil)
        
        // Test invalid path (get) - non-existent intermediate key
        let invalid = dict[path: ["key", "nonexistent"]]
        #expect(invalid == nil)
        
        // Test invalid path (get) - non-existent first key
        let invalidFirst = dict[path: ["nonexistent", "key"]]
        #expect(invalidFirst == nil)
        
        // Test empty path (get)
        let empty = dict[path: []]
        #expect(empty == nil)
        
        // Test set with empty path (should not modify - path.first is nil)
        var dict5: [String: Any] = ["key": "value"]
        dict5[path: []] = "shouldNotChange"
        #expect((dict5["key"] as? String) == "value")
        
        // Test set with path where first key doesn't exist (should not create)
        var dict6: [String: Any] = [:]
        dict6[path: ["nonexistent", "key"]] = "value"
        // Should not create the path if first key doesn't exist and isn't a dictionary
        #expect(dict6.isEmpty)
        
        // Test set with path where first key exists but isn't a dictionary
        var dict7: [String: Any] = ["key": "notADict"]
        dict7[path: ["key", "nested"]] = "value"
        // Should not modify since "key" is not a dictionary
        let stillNotADict = dict7["key"] as? String
        #expect(stillNotADict == "notADict")
    }
    
    // MARK: - Operator: +
    
    @Test("plus operator should merge dictionaries")
    func testPlusOperator() {
        let dict1: [String: String] = ["key1": "value1"]
        let dict2: [String: String] = ["key2": "value2"]
        let result = dict1 + dict2
        #expect(result["key1"] == "value1")
        #expect(result["key2"] == "value2")
        #expect(result.count == 2)
    }
    
    // MARK: - Operator: +=
    
    @Test("plus equals operator should append dictionary")
    func testPlusEqualsOperator() {
        var dict: [String: String] = ["key1": "value1"]
        let dict2: [String: String] = ["key2": "value2"]
        dict += dict2
        #expect(dict["key1"] == "value1")
        #expect(dict["key2"] == "value2")
        #expect(dict.count == 2)
    }
    
    // MARK: - Operator: -
    
    @Test("minus operator should remove keys")
    func testMinusOperator() {
        let dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        let result = dict - ["key1", "key2"]
        #expect(result.keys.contains("key3"))
        #expect(!result.keys.contains("key1"))
        #expect(!result.keys.contains("key2"))
    }
    
    // MARK: - Operator: -=
    
    @Test("minus equals operator should remove keys in place")
    func testMinusEqualsOperator() {
        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        dict -= ["key1", "key2"]
        #expect(dict.keys.contains("key3"))
        #expect(!dict.keys.contains("key1"))
        #expect(!dict.keys.contains("key2"))
    }
}
