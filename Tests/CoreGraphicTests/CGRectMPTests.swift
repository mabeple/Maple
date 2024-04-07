//
//  CGRectMPTests.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(CoreGraphics)
import CoreGraphics

class CGRectMPTests: XCTestCase {
    func testCenter() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        let center = rect.mp.center
        XCTAssertEqual(center.x, 25)
        XCTAssertEqual(center.y, 40)
    }

    func testInitWithCenterAndSize() {
        let rect = CGRect(center: CGPoint(x: 10, y: 20), size: CGSize(width: 30, height: 40))
        XCTAssertEqual(rect.midX, 10)
        XCTAssertEqual(rect.midY, 20)
        XCTAssertEqual(rect.width, 30)
        XCTAssertEqual(rect.height, 40)
    }

    func testResizingWithAnchor() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        var resizingRect: CGRect
        let newSize = CGSize(width: 40, height: 50)

        // By anchor center
        resizingRect = rect.mp.resizing(to: newSize, anchor: CGPoint(x: 0.5, y: 0.5))
        let rect2 = rect.mp.resizing(to: newSize)
        XCTAssertEqual(resizingRect, rect2)
        XCTAssertEqual(rect.midX, resizingRect.midX)
        XCTAssertEqual(rect.midY, resizingRect.midY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor top left
        resizingRect = rect.mp.resizing(to: newSize, anchor: .zero)
        XCTAssertEqual(rect.origin, resizingRect.origin)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor top right
        resizingRect = rect.mp.resizing(to: newSize, anchor: CGPoint(x: 1.0, y: 0.0))
        XCTAssertEqual(rect.maxX, resizingRect.maxX)
        XCTAssertEqual(rect.minY, resizingRect.minY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor bottom left
        resizingRect = rect.mp.resizing(to: newSize, anchor: CGPoint(x: 0.0, y: 1.0))
        XCTAssertEqual(rect.minX, resizingRect.minX)
        XCTAssertEqual(rect.maxY, resizingRect.maxY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor bottom right
        resizingRect = rect.mp.resizing(to: newSize, anchor: CGPoint(x: 1.0, y: 1.0))
        XCTAssertEqual(rect.maxX, resizingRect.maxX)
        XCTAssertEqual(rect.maxY, resizingRect.maxY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)
    }
}

#endif
