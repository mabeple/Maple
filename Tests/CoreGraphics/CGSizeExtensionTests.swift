//
//  CGSizeExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(CoreGraphics)
import CoreGraphics
import Testing
@testable import Maple

@Suite("CGSize Extensions Test Suite")
struct CGSizeExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("CGSize should conform to MapleCompatibleValue")
    func testCGSizeConformsToMapleCompatibleValue() {
        let size = CGSize(width: 100, height: 200)
        let wrapper = size.mp
        #expect(wrapper.base.width == 100)
        #expect(wrapper.base.height == 200)
    }
    
    // MARK: - Property: aspectRatio
    
    @Test("aspectRatio should return width to height ratio")
    func testAspectRatio() {
        let size1 = CGSize(width: 100, height: 50)
        #expect(size1.mp.aspectRatio == 2.0)
        
        let size2 = CGSize(width: 50, height: 100)
        #expect(size2.mp.aspectRatio == 0.5)
        
        let size3 = CGSize(width: 100, height: 100)
        #expect(size3.mp.aspectRatio == 1.0)
        
        // Test with zero height
        let size4 = CGSize(width: 100, height: 0)
        #expect(size4.mp.aspectRatio == 0.0)
    }
    
    // MARK: - Property: maxDimension
    
    @Test("maxDimension should return larger dimension")
    func testMaxDimension() {
        let size1 = CGSize(width: 100, height: 50)
        #expect(size1.mp.maxDimension == 100)
        
        let size2 = CGSize(width: 50, height: 100)
        #expect(size2.mp.maxDimension == 100)
        
        let size3 = CGSize(width: 100, height: 100)
        #expect(size3.mp.maxDimension == 100)
        
        let size4 = CGSize(width: 10, height: 5)
        #expect(size4.mp.maxDimension == 10)
    }
    
    // MARK: - Property: minDimension
    
    @Test("minDimension should return smaller dimension")
    func testMinDimension() {
        let size1 = CGSize(width: 100, height: 50)
        #expect(size1.mp.minDimension == 50)
        
        let size2 = CGSize(width: 50, height: 100)
        #expect(size2.mp.minDimension == 50)
        
        let size3 = CGSize(width: 100, height: 100)
        #expect(size3.mp.minDimension == 100)
        
        let size4 = CGSize(width: 10, height: 5)
        #expect(size4.mp.minDimension == 5)
    }
    
    // MARK: - Method: aspectFit(to:)
    
    @Test("aspectFit should fit size to bounding size")
    func testAspectFit() {
        let rect = CGSize(width: 120, height: 80)
        let parentRect = CGSize(width: 100, height: 50)
        let newRect = rect.mp.aspectFit(to: parentRect)
        
        // Should fit within bounds while maintaining aspect ratio
        #expect(newRect.width <= parentRect.width)
        #expect(newRect.height <= parentRect.height)
        let tolerance: CGFloat = 0.0001
        #expect(abs(newRect.width / newRect.height - rect.width / rect.height) < tolerance)
        
        // Specific test case from documentation
        #expect(abs(newRect.width - 75) < 0.1)
        #expect(abs(newRect.height - 50) < 0.1)
        
        // Test with larger size
        let size1 = CGSize(width: 200, height: 100)
        let bounds1 = CGSize(width: 100, height: 100)
        let fitted1 = size1.mp.aspectFit(to: bounds1)
        #expect(fitted1.width == 100)
        #expect(fitted1.height == 50)
        
        let size2 = CGSize(width: 120, height: 80)
        let bounds2 = CGSize(width: 100, height: 50)
        let fitted2 = size2.mp.aspectFit(to: bounds2)
        #expect(fitted2.width == 75)
        #expect(fitted2.height == 50)
    }
    
    // MARK: - Method: aspectFill(to:)
    
    @Test("aspectFill should fill size to bounding size")
    func testAspectFill() {
        // Test case from documentation: rect = (20, 120), parentRect = (100, 60)
        // minRatio = max(100/20, 60/120) = max(5, 0.5) = 5
        // aWidth = min(20 * 5, 100) = 100, aHeight = min(120 * 5, 60) = 60
        let rect = CGSize(width: 20, height: 120)
        let parentRect = CGSize(width: 100, height: 60)
        let newRect = rect.mp.aspectFill(to: parentRect)
        #expect(newRect.width == 100)
        #expect(newRect.height == 60)
        
        // Test with different aspect ratios: size1 = (100, 50), bounds1 = (200, 200)
        // minRatio = max(200/100, 200/50) = max(2, 4) = 4
        // aWidth = min(100 * 4, 200) = 200, aHeight = min(50 * 4, 200) = 200
        let size1 = CGSize(width: 100, height: 50)
        let bounds1 = CGSize(width: 200, height: 200)
        let filled1 = size1.mp.aspectFill(to: bounds1)
        #expect(filled1.width == 200)
        #expect(filled1.height == 200)
        
        // Test with square source and rectangular bounds: size2 = (50, 50), bounds2 = (100, 200)
        // minRatio = max(100/50, 200/50) = max(2, 4) = 4
        // aWidth = min(50 * 4, 100) = 100, aHeight = min(50 * 4, 200) = 200
        let size2 = CGSize(width: 50, height: 50)
        let bounds2 = CGSize(width: 100, height: 200)
        let filled2 = size2.mp.aspectFill(to: bounds2)
        #expect(filled2.width == 100)
        #expect(filled2.height == 200)
    }
    
    // MARK: - Operator: + (CGSize, CGSize)
    
    @Test("+ operator should add two CGSize")
    func testAddOperator() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA + sizeB
        #expect(result.width == 8)
        #expect(result.height == 14)
        
        let sizeC = CGSize(width: -5, height: 10)
        let sizeD = CGSize(width: 10, height: -5)
        let result2 = sizeC + sizeD
        #expect(result2.width == 5)
        #expect(result2.height == 5)
    }
    
    // MARK: - Operator: + (CGSize, tuple)
    
    @Test("+ operator should add CGSize with tuple")
    func testAddOperatorWithTuple() {
        let sizeA = CGSize(width: 5, height: 10)
        let result = sizeA + (5, 4)
        #expect(result.width == 10)
        #expect(result.height == 14)
        
        let sizeB = CGSize(width: 10, height: 20)
        let result2 = sizeB + (-5, 10)
        #expect(result2.width == 5)
        #expect(result2.height == 30)
    }
    
    // MARK: - Operator: += (inout CGSize, CGSize)
    
    @Test("+= operator should add CGSize to self")
    func testAddAssignmentOperator() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA += sizeB
        #expect(sizeA.width == 8)
        #expect(sizeA.height == 14)
        
        var sizeC = CGSize(width: 10, height: 20)
        let sizeD = CGSize(width: -5, height: 10)
        sizeC += sizeD
        #expect(sizeC.width == 5)
        #expect(sizeC.height == 30)
    }
    
    // MARK: - Operator: += (inout CGSize, tuple)
    
    @Test("+= operator should add tuple to self")
    func testAddAssignmentOperatorWithTuple() {
        var sizeA = CGSize(width: 5, height: 10)
        sizeA += (3, 4)
        #expect(sizeA.width == 8)
        #expect(sizeA.height == 14)
        
        var sizeB = CGSize(width: 10, height: 20)
        sizeB += (-5, 10)
        #expect(sizeB.width == 5)
        #expect(sizeB.height == 30)
    }
    
    // MARK: - Operator: - (CGSize, CGSize)
    
    @Test("- operator should subtract two CGSize")
    func testSubtractOperator() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA - sizeB
        #expect(result.width == 2)
        #expect(result.height == 6)
        
        let sizeC = CGSize(width: 10, height: 20)
        let sizeD = CGSize(width: 15, height: 5)
        let result2 = sizeC - sizeD
        #expect(result2.width == -5)
        #expect(result2.height == 15)
    }
    
    // MARK: - Operator: - (CGSize, tuple)
    
    @Test("- operator should subtract tuple from CGSize")
    func testSubtractOperatorWithTuple() {
        let sizeA = CGSize(width: 5, height: 10)
        let result = sizeA - (3, 2)
        #expect(result.width == 2)
        #expect(result.height == 8)
        
        let sizeB = CGSize(width: 10, height: 20)
        let result2 = sizeB - (15, 5)
        #expect(result2.width == -5)
        #expect(result2.height == 15)
    }
    
    // MARK: - Operator: -= (inout CGSize, CGSize)
    
    @Test("-= operator should subtract CGSize from self")
    func testSubtractAssignmentOperator() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA -= sizeB
        #expect(sizeA.width == 2)
        #expect(sizeA.height == 6)
        
        var sizeC = CGSize(width: 10, height: 20)
        let sizeD = CGSize(width: 15, height: 5)
        sizeC -= sizeD
        #expect(sizeC.width == -5)
        #expect(sizeC.height == 15)
    }
    
    // MARK: - Operator: -= (inout CGSize, tuple)
    
    @Test("-= operator should subtract tuple from self")
    func testSubtractAssignmentOperatorWithTuple() {
        var sizeA = CGSize(width: 5, height: 10)
        sizeA -= (2, 4)
        #expect(sizeA.width == 3)
        #expect(sizeA.height == 6)
        
        var sizeB = CGSize(width: 10, height: 20)
        sizeB -= (15, 5)
        #expect(sizeB.width == -5)
        #expect(sizeB.height == 15)
    }
    
    // MARK: - Operator: * (CGSize, CGSize)
    
    @Test("* operator should multiply two CGSize")
    func testMultiplyOperator() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA * sizeB
        #expect(result.width == 15)
        #expect(result.height == 40)
        
        let sizeC = CGSize(width: 2, height: 3)
        let sizeD = CGSize(width: 4, height: 5)
        let result2 = sizeC * sizeD
        #expect(result2.width == 8)
        #expect(result2.height == 15)
    }
    
    // MARK: - Operator: * (CGSize, CGFloat)
    
    @Test("* operator should multiply CGSize with scalar")
    func testMultiplyOperatorWithScalar() {
        let sizeA = CGSize(width: 5, height: 10)
        let result = sizeA * 5
        #expect(result.width == 25)
        #expect(result.height == 50)
        
        let sizeB = CGSize(width: 3, height: 4)
        let result2 = sizeB * 2.5
        #expect(result2.width == 7.5)
        #expect(result2.height == 10.0)
        
        // Multiply by zero
        let result3 = sizeA * 0
        #expect(result3.width == 0)
        #expect(result3.height == 0)
    }
    
    // MARK: - Operator: * (CGFloat, CGSize)
    
    @Test("* operator should multiply scalar with CGSize")
    func testScalarMultiplyOperator() {
        let sizeA = CGSize(width: 5, height: 10)
        let result = 5 * sizeA
        #expect(result.width == 25)
        #expect(result.height == 50)
        
        let sizeB = CGSize(width: 3, height: 4)
        let result2 = 2.5 * sizeB
        #expect(result2.width == 7.5)
        #expect(result2.height == 10.0)
        
        // Multiply by zero
        let result3 = 0 * sizeA
        #expect(result3.width == 0)
        #expect(result3.height == 0)
    }
    
    // MARK: - Operator: *= (inout CGSize, CGSize)
    
    @Test("*= operator should multiply self with CGSize")
    func testMultiplyAssignmentOperator() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA *= sizeB
        #expect(sizeA.width == 15)
        #expect(sizeA.height == 40)
        
        var sizeC = CGSize(width: 2, height: 3)
        let sizeD = CGSize(width: 4, height: 5)
        sizeC *= sizeD
        #expect(sizeC.width == 8)
        #expect(sizeC.height == 15)
    }
    
    // MARK: - Operator: *= (inout CGSize, CGFloat)
    
    @Test("*= operator should multiply self with scalar")
    func testMultiplyAssignmentOperatorWithScalar() {
        var sizeA = CGSize(width: 5, height: 10)
        sizeA *= 3
        #expect(sizeA.width == 15)
        #expect(sizeA.height == 30)
        
        var sizeB = CGSize(width: 3, height: 4)
        sizeB *= 2.5
        #expect(sizeB.width == 7.5)
        #expect(sizeB.height == 10.0)
        
        // Multiply by zero
        var sizeC = CGSize(width: 10, height: 20)
        sizeC *= 0
        #expect(sizeC.width == 0)
        #expect(sizeC.height == 0)
    }
}

#endif
