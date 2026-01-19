//
//  UIScrollViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIScrollView Extensions Test Suite")
struct UIScrollViewExtensionTests {
    
    // MARK: - Property: snapshot
    
    @Test("snapshot should return UIImage for scroll view with content")
    @MainActor
    func testSnapshot() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 400, height: 400)
        scrollView.backgroundColor = .white
        
        let snapshot = scrollView.mp.snapshot
        
        #expect(snapshot != nil)
        #expect(snapshot?.size == scrollView.contentSize)
    }
    
    @Test("snapshot should return nil for zero content size")
    @MainActor
    func testSnapshotZeroSize() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = .zero
        
        let snapshot = scrollView.mp.snapshot
        
        #expect(snapshot == nil)
    }
    
    // MARK: - Property: visibleRect
    
    @Test("visibleRect should return visible region")
    @MainActor
    func testVisibleRect() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 400, height: 400)
        scrollView.contentOffset = CGPoint(x: 50, y: 50)
        
        let visibleRect = scrollView.mp.visibleRect
        
        #expect(visibleRect.origin == scrollView.contentOffset)
        #expect(visibleRect.size.width <= scrollView.bounds.size.width)
        #expect(visibleRect.size.height <= scrollView.bounds.size.height)
    }
    
    // MARK: - Method: scrollToTop
    
    @Test("scrollToTop should scroll to top")
    @MainActor
    func testScrollToTop() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 200, height: 400)
        scrollView.contentOffset = CGPoint(x: 0, y: 200)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        scrollView.mp.scrollToTop(animated: false)
        
        #expect(scrollView.contentOffset.y == -scrollView.contentInset.top)
    }
    
    // MARK: - Method: scrollToLeft
    
    @Test("scrollToLeft should scroll to left")
    @MainActor
    func testScrollToLeft() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 400, height: 200)
        scrollView.contentOffset = CGPoint(x: 200, y: 0)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        scrollView.mp.scrollToLeft(animated: false)
        
        #expect(scrollView.contentOffset.x == -scrollView.contentInset.left)
    }
    
    // MARK: - Method: scrollToBottom
    
    @Test("scrollToBottom should scroll to bottom")
    @MainActor
    func testScrollToBottom() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 200, height: 400)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        scrollView.mp.scrollToBottom(animated: false)
        
        let expectedY = max(0, scrollView.contentSize.height - scrollView.bounds.height) + scrollView.contentInset.bottom
        #expect(scrollView.contentOffset.y == expectedY)
    }
    
    // MARK: - Method: scrollToRight
    
    @Test("scrollToRight should scroll to right")
    @MainActor
    func testScrollToRight() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 400, height: 200)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        scrollView.mp.scrollToRight(animated: false)
        
        let expectedX = max(0, scrollView.contentSize.width - scrollView.bounds.width) + scrollView.contentInset.right
        #expect(scrollView.contentOffset.x == expectedX)
    }
    
    // MARK: - Method: scrollUp
    
    @Test("scrollUp should scroll up one page")
    @MainActor
    func testScrollUp() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 200, height: 600)
        scrollView.contentOffset = CGPoint(x: 0, y: 400)
        
        let initialY = scrollView.contentOffset.y
        scrollView.mp.scrollUp(animated: false)
        
        #expect(scrollView.contentOffset.y < initialY)
        #expect(scrollView.contentOffset.y >= -scrollView.contentInset.top)
    }
    
    // MARK: - Method: scrollLeft
    
    @Test("scrollLeft should scroll left one page")
    @MainActor
    func testScrollLeft() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 600, height: 200)
        scrollView.contentOffset = CGPoint(x: 400, y: 0)
        
        let initialX = scrollView.contentOffset.x
        scrollView.mp.scrollLeft(animated: false)
        
        #expect(scrollView.contentOffset.x < initialX)
        #expect(scrollView.contentOffset.x >= -scrollView.contentInset.left)
    }
    
    // MARK: - Method: scrollDown
    
    @Test("scrollDown should scroll down one page")
    @MainActor
    func testScrollDown() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 200, height: 600)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let initialY = scrollView.contentOffset.y
        scrollView.mp.scrollDown(animated: false)
        
        #expect(scrollView.contentOffset.y > initialY)
    }
    
    // MARK: - Method: scrollRight
    
    @Test("scrollRight should scroll right one page")
    @MainActor
    func testScrollRight() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scrollView.contentSize = CGSize(width: 600, height: 200)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        let initialX = scrollView.contentOffset.x
        scrollView.mp.scrollRight(animated: false)
        
        #expect(scrollView.contentOffset.x > initialX)
    }
    
    // MARK: - Method: addPaddingTop
    
    @Test("addPaddingTop should add top padding")
    @MainActor
    func testAddPaddingTop() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let padding: CGFloat = 20.0
        
        scrollView.mp.addPaddingTop(padding, animated: false)
        
        #expect(scrollView.contentInset.top == padding)
        #expect(scrollView.contentOffset.y == -padding)
    }
    
    @Test("addPaddingTop should work with animated parameter")
    @MainActor
    func testAddPaddingTopAnimated() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let padding: CGFloat = 30.0
        
        scrollView.mp.addPaddingTop(padding, animated: true)
        
        #expect(scrollView.contentInset.top == padding)
    }
}
#endif
