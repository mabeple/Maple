//
//  NSViewMPTests.swift
//  Maple-macOSTests
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class NSViewMPTests: XCTestCase {

    func testCornerRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertNil(view.layer?.cornerRadius)
        XCTAssertEqual(view.mp.cornerRadius, 0)
        
        view.mp.cornerRadius = 50
        XCTAssertEqual(view.mp.cornerRadius, 50)
    }
    
    func testBackgroundColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertNil(view.layer?.backgroundColor)
        XCTAssertNil(view.mp.backgroundColor)
        
        view.mp.backgroundColor = NSColor.red
        XCTAssertNotNil(view.layer?.backgroundColor)
        XCTAssertNotNil(view.mp.backgroundColor)
        XCTAssertEqual(view.mp.backgroundColor, NSColor.red)
    }
    
    func testAddShadow() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.mp.addShadow(ofColor: .red, radius: 5.0, offset: .zero, opacity: 0.5)
        XCTAssertNotNil(view.layer?.shadowColor)
        XCTAssertEqual(view.layer?.shadowColor, NSColor.red.cgColor)
        XCTAssertEqual(view.layer?.shadowRadius, 5.0)
        XCTAssertEqual(view.layer?.shadowOffset, CGSize.zero)
        XCTAssertEqual(view.layer?.shadowOpacity, 0.5)
    }
}
