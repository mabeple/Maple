//
//  UIScrollViewMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2021/4/29.
//  Copyright © 2021 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(UIKit)
import UIKit

@MainActor
class UIScrollViewMPTests: XCTestCase {
    
    let scroll = UIScrollView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
    
    override func setUp() {
        super.setUp()
        
        scroll.contentSize = CGSize(width: 500, height: 500)
        scroll.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    }
    
    func testSnapshot() {
        let snapshot = scroll.mp.snapshot
        XCTAssertNotNil(snapshot)
        let view = UIScrollView()
        XCTAssertNil(view.mp.snapshot)
    }
    
    func testVisibleRect() {
        XCTAssertEqual(scroll.mp.visibleRect, CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        XCTAssertEqual(scroll.mp.visibleRect, CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 100)))
        
        let offset = CGPoint(x: 490, y: 480)
        scroll.contentOffset = offset
        XCTAssertEqual(scroll.mp.visibleRect, CGRect(origin: offset, size: CGSize(width: 10, height: 20)))
    }
    
    func testScrollToTop() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.mp.scrollToTop(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 50, y: -10))
    }
    
    func testScrollToLeft() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.mp.scrollToLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: -20, y: 50))
    }
    
    func testScrollToBottom() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.mp.scrollToBottom(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 50, y: scroll.contentSize.height - scroll.bounds.height + 30))
    }
    
    func testScrollToRight() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.mp.scrollToRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: scroll.contentSize.width - scroll.bounds.height + 40, y: 50))
    }
    
    func testScrollUp() {
        let offset = CGPoint(x: 50, y: 250)
        scroll.contentOffset = offset
        scroll.mp.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 150))
        scroll.mp.scrollUp(animated: false)
        scroll.mp.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: -10))
        
        let scrollView = UIScrollView()
        scrollView.mp.scrollUp(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
    }
    
    func testScrollLeft() {
        let offset = CGPoint(x: 250, y: 50)
        scroll.contentOffset = offset
        scroll.mp.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 150, y: offset.y))
        scroll.mp.scrollLeft(animated: false)
        scroll.mp.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: -20, y: offset.y))
        
        let scrollView = UIScrollView()
        scrollView.mp.scrollLeft(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
    }
    
    func testScrollDown() {
        let offset = CGPoint(x: 50, y: 250)
        scroll.contentOffset = offset
        scroll.mp.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 350))
        scroll.mp.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 430))
        
        let scrollView = UIScrollView()
        scrollView.mp.scrollDown(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
    }
    
    func testScrollRight() {
        let offset = CGPoint(x: 250, y: 50)
        scroll.contentOffset = offset
        scroll.mp.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 350, y: offset.y))
        scroll.mp.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 440, y: offset.y))
        
        let scrollView = UIScrollView()
        scrollView.mp.scrollRight(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
    }
}
#endif
