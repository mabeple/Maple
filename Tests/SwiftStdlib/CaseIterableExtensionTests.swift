//
//  CaseIterableExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("CaseIterable Extensions Test Suite")
struct CaseIterableExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("CaseIterable should have mp property")
    func testCaseIterableHasMPProperty() {
        let direction = Direction.north
        let wrapper = direction.mp
        #expect(wrapper.base == direction)
    }
    
    @Test("CaseIterable mp property setter should be callable")
    func testCaseIterableMPSetter() {
        var direction = Direction.north
        let newWrapper = MapleWrapper(Direction.east)
        
        // Test that setter can be called (even though it does nothing)
        direction.mp = newWrapper
        
        // After setting, the value should remain unchanged (setter is empty)
        #expect(direction == Direction.north)
        #expect(direction.mp.base == Direction.north)
    }
    
    // MARK: - Method: previous
    
    @Test("previous should return previous case")
    func testPrevious() {
        #expect(Direction.north.mp.previous() == Direction.west) // looped by default
        #expect(Direction.east.mp.previous() == Direction.north)
        #expect(Direction.south.mp.previous() == Direction.east)
        #expect(Direction.west.mp.previous() == Direction.south)
        
        // Test without looping
        #expect(Direction.north.mp.previous(looped: false) == Direction.north)
        #expect(Direction.east.mp.previous(looped: false) == Direction.north)
    }
    
    // MARK: - Method: next
    
    @Test("next should return next case")
    func testNext() {
        #expect(Direction.north.mp.next() == Direction.east) // looped by default
        #expect(Direction.east.mp.next() == Direction.south)
        #expect(Direction.south.mp.next() == Direction.west)
        #expect(Direction.west.mp.next() == Direction.north) // loops back
        
        // Test without looping
        #expect(Direction.west.mp.next(looped: false) == Direction.west)
        #expect(Direction.south.mp.next(looped: false) == Direction.west)
    }
    
    // MARK: - Method: isFirst
    
    @Test("isFirst should check if case is first")
    func testIsFirst() {
        #expect(Direction.north.mp.isFirst() == true)
        #expect(Direction.east.mp.isFirst() == false)
        #expect(Direction.south.mp.isFirst() == false)
        #expect(Direction.west.mp.isFirst() == false)
    }
    
    // MARK: - Method: isLast
    
    @Test("isLast should check if case is last")
    func testIsLast() {
        #expect(Direction.north.mp.isLast() == false)
        #expect(Direction.east.mp.isLast() == false)
        #expect(Direction.south.mp.isLast() == false)
        #expect(Direction.west.mp.isLast() == true)
    }
    
    // MARK: - Method: index
    
    @Test("index should return zero-based index")
    func testIndex() {
        #expect(Direction.north.mp.index() == 0)
        #expect(Direction.east.mp.index() == 1)
        #expect(Direction.south.mp.index() == 2)
        #expect(Direction.west.mp.index() == 3)
    }
    
    // MARK: - Property: count
    
    @Test("count should return total number of cases")
    func testCount() {
        #expect(Direction.north.mp.count == 4)
        #expect(Direction.east.mp.count == 4)
        #expect(Direction.south.mp.count == 4)
        #expect(Direction.west.mp.count == 4)
    }
    
    // MARK: - Method: offset
    
    @Test("offset should return case at offset position")
    func testOffset() {
        // Test with looping
        #expect(Direction.north.mp.offset(by: 1, looped: true) == Direction.east)
        #expect(Direction.north.mp.offset(by: 4, looped: true) == Direction.north)
        #expect(Direction.north.mp.offset(by: -1, looped: true) == Direction.west)
        #expect(Direction.north.mp.offset(by: -4, looped: true) == Direction.north)
        
        // Test without looping
        #expect(Direction.north.mp.offset(by: 1, looped: false) == Direction.east)
        #expect(Direction.north.mp.offset(by: 4, looped: false) == nil)
        #expect(Direction.north.mp.offset(by: -1, looped: false) == nil)
        #expect(Direction.west.mp.offset(by: 1, looped: false) == nil)
    }
    
    // MARK: - Method: distance
    
    @Test("distance should calculate distance to another case")
    func testDistance() {
        #expect(Direction.north.mp.distance(to: Direction.east) == 1)
        #expect(Direction.north.mp.distance(to: Direction.south) == 2)
        #expect(Direction.north.mp.distance(to: Direction.west) == 3)
        #expect(Direction.east.mp.distance(to: Direction.north) == -1)
        #expect(Direction.west.mp.distance(to: Direction.north) == -3)
        #expect(Direction.north.mp.distance(to: Direction.north) == 0)
    }
}

enum Direction: String, CaseIterable, Equatable {
    case north
    case east
    case south
    case west
}
