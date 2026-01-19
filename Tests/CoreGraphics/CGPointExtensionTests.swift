//
//  CGPointExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(CoreGraphics)
import CoreGraphics
import Testing
@testable import Maple

@Suite("CGPoint Extensions Test Suite")
struct CGPointExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("CGPoint should conform to MapleCompatibleValue")
    func testCGPointConformsToMapleCompatibleValue() {
        let point = CGPoint(x: 10, y: 20)
        let wrapper = point.mp
        #expect(wrapper.base.x == 10)
        #expect(wrapper.base.y == 20)
        #expect(type(of: wrapper) == MapleWrapper<CGPoint>.self)
    }
    
    // MARK: - Method: distance(from:)
    
    @Test("distance should calculate distance between two points")
    func testDistance() {
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 3, y: 4)
        let distance = point1.mp.distance(from: point2)
        #expect(abs(distance - 5.0) < 0.0001)
        
        let point3 = CGPoint(x: 10, y: 10)
        let point4 = CGPoint(x: 30, y: 30)
        let distance2 = point3.mp.distance(from: point4)
        let expectedDistance = sqrt(pow(20, 2) + pow(20, 2))
        #expect(abs(distance2 - expectedDistance) < 0.0001)
        
        // Same point should have zero distance
        let distance3 = point1.mp.distance(from: point1)
        #expect(abs(distance3 - 0.0) < 0.0001)
    }
    
    // MARK: - Operator: + (CGPoint, CGPoint)
    
    @Test("+ operator should add two CGPoints")
    func testAddOperator() {
        let point1 = CGPoint(x: 10, y: 10)
        let point2 = CGPoint(x: 30, y: 30)
        let result = point1 + point2
        #expect(result.x == 40)
        #expect(result.y == 40)
        
        let point3 = CGPoint(x: -5, y: 10)
        let point4 = CGPoint(x: 15, y: -20)
        let result2 = point3 + point4
        #expect(result2.x == 10)
        #expect(result2.y == -10)
    }
    
    // MARK: - Operator: += (inout CGPoint, CGPoint)
    
    @Test("+= operator should add CGPoint to self")
    func testAddAssignmentOperator() {
        var point1 = CGPoint(x: 10, y: 10)
        let point2 = CGPoint(x: 30, y: 30)
        point1 += point2
        #expect(point1.x == 40)
        #expect(point1.y == 40)
        
        var point3 = CGPoint(x: -5, y: 10)
        let point4 = CGPoint(x: 15, y: -20)
        point3 += point4
        #expect(point3.x == 10)
        #expect(point3.y == -10)
    }
    
    // MARK: - Operator: - (CGPoint, CGPoint)
    
    @Test("- operator should subtract two CGPoints")
    func testSubtractOperator() {
        let point1 = CGPoint(x: 10, y: 10)
        let point2 = CGPoint(x: 30, y: 30)
        let result = point1 - point2
        #expect(result.x == -20)
        #expect(result.y == -20)
        
        let point3 = CGPoint(x: 15, y: 20)
        let point4 = CGPoint(x: 5, y: 10)
        let result2 = point3 - point4
        #expect(result2.x == 10)
        #expect(result2.y == 10)
    }
    
    // MARK: - Operator: -= (inout CGPoint, CGPoint)
    
    @Test("-= operator should subtract CGPoint from self")
    func testSubtractAssignmentOperator() {
        var point1 = CGPoint(x: 10, y: 10)
        let point2 = CGPoint(x: 30, y: 30)
        point1 -= point2
        #expect(point1.x == -20)
        #expect(point1.y == -20)
        
        var point3 = CGPoint(x: 15, y: 20)
        let point4 = CGPoint(x: 5, y: 10)
        point3 -= point4
        #expect(point3.x == 10)
        #expect(point3.y == 10)
    }
    
    // MARK: - Operator: * (CGPoint, CGFloat)
    
    @Test("* operator should multiply CGPoint with scalar")
    func testMultiplyOperator() {
        let point1 = CGPoint(x: 10, y: 10)
        let result = point1 * 5
        #expect(result.x == 50)
        #expect(result.y == 50)
        
        let point2 = CGPoint(x: 3, y: 4)
        let result2 = point2 * 2.5
        #expect(result2.x == 7.5)
        #expect(result2.y == 10.0)
        
        // Multiply by zero
        let result3 = point1 * 0
        #expect(result3.x == 0)
        #expect(result3.y == 0)
    }
    
    // MARK: - Operator: *= (inout CGPoint, CGFloat)
    
    @Test("*= operator should multiply self with scalar")
    func testMultiplyAssignmentOperator() {
        var point1 = CGPoint(x: 10, y: 10)
        point1 *= 5
        #expect(point1.x == 50)
        #expect(point1.y == 50)
        
        var point2 = CGPoint(x: 3, y: 4)
        point2 *= 2.5
        #expect(point2.x == 7.5)
        #expect(point2.y == 10.0)
        
        // Multiply by zero
        var point3 = CGPoint(x: 10, y: 10)
        point3 *= 0
        #expect(point3.x == 0)
        #expect(point3.y == 0)
    }
    
    // MARK: - Operator: * (CGFloat, CGPoint)
    
    @Test("* operator should multiply scalar with CGPoint")
    func testScalarMultiplyOperator() {
        let point1 = CGPoint(x: 10, y: 10)
        let result = 5 * point1
        #expect(result.x == 50)
        #expect(result.y == 50)
        
        let point2 = CGPoint(x: 3, y: 4)
        let result2 = 2.5 * point2
        #expect(result2.x == 7.5)
        #expect(result2.y == 10.0)
        
        // Multiply by zero
        let result3 = 0 * point1
        #expect(result3.x == 0)
        #expect(result3.y == 0)
    }
}

#endif
