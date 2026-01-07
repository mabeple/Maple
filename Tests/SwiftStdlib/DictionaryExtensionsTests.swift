//
//  DictionaryExtensionsTests.swift
//  Maple
//
//  Created by cy on 2023/2/22.
//  Copyright © 2023 cy. All rights reserved.
//

@testable import Maple
import XCTest

final class DictionaryExtensionsTests: XCTestCase {
    var testDict: [String: Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]

    func testHasKey() {
        XCTAssert(testDict.mp.has(key: "testKey"))
        XCTAssertFalse(testDict.mp.has(key: "anotherKey"))
    }

    func testRemoveAll() {
        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        dict.removeAll(keys: ["key1", "key2"])
        XCTAssert(dict.keys.contains("key3"))
        XCTAssertFalse(dict.keys.contains("key1"))
        XCTAssertFalse(dict.keys.contains("key2"))
    }

    func testRemoveElementForRandomKey() {
        var emptyDict = [String: String]()
        XCTAssertNil(emptyDict.removeValueForRandomKey())

        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        let elements = dict.count
        let removedElement = dict.removeValueForRandomKey()
        XCTAssertEqual(elements - 1, dict.count)
        XCTAssertFalse(dict.contains(where: { $0.value == removedElement }))
    }

    func testJsonData() {
        let dict = ["key": "value"]

        let jsonString = "{\"key\":\"value\"}"
        let jsonData = jsonString.data(using: .utf8)

        let prettyJsonString = "{\n  \"key\" : \"value\"\n}"
        let prettyJsonData = prettyJsonString.data(using: .utf8)

        XCTAssertEqual(dict.mp.jsonData(), jsonData)
        XCTAssertEqual(dict.mp.jsonData(prettify: true), prettyJsonData)

        XCTAssertNil(["key": NSObject()].mp.jsonData())
        XCTAssertNil([1: 2].mp.jsonData())
    }

    func testJsonString() {
        XCTAssertNotNil(testDict.mp.jsonString())
        XCTAssertEqual(testDict.mp.jsonString()?.contains("\"testArrayKey\":[1,2,3,4,5]"), true)
        XCTAssertEqual(testDict.mp.jsonString()?.contains("\"testKey\":\"testValue\""), true)

        XCTAssertEqual(
            testDict.mp.jsonString(prettify: true)?.contains("[\n    1,\n    2,\n    3,\n    4,\n    5\n  ]"),
            true)

        XCTAssertNil(["key": NSObject()].mp.jsonString())
        XCTAssertNil([1: 2].mp.jsonString())
    }

    func testKeysForValue() {
        let dict = ["key1": "value1", "key2": "value1", "key3": "value2"]
        let result = dict.mp.keys(forValue: "value1")
        XCTAssert(result.contains("key1"))
        XCTAssert(result.contains("key2"))
        XCTAssertFalse(result.contains("key3"))
    }

    func testLowercaseAllKeys() {
        let dict = ["tEstKeY": "value"]
        let new = dict.mp.lowercaseAllKeys()
        XCTAssertEqual(new, ["testkey": "value"])
    }

    func testSubscriptKeypath() {
        var json = ["key": ["key1": ["key2": "value"]]]

        XCTAssertNil(json[path: []] as? String)
        XCTAssertEqual(json[path: ["key", "key1"]] as? [String: String], ["key2": "value"])
        XCTAssertEqual(json[path: ["key", "key1", "key2"]] as? String, "value")
        json[path: ["key", "key1", "key2"]] = "newValue"
        XCTAssertEqual(json[path: ["key", "key1", "key2"]] as? String, "newValue")
    }

    func testOperatorPlus() {
        let dict = ["key1": "value1"]
        let dict2 = ["key2": "value2"]
        let result = dict + dict2
        XCTAssert(result.keys.contains("key1"))
        XCTAssert(result.keys.contains("key2"))
    }

    func testOperatorMinus() {
        let dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        let result = dict - ["key1", "key2"]
        XCTAssert(result.keys.contains("key3"))
        XCTAssertFalse(result.keys.contains("key1"))
        XCTAssertFalse(result.keys.contains("key2"))
    }

    func testOperatorPlusEqual() {
        var dict = ["key1": "value1"]
        let dict2 = ["key2": "value2"]
        dict += dict2
        XCTAssert(dict.keys.contains("key1"))
        XCTAssert(dict.keys.contains("key2"))
    }

    func testOperatorRemoveKeys() {
        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        dict -= ["key1", "key2"]
        XCTAssert(dict.keys.contains("key3"))
        XCTAssertFalse(dict.keys.contains("key1"))
        XCTAssertFalse(dict.keys.contains("key2"))
    }

    func testMapKeysAndValues() {
        let intToString = [0: "0", 1: "1", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9"]

        let stringToInt: [String: Int] = intToString.mp.mapKeysAndValues { key, value in
            return (String(describing: key), Int(value)!)
        }

        XCTAssertEqual(stringToInt, ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9])
    }

    func testCompactMapKeysAndValues() {
        enum IntWord: String {
            case zero
            case one
            case two
        }

        let strings = [
            0: "zero",
            1: "one",
            2: "two",
            3: "three"
        ]
        let words: [String: IntWord] = strings.mp.compactMapKeysAndValues { key, value in
            guard let word = IntWord(rawValue: value) else { return nil }
            return (String(describing: key), word)
        }

        XCTAssertEqual(words, ["0": .zero, "1": .one, "2": .two])
    }

    func testInitGroupedByKeyPath() {
        let array1 = ["James", "Wade", "Bryant", "John"]
        let array2 = ["James", "Wade", "Bryant", "John", "", ""]
        let array3: [String] = []

        XCTAssertEqual(
            Dictionary(grouping: array1, by: \String.count),
            [6: ["Bryant"], 5: ["James"], 4: ["Wade", "John"]])
        XCTAssertEqual(
            Dictionary(grouping: array1, by: \String.first),
            [Optional("B"): ["Bryant"], Optional("J"): ["James", "John"], Optional("W"): ["Wade"]])
        XCTAssertEqual(
            Dictionary(grouping: array2, by: \String.count),
            [6: ["Bryant"], 5: ["James"], 4: ["Wade", "John"], 0: ["", ""]])
        XCTAssertEqual(Dictionary(grouping: array3, by: \String.count), [:])
    }

    func testGetByKeys() {
        let dict = ["James": 100,
                    "Wade": 200,
                    "Bryant": 500,
                    "John": 600,
                    "Jack": 1000]
        let picked = dict.mp.pick(keys: ["James", "Wade", "Jack"])
        let empty1 = dict.mp.pick(keys: ["Pippen", "Rodman"])
        XCTAssertEqual(picked, ["James": 100, "Wade": 200, "Jack": 1000])
        XCTAssertTrue(empty1.isEmpty)

        let optionalValuesDict = ["James": 100,
                                  "Wade": nil,
                                  "Bryant": 500,
                                  "John": nil,
                                  "Jack": 1000]

        let pickedWithOptionals = optionalValuesDict.mp.pick(keys: ["James", "Bryant", "John"])
        XCTAssertEqual(pickedWithOptionals, ["James": Optional(100), "Bryant": Optional(500), "John": nil])

        let emptyDict = [String: Int]()
        let empty3 = emptyDict.mp.pick(keys: ["James", "Bryant", "John"])
        XCTAssertTrue(empty3.isEmpty)
    }
    
}
