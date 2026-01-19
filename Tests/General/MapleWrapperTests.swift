//
//  MapleWrapper.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Testing
import Foundation
@testable import Maple

// MARK: - MapleWrapper Test Suite

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
    
    // MARK: - MapleWrapper Initialization Tests
    
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
    
    // MARK: - MapleWrapper Type Support Tests
    
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
    
    // MARK: - MapleCompatible Getter Tests
    
    @Test("mp getter should create and return MapleWrapper")
    func testMapleCompatibleGetter() {
        let testObject = TestClass(value: 50)
        
        let mpWrapper = testObject.mp
        
        #expect(mpWrapper.base === testObject)
        #expect(mpWrapper.base.value == 50)
        #expect(type(of: mpWrapper) == MapleWrapper<TestClass>.self)
    }
    
    @Test("mp getter should be called when accessing property")
    func testMapleCompatibleGetterIsCalled() {
        let testObject = TestClass(value: 100)
        
        let result1 = testObject.mp
        let result2 = testObject.mp
        
        #expect(result1.base === testObject)
        #expect(result2.base === testObject)
        #expect(result1.base === result2.base)
    }
    
    @Test("mp getter should be callable multiple times")
    func testMapleCompatibleGetterMultipleCalls() {
        let testObject = TestClass(value: 100)
        
        let wrapper1 = testObject.mp
        let wrapper2 = testObject.mp
        let wrapper3 = testObject.mp
        
        #expect(wrapper1.base === testObject)
        #expect(wrapper2.base === testObject)
        #expect(wrapper3.base === testObject)
        #expect(wrapper1.base === wrapper2.base)
        #expect(wrapper2.base === wrapper3.base)
    }
    
    @Test("mp getter should execute for different class instances")
    func testMapleCompatibleGetterWithDifferentInstances() {
        let obj1 = TestClass(value: 10)
        let obj2 = TestClass(value: 20)
        let obj3 = TestClass(value: 30)
        
        let wrapper1 = obj1.mp
        let wrapper2 = obj2.mp
        let wrapper3 = obj3.mp
        
        #expect(wrapper1.base === obj1)
        #expect(wrapper2.base === obj2)
        #expect(wrapper3.base === obj3)
        #expect(wrapper1.base.value == 10)
        #expect(wrapper2.base.value == 20)
        #expect(wrapper3.base.value == 30)
    }
    
    @Test("mp property should return new wrapper instance each time")
    func testMapleCompatibleCreatesNewWrapper() {
        let testObject = TestClass(value: 25)
        let wrapper1 = testObject.mp
        let wrapper2 = testObject.mp
        
        #expect(wrapper1.base === wrapper2.base)
        #expect(wrapper1.base === testObject)
    }
    
    @Test("Multiple objects should have their own mp wrappers")
    func testMultipleObjectsHaveOwnWrappers() {
        let object1 = TestClass(value: 10)
        let object2 = TestClass(value: 20)
        
        #expect(object1.mp.base === object1)
        #expect(object2.mp.base === object2)
        #expect(object1.mp.base !== object2.mp.base)
    }
    
    // MARK: - MapleCompatible Setter Tests
    
    @Test("mp property setter should have no side effects")
    func testMapleCompatibleSetterDoesNothing() {
        let testObject = TestClass(value: 30)
        
        testObject.mp = MapleWrapper(TestClass(value: 999))
        
        #expect(testObject.mp.base === testObject)
        #expect(testObject.value == 30)
    }
    
    // MARK: - MapleCompatible Edge Case Tests
    
    @Test("mp getter should work in conditional expressions")
    func testMapleCompatibleGetterInConditional() {
        let testObject = TestClass(value: 42)
        
        let isCorrectBase = testObject.mp.base === testObject
        #expect(isCorrectBase)
        
        let wrapper = testObject.mp
        #expect(wrapper.base.value == 42)
    }
    
    @Test("mp getter should work with optional chaining")
    func testMapleCompatibleGetterWithOptional() {
        let testObject: TestClass? = TestClass(value: 100)
        
        let wrapper = testObject?.mp
        
        #expect(wrapper != nil)
        #expect(wrapper?.base === testObject)
        #expect(wrapper?.base.value == 100)
    }
    
    // MARK: - MapleCompatibleValue Getter Tests
    
    @Test("mp getter should create and return MapleWrapper for value types")
    func testMapleCompatibleValueGetter() {
        let testStruct = TestStruct(name: "Hello", count: 3)
        
        let mpWrapper = testStruct.mp
        
        #expect(mpWrapper.base.name == "Hello")
        #expect(mpWrapper.base.count == 3)
        #expect(type(of: mpWrapper) == MapleWrapper<TestStruct>.self)
    }
    
    @Test("mp getter should be called when accessing value type property")
    func testMapleCompatibleValueGetterIsCalled() {
        let testStruct = TestStruct(name: "Test", count: 5)
        
        let result = testStruct.mp
        
        #expect(result.base.name == "Test")
        #expect(result.base.count == 5)
    }
    
    @Test("mp getter should return a copy of the value each time")
    func testMapleCompatibleValueGetterReturnsCopy() {
        var testStruct = TestStruct(name: "Original", count: 10)
        
        let wrapper1 = testStruct.mp
        #expect(wrapper1.base.name == "Original")
        #expect(wrapper1.base.count == 10)
        
        testStruct.name = "Modified"
        testStruct.count = 20
        
        let wrapper2 = testStruct.mp
        #expect(wrapper2.base.name == "Modified")
        #expect(wrapper2.base.count == 20)
        
        #expect(wrapper1.base.name == "Original")
        #expect(wrapper1.base.count == 10)
    }
    
    @Test("mp getter should execute for different value type instances")
    func testMapleCompatibleValueGetterWithDifferentInstances() {
        let struct1 = TestStruct(name: "A", count: 1)
        let struct2 = TestStruct(name: "B", count: 2)
        let struct3 = TestStruct(name: "C", count: 3)
        
        let wrapper1 = struct1.mp
        let wrapper2 = struct2.mp
        let wrapper3 = struct3.mp
        
        #expect(wrapper1.base.name == "A")
        #expect(wrapper1.base.count == 1)
        #expect(wrapper2.base.name == "B")
        #expect(wrapper2.base.count == 2)
        #expect(wrapper3.base.name == "C")
        #expect(wrapper3.base.count == 3)
    }
    
    @Test("mp property for value types should contain a copy")
    func testMapleCompatibleValueCopiesValue() {
        var testStruct = TestStruct(name: "Original", count: 1)
        let wrapper = testStruct.mp
        
        testStruct.name = "Modified"
        testStruct.count = 2
        
        #expect(wrapper.base.name == "Original")
        #expect(wrapper.base.count == 1)
    }
    
    @Test("mp property should work with various value types", arguments: [
        TestStruct(name: "A", count: 1),
        TestStruct(name: "B", count: 2),
        TestStruct(name: "C", count: 3)
    ])
    func testMapleCompatibleValueWithDifferentValues(testStruct: TestStruct) {
        let wrapper = testStruct.mp
        #expect(wrapper.base.name == testStruct.name)
        #expect(wrapper.base.count == testStruct.count)
    }
    
    // MARK: - MapleCompatibleValue Setter Tests
    
    @Test("mp setter for value types should have no side effects")
    func testMapleCompatibleValueSetterDoesNothing() {
        var testStruct = TestStruct(name: "Test", count: 5)
        
        testStruct.mp = MapleWrapper(TestStruct(name: "Ignored", count: 999))
        
        #expect(testStruct.name == "Test")
        #expect(testStruct.count == 5)
    }
    
    // MARK: - MapleCompatibleValue Edge Case Tests
    
    @Test("mp getter should work in conditional expressions for value types")
    func testMapleCompatibleValueGetterInConditional() {
        let testStruct = TestStruct(name: "Hello", count: 10)
        
        let hasCorrectName = testStruct.mp.base.name == "Hello"
        #expect(hasCorrectName)
        
        let wrapper = testStruct.mp
        #expect(wrapper.base.count == 10)
    }
    
    @Test("mp getter should work with let and var declarations")
    func testMapleCompatibleValueGetterWithVariables() {
        let constantStruct = TestStruct(name: "Const", count: 1)
        var variableStruct = TestStruct(name: "Var", count: 2)
        
        let wrapper1 = constantStruct.mp
        #expect(wrapper1.base.name == "Const")
        #expect(wrapper1.base.count == 1)
        
        let wrapper2 = variableStruct.mp
        #expect(wrapper2.base.name == "Var")
        #expect(wrapper2.base.count == 2)
        
        variableStruct.count = 20
        
        let wrapper3 = variableStruct.mp
        #expect(wrapper3.base.count == 20)
    }
}
