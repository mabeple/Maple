//
//  MapleTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Testing
import Foundation
@testable import Maple

// MARK: - MapleWrapper Tests

@Suite("MapleWrapper Test Suite")
struct MapleWrapperTests {
    
    // MARK: - Test Helpers
    
    /// Test class for MapleCompatible protocol
    final class TestClass: MapleCompatible {
        var value: Int
        
        init(value: Int) {
            self.value = value
        }
    }
    
    /// Test struct for MapleCompatibleValue protocol
    struct TestStruct: MapleCompatibleValue {
        var name: String
        var count: Int
    }
    
    @Test("MapleWrapper should initialize correctly")
    func testMapleWrapperInitialization() {
        let value = 42
        let wrapper = MapleWrapper(value)
        
        #expect(wrapper.base == value)
    }
    
    @Test("MapleWrapper should store reference types")
    func testMapleWrapperWithReferenceType() {
        let testObject = TestClass(value: 100)
        let wrapper = MapleWrapper(testObject)
        
        #expect(wrapper.base === testObject)
        #expect(wrapper.base.value == 100)
    }
    
    @Test("MapleWrapper should store value types")
    func testMapleWrapperWithValueType() {
        let testStruct = TestStruct(name: "Test", count: 5)
        let wrapper = MapleWrapper(testStruct)
        
        #expect(wrapper.base.name == "Test")
        #expect(wrapper.base.count == 5)
    }
    
    @Test("MapleWrapper should support String type")
    func testMapleWrapperWithString() {
        let value = "Hello"
        let wrapper = MapleWrapper(value)
        #expect(wrapper.base == "Hello")
    }
    
    @Test("MapleWrapper should support Int type")
    func testMapleWrapperWithInt() {
        let value = 42
        let wrapper = MapleWrapper(value)
        #expect(wrapper.base == 42)
    }
    
    @Test("MapleWrapper should support Double type")
    func testMapleWrapperWithDouble() {
        let value = 3.14
        let wrapper = MapleWrapper(value)
        #expect(wrapper.base == 3.14)
    }
    
    @Test("MapleWrapper should support Bool type")
    func testMapleWrapperWithBool() {
        let value = true
        let wrapper = MapleWrapper(value)
        #expect(wrapper.base == true)
    }
}

// MARK: - MapleCompatible Tests

@Suite("MapleCompatible Test Suite")
struct MapleCompatibleTests {
    
    @Test("mp getter should create and return MapleWrapper")
    func testMapleCompatibleGetter() {
        let testObject = MapleWrapperTests.TestClass(value: 50)
        
        // Explicitly test the getter by accessing the property
        let mpWrapper = testObject.mp
        
        // Verify getter created a wrapper with the correct base
        #expect(mpWrapper.base === testObject)
        #expect(mpWrapper.base.value == 50)
        
        // Verify wrapper is correctly typed
        #expect(type(of: mpWrapper) == MapleWrapper<MapleWrapperTests.TestClass>.self)
    }
    
    @Test("mp getter should be called when accessing property")
    func testMapleCompatibleGetterIsCalled() {
        let testObject = MapleWrapperTests.TestClass(value: 100)
        
        // Access the property multiple times to ensure getter is invoked
        let result1 = testObject.mp
        let result2 = testObject.mp
        
        // Each getter call should create a new wrapper
        #expect(result1.base === testObject)
        #expect(result2.base === testObject)
        #expect(result1.base === result2.base)
    }
    
    @Test("mp getter should be callable multiple times")
    func testMapleCompatibleGetterMultipleCalls() {
        let testObject = MapleWrapperTests.TestClass(value: 100)
        
        // Call getter multiple times
        let wrapper1 = testObject.mp
        let wrapper2 = testObject.mp
        let wrapper3 = testObject.mp
        
        // Each call should return a new wrapper wrapping the same object
        #expect(wrapper1.base === testObject)
        #expect(wrapper2.base === testObject)
        #expect(wrapper3.base === testObject)
        #expect(wrapper1.base === wrapper2.base)
        #expect(wrapper2.base === wrapper3.base)
    }
    
    @Test("mp getter should execute for different class instances")
    func testMapleCompatibleGetterWithDifferentInstances() {
        let obj1 = MapleWrapperTests.TestClass(value: 10)
        let obj2 = MapleWrapperTests.TestClass(value: 20)
        let obj3 = MapleWrapperTests.TestClass(value: 30)
        
        // Call getter on each instance
        let wrapper1 = obj1.mp
        let wrapper2 = obj2.mp
        let wrapper3 = obj3.mp
        
        // Each getter should return wrapper for its own instance
        #expect(wrapper1.base === obj1)
        #expect(wrapper2.base === obj2)
        #expect(wrapper3.base === obj3)
        #expect(wrapper1.base.value == 10)
        #expect(wrapper2.base.value == 20)
        #expect(wrapper3.base.value == 30)
    }
    
    @Test("mp property should return new wrapper instance each time")
    func testMapleCompatibleCreatesNewWrapper() {
        let testObject = MapleWrapperTests.TestClass(value: 25)
        let wrapper1 = testObject.mp
        let wrapper2 = testObject.mp
        
        // Although wrappers are different, they should reference the same base object
        #expect(wrapper1.base === wrapper2.base)
        #expect(wrapper1.base === testObject)
    }
    
    @Test("Multiple objects should have their own mp wrappers")
    func testMultipleObjectsHaveOwnWrappers() {
        let object1 = MapleWrapperTests.TestClass(value: 10)
        let object2 = MapleWrapperTests.TestClass(value: 20)
        
        #expect(object1.mp.base === object1)
        #expect(object2.mp.base === object2)
        #expect(object1.mp.base !== object2.mp.base)
    }
    
    @Test("mp property setter should have no side effects")
    func testMapleCompatibleSetterDoesNothing() {
        let testObject = MapleWrapperTests.TestClass(value: 30)
        
        // Setter should not change anything
        testObject.mp = MapleWrapper(MapleWrapperTests.TestClass(value: 999))
        
        #expect(testObject.mp.base === testObject)
        #expect(testObject.value == 30)
    }
    
    @Test("mp getter should work in conditional expressions")
    func testMapleCompatibleGetterInConditional() {
        let testObject = MapleWrapperTests.TestClass(value: 42)
        
        // Use getter in conditional
        let isCorrectBase = testObject.mp.base === testObject
        #expect(isCorrectBase)
        
        // Use getter in value comparison
        let wrapper = testObject.mp
        #expect(wrapper.base.value == 42)
    }
    
    @Test("mp getter should work with optional chaining")
    func testMapleCompatibleGetterWithOptional() {
        let testObject: MapleWrapperTests.TestClass? = MapleWrapperTests.TestClass(value: 100)
        
        // Access getter through optional
        let wrapper = testObject?.mp
        
        #expect(wrapper != nil)
        #expect(wrapper?.base === testObject)
        #expect(wrapper?.base.value == 100)
    }
}

// MARK: - MapleCompatibleValue Tests

@Suite("MapleCompatibleValue Test Suite")
struct MapleCompatibleValueTests {
    
    @Test("mp getter should create and return MapleWrapper for value types")
    func testMapleCompatibleValueGetter() {
        let testStruct = MapleWrapperTests.TestStruct(name: "Hello", count: 3)
        
        // Explicitly test the getter by accessing the property
        let mpWrapper = testStruct.mp
        
        // Verify getter created a wrapper with the correct base
        #expect(mpWrapper.base.name == "Hello")
        #expect(mpWrapper.base.count == 3)
        
        // Verify wrapper is correctly typed
        #expect(type(of: mpWrapper) == MapleWrapper<MapleWrapperTests.TestStruct>.self)
    }
    
    @Test("mp getter should be called when accessing value type property")
    func testMapleCompatibleValueGetterIsCalled() {
        let testStruct = MapleWrapperTests.TestStruct(name: "Test", count: 5)
        
        // Access the property to ensure getter is invoked
        let result = testStruct.mp
        
        // Verify getter returned correct wrapper
        #expect(result.base.name == "Test")
        #expect(result.base.count == 5)
    }
    
    @Test("mp getter should return a copy of the value each time")
    func testMapleCompatibleValueGetterReturnsCopy() {
        var testStruct = MapleWrapperTests.TestStruct(name: "Original", count: 10)
        
        // Get wrapper first time
        let wrapper1 = testStruct.mp
        #expect(wrapper1.base.name == "Original")
        #expect(wrapper1.base.count == 10)
        
        // Modify original struct
        testStruct.name = "Modified"
        testStruct.count = 20
        
        // Get wrapper again, should have new values
        let wrapper2 = testStruct.mp
        #expect(wrapper2.base.name == "Modified")
        #expect(wrapper2.base.count == 20)
        
        // wrapper1 should still have original values
        #expect(wrapper1.base.name == "Original")
        #expect(wrapper1.base.count == 10)
    }
    
    @Test("mp getter should execute for different value type instances")
    func testMapleCompatibleValueGetterWithDifferentInstances() {
        let struct1 = MapleWrapperTests.TestStruct(name: "A", count: 1)
        let struct2 = MapleWrapperTests.TestStruct(name: "B", count: 2)
        let struct3 = MapleWrapperTests.TestStruct(name: "C", count: 3)
        
        // Call getter on each instance
        let wrapper1 = struct1.mp
        let wrapper2 = struct2.mp
        let wrapper3 = struct3.mp
        
        // Each getter should return wrapper for its own instance values
        #expect(wrapper1.base.name == "A")
        #expect(wrapper1.base.count == 1)
        #expect(wrapper2.base.name == "B")
        #expect(wrapper2.base.count == 2)
        #expect(wrapper3.base.name == "C")
        #expect(wrapper3.base.count == 3)
    }
    
    @Test("mp property for value types should contain a copy")
    func testMapleCompatibleValueCopiesValue() {
        var testStruct = MapleWrapperTests.TestStruct(name: "Original", count: 1)
        let wrapper = testStruct.mp
        
        // Modify original struct
        testStruct.name = "Modified"
        testStruct.count = 2
        
        // Wrapper should contain a copy of original values
        #expect(wrapper.base.name == "Original")
        #expect(wrapper.base.count == 1)
    }
    
    @Test("mp property should work with various value types", arguments: [
        MapleWrapperTests.TestStruct(name: "A", count: 1),
        MapleWrapperTests.TestStruct(name: "B", count: 2),
        MapleWrapperTests.TestStruct(name: "C", count: 3)
    ])
    func testMapleCompatibleValueWithDifferentValues(testStruct: MapleWrapperTests.TestStruct) {
        let wrapper = testStruct.mp
        #expect(wrapper.base.name == testStruct.name)
        #expect(wrapper.base.count == testStruct.count)
    }
    
    @Test("mp setter for value types should have no side effects")
    func testMapleCompatibleValueSetterDoesNothing() {
        var testStruct = MapleWrapperTests.TestStruct(name: "Test", count: 5)
        
        // Setter should not change anything
        testStruct.mp = MapleWrapper(MapleWrapperTests.TestStruct(name: "Ignored", count: 999))
        
        #expect(testStruct.name == "Test")
        #expect(testStruct.count == 5)
    }
    
    @Test("mp getter should work in conditional expressions for value types")
    func testMapleCompatibleValueGetterInConditional() {
        let testStruct = MapleWrapperTests.TestStruct(name: "Hello", count: 10)
        
        // Use getter in conditional
        let hasCorrectName = testStruct.mp.base.name == "Hello"
        #expect(hasCorrectName)
        
        // Use getter in value comparison
        let wrapper = testStruct.mp
        #expect(wrapper.base.count == 10)
    }
    
    @Test("mp getter should work with let and var declarations")
    func testMapleCompatibleValueGetterWithVariables() {
        let constantStruct = MapleWrapperTests.TestStruct(name: "Const", count: 1)
        var variableStruct = MapleWrapperTests.TestStruct(name: "Var", count: 2)
        
        // Access getter on constant
        let wrapper1 = constantStruct.mp
        #expect(wrapper1.base.name == "Const")
        #expect(wrapper1.base.count == 1)
        
        // Access getter on variable before modification
        let wrapper2 = variableStruct.mp
        #expect(wrapper2.base.name == "Var")
        #expect(wrapper2.base.count == 2)
        
        // Modify variable
        variableStruct.count = 20
        
        // Access getter on variable after modification
        let wrapper3 = variableStruct.mp
        #expect(wrapper3.base.count == 20)
    }
}

// MARK: - Integration Tests

@Suite("Integration Test Suite")
struct IntegrationTests {
    
    @Test("Extensions should be able to use MapleWrapper")
    func testExtensionWithMapleWrapper() {
        let testObject = MapleWrapperTests.TestClass(value: 100)
        let doubled = testObject.mp.doubled()
        
        #expect(doubled == 200)
    }
    
    @Test("Extension methods should support chaining")
    func testChainedExtensions() {
        let testObject = MapleWrapperTests.TestClass(value: 10)
        let result = testObject.mp.doubled()
        
        #expect(result == 20)
        #expect(testObject.value == 10) // Original object should not be modified
    }
}

// MARK: - Extension for Testing

extension MapleWrapper where Base: MapleWrapperTests.TestClass {
    func doubled() -> Int {
        return base.value * 2
    }
}
