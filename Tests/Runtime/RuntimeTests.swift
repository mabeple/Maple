//
//  RuntimeTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Runtime Test Suite")
struct RuntimeTests {
    
    // MARK: - Test Helpers
    
    /// Test class for associated objects
    final class TestObject: NSObject {
        var value: Int = 0
    }
    
    /// Test class for method swizzling
    final class SwizzleTestClass: NSObject {
        @objc dynamic func originalMethod() -> String {
            return "original"
        }
        
        @objc dynamic func swizzledMethod() -> String {
            return "swizzled"
        }
    }
    
    /// Test class for method swizzling (separate class for different tests)
    final class SwizzleTestClass2: NSObject {
        @objc dynamic func originalMethod() -> String {
            return "original"
        }
        
        @objc dynamic func swizzledMethod() -> String {
            return "swizzled"
        }
    }
    
    // MARK: - AssociationPolicy Tests
    
    @Test("AssociationPolicy retain should map to OBJC_ASSOCIATION_RETAIN_NONATOMIC")
    func testAssociationPolicyRetain() {
        let policy = AssociationPolicy.retain
        #expect(policy.objc == .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @Test("AssociationPolicy copy should map to OBJC_ASSOCIATION_COPY_NONATOMIC")
    func testAssociationPolicyCopy() {
        let policy = AssociationPolicy.copy
        #expect(policy.objc == .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    @Test("AssociationPolicy assign should map to OBJC_ASSOCIATION_ASSIGN")
    func testAssociationPolicyAssign() {
        let policy = AssociationPolicy.assign
        #expect(policy.objc == .OBJC_ASSOCIATION_ASSIGN)
    }
    
    // MARK: - Associated Objects Tests
    
    @Test("setAssociatedObject and getAssociatedObject should work with retain policy")
    func testAssociatedObjectRetain() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 1)!
        let value = "test value"
        
        setAssociatedObject(object, key, value, policy: .retain)
        let retrieved: String? = getAssociatedObject(object, key)
        
        #expect(retrieved == value)
    }
    
    @Test("setAssociatedObject and getAssociatedObject should work with copy policy")
    func testAssociatedObjectCopy() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 2)!
        let originalValue = "mutable"
        let value = NSMutableString(string: originalValue)
        
        setAssociatedObject(object, key, value, policy: .copy)
        let retrieved: NSString? = getAssociatedObject(object, key)
        
        #expect(retrieved != nil)
        // Verify content matches
        #expect(retrieved?.isEqual(to: originalValue) == true)
        
        // Verify it's actually a copy by modifying the original
        // The retrieved value should not be affected
        value.append(" modified")
        #expect(retrieved?.isEqual(to: originalValue) == true) // Copy should not be affected
        #expect(value.isEqual(to: "mutable modified") == true) // Original should be modified
    }
    
    @Test("setAssociatedObject and getAssociatedObject should work with assign policy")
    func testAssociatedObjectAssign() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 3)!
        let value = 42
        
        setAssociatedObject(object, key, value, policy: .assign)
        let retrieved: Int? = getAssociatedObject(object, key)
        
        #expect(retrieved == value)
    }
    
    @Test("getAssociatedObject should return nil for non-existent key")
    func testGetAssociatedObjectNonExistent() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 4)!
        
        // Test with String type
        let retrievedString: String? = getAssociatedObject(object, key)
        #expect(retrievedString == nil)
        
        // Test with Int type
        let retrievedInt: Int? = getAssociatedObject(object, key)
        #expect(retrievedInt == nil)
        
        // Test with different key (also non-existent)
        let key2 = UnsafeRawPointer(bitPattern: 999)!
        let retrieved2: String? = getAssociatedObject(object, key2)
        #expect(retrieved2 == nil)
    }
    
    @Test("getAssociatedObject should handle type casting correctly")
    func testGetAssociatedObjectTypeCasting() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 11)!
        
        // Set a value
        let originalValue = "test string"
        setAssociatedObject(object, key, originalValue, policy: .retain)
        
        // Test retrieving as String
        let asString: String? = getAssociatedObject(object, key)
        #expect(asString == originalValue)
        
        // Test retrieving as NSString (should work due to bridging)
        let asNSString: NSString? = getAssociatedObject(object, key)
        #expect(asNSString?.isEqual(to: originalValue) == true)
        
        // Test retrieving as AnyObject
        let asAnyObject: AnyObject? = getAssociatedObject(object, key)
        #expect(asAnyObject != nil)
        
        // Test retrieving as wrong type (should return nil)
        let asInt: Int? = getAssociatedObject(object, key)
        #expect(asInt == nil)
        
        // Test retrieving as Array (wrong type, should return nil)
        let asArray: [String]? = getAssociatedObject(object, key)
        #expect(asArray == nil)
        
        // Test retrieving as Dictionary (wrong type, should return nil)
        let asDict: [String: String]? = getAssociatedObject(object, key)
        #expect(asDict == nil)
    }
    
    @Test("getAssociatedObject should handle different value types")
    func testGetAssociatedObjectDifferentValueTypes() {
        let object = TestObject()
        let key1 = UnsafeRawPointer(bitPattern: 12)!
        let key2 = UnsafeRawPointer(bitPattern: 13)!
        let key3 = UnsafeRawPointer(bitPattern: 14)!
        let key4 = UnsafeRawPointer(bitPattern: 15)!
        
        // Test with Int
        let intValue = 42
        setAssociatedObject(object, key1, intValue, policy: .retain)
        let retrievedInt: Int? = getAssociatedObject(object, key1)
        #expect(retrievedInt == intValue)
        
        // Test with Double
        let doubleValue = 3.14
        setAssociatedObject(object, key2, doubleValue, policy: .retain)
        let retrievedDouble: Double? = getAssociatedObject(object, key2)
        #expect(retrievedDouble == doubleValue)
        
        // Test with Bool
        let boolValue = true
        setAssociatedObject(object, key3, boolValue, policy: .retain)
        let retrievedBool: Bool? = getAssociatedObject(object, key3)
        #expect(retrievedBool == boolValue)
        
        // Test with Array
        let arrayValue = [1, 2, 3]
        setAssociatedObject(object, key4, arrayValue, policy: .retain)
        let retrievedArray: [Int]? = getAssociatedObject(object, key4)
        #expect(retrievedArray == arrayValue)
    }
    
    @Test("getAssociatedObject should handle type mismatches")
    func testGetAssociatedObjectTypeMismatches() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 16)!
        
        // Set a String value
        setAssociatedObject(object, key, "test", policy: .retain)
        
        // Try to retrieve as different types (should all return nil)
        let asInt: Int? = getAssociatedObject(object, key)
        #expect(asInt == nil)
        
        let asDouble: Double? = getAssociatedObject(object, key)
        #expect(asDouble == nil)
        
        let asBool: Bool? = getAssociatedObject(object, key)
        #expect(asBool == nil)
        
        let asArray: [String]? = getAssociatedObject(object, key)
        #expect(asArray == nil)
        
        let asDict: [String: Int]? = getAssociatedObject(object, key)
        #expect(asDict == nil)
    }
    
    @Test("getAssociatedObject should handle reference types")
    func testGetAssociatedObjectReferenceTypes() {
        let object = TestObject()
        let key1 = UnsafeRawPointer(bitPattern: 17)!
        let key2 = UnsafeRawPointer(bitPattern: 18)!
        
        // Test with NSNumber
        let number = NSNumber(value: 42)
        setAssociatedObject(object, key1, number, policy: .retain)
        let retrievedNumber: NSNumber? = getAssociatedObject(object, key1)
        #expect(retrievedNumber?.intValue == 42)
        
        // Test with NSArray
        let array = NSArray(array: [1, 2, 3])
        setAssociatedObject(object, key2, array, policy: .retain)
        let retrievedArray: NSArray? = getAssociatedObject(object, key2)
        #expect(retrievedArray?.count == 3)
    }
    
    @Test("getAssociatedObject should handle optional types")
    func testGetAssociatedObjectOptionalTypes() {
        let object = TestObject()
        let key1 = UnsafeRawPointer(bitPattern: 19)!
        let key2 = UnsafeRawPointer(bitPattern: 20)!
        
        // Test with optional String (wrapped)
        let optionalString: String? = "optional value"
        setAssociatedObject(object, key1, optionalString as Any, policy: .retain)
        let retrieved: String?? = getAssociatedObject(object, key1)
        #expect(retrieved != nil)
        
        // Test with nil optional (wrapped as NSNull)
        setAssociatedObject(object, key2, NSNull(), policy: .retain)
        let retrievedNull: AnyObject? = getAssociatedObject(object, key2)
        #expect(retrievedNull is NSNull)
    }
    
    @Test("getAssociatedObject should handle all conversion paths")
    func testGetAssociatedObjectAllConversionPaths() {
        let object = TestObject()
        
        // Test 1: String -> String (successful conversion)
        let key1 = UnsafeRawPointer(bitPattern: 21)!
        setAssociatedObject(object, key1, "test", policy: .retain)
        let str1: String? = getAssociatedObject(object, key1)
        #expect(str1 == "test")
        
        // Test 2: String -> NSString (bridging conversion)
        let str2: NSString? = getAssociatedObject(object, key1)
        #expect(str2?.isEqual(to: "test") == true)
        
        // Test 3: String -> AnyObject (upcast)
        let str3: AnyObject? = getAssociatedObject(object, key1)
        #expect(str3 != nil)
        
        // Test 4: String -> Int (failed conversion, should return nil)
        let str4: Int? = getAssociatedObject(object, key1)
        #expect(str4 == nil)
        
        // Test 5: Int -> Int (successful conversion)
        let key2 = UnsafeRawPointer(bitPattern: 22)!
        setAssociatedObject(object, key2, 100, policy: .retain)
        let int1: Int? = getAssociatedObject(object, key2)
        #expect(int1 == 100)
        
        // Test 6: Int -> String (failed conversion, should return nil)
        let int2: String? = getAssociatedObject(object, key2)
        #expect(int2 == nil)
        
        // Test 7: Array -> Array (successful conversion)
        let key3 = UnsafeRawPointer(bitPattern: 23)!
        let arrayValue = [1, 2, 3]
        setAssociatedObject(object, key3, arrayValue, policy: .retain)
        let arr1: [Int]? = getAssociatedObject(object, key3)
        #expect(arr1 == arrayValue)
        
        // Test 8: Array -> String (failed conversion, should return nil)
        let arr2: String? = getAssociatedObject(object, key3)
        #expect(arr2 == nil)
        
        // Test 9: Dictionary -> Dictionary (successful conversion)
        let key4 = UnsafeRawPointer(bitPattern: 24)!
        let dictValue = ["key": "value"]
        setAssociatedObject(object, key4, dictValue, policy: .retain)
        let dict1: [String: String]? = getAssociatedObject(object, key4)
        #expect(dict1 == dictValue)
        
        // Test 10: Dictionary -> Array (failed conversion, should return nil)
        let dict2: [String]? = getAssociatedObject(object, key4)
        #expect(dict2 == nil)
        
        // Test 11: NSNumber -> NSNumber (successful conversion)
        let key5 = UnsafeRawPointer(bitPattern: 25)!
        let number = NSNumber(value: 42)
        setAssociatedObject(object, key5, number, policy: .retain)
        let num1: NSNumber? = getAssociatedObject(object, key5)
        #expect(num1?.intValue == 42)
        
        // Test 12: NSNumber -> Int (failed conversion, should return nil)
        let num2: Int? = getAssociatedObject(object, key5)
        #expect(num2 == 42)
        
        // Test 13: nil key (should return nil)
        let key6 = UnsafeRawPointer(bitPattern: 26)!
        let nilValue: String? = getAssociatedObject(object, key6)
        #expect(nilValue == nil)
        
        // Test 14: Different object, same key (should return nil)
        let object2 = TestObject()
        let nilValue2: String? = getAssociatedObject(object2, key1)
        #expect(nilValue2 == nil)
    }
    
    @Test("setAssociatedObject should overwrite existing value")
    func testAssociatedObjectOverwrite() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 5)!
        
        setAssociatedObject(object, key, "first", policy: .retain)
        setAssociatedObject(object, key, "second", policy: .retain)
        
        let retrieved: String? = getAssociatedObject(object, key)
        #expect(retrieved == "second")
    }
    
    @Test("setAssociatedObject should work with different types")
    func testAssociatedObjectDifferentTypes() {
        let object = TestObject()
        let key1 = UnsafeRawPointer(bitPattern: 6)!
        let key2 = UnsafeRawPointer(bitPattern: 7)!
        let key3 = UnsafeRawPointer(bitPattern: 8)!
        
        setAssociatedObject(object, key1, "string", policy: .retain)
        setAssociatedObject(object, key2, 123, policy: .retain)
        setAssociatedObject(object, key3, [1, 2, 3], policy: .retain)
        
        let stringValue: String? = getAssociatedObject(object, key1)
        let intValue: Int? = getAssociatedObject(object, key2)
        let arrayValue: [Int]? = getAssociatedObject(object, key3)
        
        #expect(stringValue == "string")
        #expect(intValue == 123)
        #expect(arrayValue == [1, 2, 3])
    }
    
    @Test("setAssociatedObject should work with value types")
    func testAssociatedObjectValueTypes() {
        struct TestStruct: Equatable {
            let value: Int
        }
        
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 9)!
        let value = TestStruct(value: 42)
        
        setAssociatedObject(object, key, value, policy: .retain)
        let retrieved: TestStruct? = getAssociatedObject(object, key)
        
        #expect(retrieved == value)
    }
    
    @Test("setAssociatedObject should work with default retain policy")
    func testAssociatedObjectDefaultPolicy() {
        let object = TestObject()
        let key = UnsafeRawPointer(bitPattern: 10)!
        let value = "default policy"
        
        setAssociatedObject(object, key, value) // Using default policy
        let retrieved: String? = getAssociatedObject(object, key)
        
        #expect(retrieved == value)
    }
    
    // MARK: - Method Swizzling Tests
    
    @Test("swizzle should exchange method implementations")
    func testMethodSwizzle() {
        // Create a new instance before swizzling to test original behavior
        let instance1 = SwizzleTestClass()
        #expect(instance1.originalMethod() == "original")
        #expect(instance1.swizzledMethod() == "swizzled")
        
        // Perform swizzling on the class
        SwizzleTestClass.swizzle(original: #selector(SwizzleTestClass.originalMethod),
                                 swizzled: #selector(SwizzleTestClass.swizzledMethod))
        
        // Create a new instance after swizzling - it should use swizzled implementations
        let instance2 = SwizzleTestClass()
        // After swizzling, originalMethod now calls the swizzled implementation
        #expect(instance2.originalMethod() == "swizzled")
        // After swizzling, swizzledMethod now calls the original implementation
        #expect(instance2.swizzledMethod() == "original")
        
        // The previously created instance should also be affected
        #expect(instance1.originalMethod() == "swizzled")
        #expect(instance1.swizzledMethod() == "original")
    }
    
    @Test("swizzle should handle non-existent methods gracefully")
    func testSwizzleNonExistentMethod() {
        // Use a different class to avoid interference
        final class EmptyClass: NSObject {}
        
        // Should not crash when methods don't exist
        EmptyClass.swizzle(original: #selector(NSObject.description),
                          swizzled: #selector(NSObject.debugDescription))
    }
    
    @Test("swizzle should work with multiple instances")
    func testSwizzleMultipleInstances() {
        // Use a different class to avoid interference with other swizzling tests
        let instance1 = SwizzleTestClass2()
        let instance2 = SwizzleTestClass2()
        
        // Perform swizzling
        SwizzleTestClass2.swizzle(original: #selector(SwizzleTestClass2.originalMethod),
                                  swizzled: #selector(SwizzleTestClass2.swizzledMethod))
        
        // Both instances should be affected
        #expect(instance1.originalMethod() == "swizzled")
        #expect(instance2.originalMethod() == "swizzled")
        #expect(instance1.swizzledMethod() == "original")
        #expect(instance2.swizzledMethod() == "original")
    }
}
