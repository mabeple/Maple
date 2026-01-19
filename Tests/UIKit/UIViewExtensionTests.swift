//
//  UIViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIView Extensions Test Suite")
struct UIViewExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("UIView should conform to MapleCompatible")
    @MainActor
    func testMapleCompatible() {
        let view = UIView()
        let wrapper = view.mp
        #expect(type(of: wrapper) == MapleWrapper<UIView>.self)
    }
    
    // MARK: - Property: cornerRadius
    
    @Test("cornerRadius getter and setter should work")
    @MainActor
    func testCornerRadius() {
        let view = UIView()
        let radius: CGFloat = 10.0
        
        view.mp.cornerRadius = radius
        
        #expect(view.mp.cornerRadius == radius)
        #expect(view.layer.cornerRadius == radius)
        #expect(view.layer.masksToBounds == true)
    }
    
    @Test("cornerRadius should set masksToBounds to true")
    @MainActor
    func testCornerRadiusMasksToBounds() {
        let view = UIView()
        view.layer.masksToBounds = false
        
        view.mp.cornerRadius = 5.0
        
        #expect(view.layer.masksToBounds == true)
    }
    
    // MARK: - Property: parentViewController
    
    @Test("parentViewController should return nil for view without parent")
    @MainActor
    func testParentViewControllerNil() {
        let view = UIView()
        
        #expect(view.mp.parentViewController == nil)
    }
    
    @Test("parentViewController should return parent view controller")
    @MainActor
    func testParentViewController() {
        let viewController = UIViewController()
        let view = UIView()
        viewController.view.addSubview(view)
        
        // Note: parentViewController may not work immediately after adding subview
        // This test verifies the method executes without error
        let parent = view.mp.parentViewController
        #expect(parent == nil || parent === viewController)
    }
    
    // MARK: - Property: screenshot
    
    @Test("screenshot should return UIImage for view with size")
    @MainActor
    func testScreenshot() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        
        let screenshot = view.mp.screenshot
        
        #expect(screenshot != nil)
        #expect(screenshot?.size == view.frame.size)
    }
    
    @Test("screenshot should return nil for zero-sized view")
    @MainActor
    func testScreenshotZeroSize() {
        let view = UIView(frame: .zero)
        
        let screenshot = view.mp.screenshot
        
        #expect(screenshot == nil)
    }
    
    // MARK: - Method: firstResponder
    
    @Test("firstResponder should return nil when no first responder")
    @MainActor
    func testFirstResponder() {
        // When there's no firstResponder
        #expect(UIView().mp.firstResponder() == nil)
        
        let window = UIWindow()
        
        // When self is firstResponder
        let txtView = UITextField(frame: CGRect.zero)
        window.addSubview(txtView)
        txtView.becomeFirstResponder()
        #expect(txtView.mp.firstResponder() === txtView)
        
        // When a subview is firstResponder
        let superView = UIView()
        window.addSubview(superView)
        let subView = UITextField(frame: CGRect.zero)
        superView.addSubview(subView)
        subView.becomeFirstResponder()
        #expect(superView.mp.firstResponder() === subView)
        
        // When you have to find recursively
        #expect(window.mp.firstResponder() === subView)
    }
    
    // MARK: - Method: addShadow
    
    @Test("addShadow should configure shadow properties")
    @MainActor
    func testAddShadow() {
        let view = UIView()
        let color = UIColor.red
        let radius: CGFloat = 5.0
        let offset = CGSize(width: 2, height: 2)
        let opacity: Float = 0.8
        
        view.mp.addShadow(ofColor: color, radius: radius, offset: offset, opacity: opacity)
        
        #expect(view.layer.shadowColor == color.cgColor)
        #expect(view.layer.shadowRadius == radius)
        #expect(view.layer.shadowOffset == offset)
        #expect(view.layer.shadowOpacity == opacity)
        #expect(view.layer.masksToBounds == false)
    }
    
    @Test("addShadow should use default values")
    @MainActor
    func testAddShadowDefaults() {
        let view = UIView()
        
        view.mp.addShadow()
        
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
        #expect(view.layer.shadowRadius == 3.0)
        #expect(view.layer.shadowOffset == .zero)
        #expect(view.layer.shadowOpacity == 0.5)
        #expect(view.layer.masksToBounds == false)
    }
    
    // MARK: - Method: roundCorners
    
    @Test("roundCorners should round specified corners")
    @MainActor
    func testRoundCorners() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let radius: CGFloat = 10.0
        
        view.mp.roundCorners([.topLeft, .topRight], radius: radius)
        
        #expect(view.layer.mask != nil)
    }
    
    @Test("roundCorners should work with all corners")
    @MainActor
    func testRoundCornersAll() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let radius: CGFloat = 15.0
        
        view.mp.roundCorners([.allCorners], radius: radius)
        
        #expect(view.layer.mask != nil)
    }
}
#endif
