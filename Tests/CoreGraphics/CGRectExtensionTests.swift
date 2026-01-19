//
//  CGRectExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(CoreGraphics)
import CoreGraphics
import Testing
@testable import Maple

@Suite("CGRect Extensions Test Suite")
struct CGRectExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("CGRect should conform to MapleCompatibleValue")
    func testCGRectConformsToMapleCompatibleValue() {
        let rect = CGRect(x: 10, y: 20, width: 100, height: 200)
        let wrapper = rect.mp
        #expect(wrapper.base.origin.x == 10)
        #expect(wrapper.base.origin.y == 20)
        #expect(wrapper.base.size.width == 100)
        #expect(wrapper.base.size.height == 200)
    }
    
    // MARK: - Property: center
    
    @Test("center should return center point of rect")
    func testCenter() {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let center = rect.mp.center
        #expect(center.x == 50)
        #expect(center.y == 50)
        
        let rect2 = CGRect(x: 10, y: 20, width: 80, height: 60)
        let center2 = rect2.mp.center
        #expect(center2.x == 50)
        #expect(center2.y == 50)
        
        let rect3 = CGRect(x: -10, y: -20, width: 40, height: 60)
        let center3 = rect3.mp.center
        #expect(center3.x == 10)
        #expect(center3.y == 10)
    }
    
    // MARK: - Method: resizing(to:anchor:)
    
    @Test("resizing should resize rect with specified anchor")
    func testResizing() {
        let originalRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Test with default anchor (center)
        let newSize1 = CGSize(width: 200, height: 200)
        let resized1 = originalRect.mp.resizing(to: newSize1)
        #expect(resized1.size.width == 200)
        #expect(resized1.size.height == 200)
        #expect(resized1.origin.x == -50)
        #expect(resized1.origin.y == -50)
        
        // Test with top-left anchor
        let anchor1 = CGPoint(x: 0.0, y: 0.0)
        let resized2 = originalRect.mp.resizing(to: newSize1, anchor: anchor1)
        #expect(resized2.size.width == 200)
        #expect(resized2.size.height == 200)
        #expect(resized2.origin.x == 0)
        #expect(resized2.origin.y == 0)
        
        // Test with bottom-right anchor
        let anchor2 = CGPoint(x: 1.0, y: 1.0)
        let resized3 = originalRect.mp.resizing(to: newSize1, anchor: anchor2)
        #expect(resized3.size.width == 200)
        #expect(resized3.size.height == 200)
        #expect(resized3.origin.x == -100)
        #expect(resized3.origin.y == -100)
        
        // Test with custom anchor
        let anchor3 = CGPoint(x: 0.5, y: 0.0)
        let resized4 = originalRect.mp.resizing(to: newSize1, anchor: anchor3)
        #expect(resized4.size.width == 200)
        #expect(resized4.size.height == 200)
        #expect(resized4.origin.x == -50)
        #expect(resized4.origin.y == 0)
        
        // Test with smaller size
        let smallerSize = CGSize(width: 50, height: 50)
        let resized5 = originalRect.mp.resizing(to: smallerSize)
        #expect(resized5.size.width == 50)
        #expect(resized5.size.height == 50)
        #expect(resized5.origin.x == 25)
        #expect(resized5.origin.y == 25)
    }
    
    // MARK: - Initializer: init(center:size:)
    
    @Test("init(center:size:) should create rect with center and size")
    func testInitWithCenterAndSize() {
        let center = CGPoint(x: 50, y: 50)
        let size = CGSize(width: 100, height: 100)
        let rect = CGRect(center: center, size: size)
        
        #expect(rect.size.width == 100)
        #expect(rect.size.height == 100)
        #expect(rect.origin.x == 0)
        #expect(rect.origin.y == 0)
        #expect(rect.midX == 50)
        #expect(rect.midY == 50)
        
        let center2 = CGPoint(x: 100, y: 200)
        let size2 = CGSize(width: 80, height: 60)
        let rect2 = CGRect(center: center2, size: size2)
        
        #expect(rect2.size.width == 80)
        #expect(rect2.size.height == 60)
        #expect(rect2.origin.x == 60)
        #expect(rect2.origin.y == 170)
        #expect(rect2.midX == 100)
        #expect(rect2.midY == 200)
        
        // Test with negative center
        let center3 = CGPoint(x: -10, y: -20)
        let size3 = CGSize(width: 40, height: 60)
        let rect3 = CGRect(center: center3, size: size3)
        
        #expect(rect3.size.width == 40)
        #expect(rect3.size.height == 60)
        #expect(rect3.origin.x == -30)
        #expect(rect3.origin.y == -50)
        #expect(rect3.midX == -10)
        #expect(rect3.midY == -20)
    }
}

#endif
