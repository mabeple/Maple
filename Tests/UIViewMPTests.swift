//
//  UIViewMPTests.swift
//  MapleiOSTests
//
//  Created by cy on 2020/5/29.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple

class UIViewMPTests: XCTestCase {

    func testCornerRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.layer.cornerRadius, 0)

        view.mp.cornerRadius = 50
        XCTAssertEqual(view.mp.cornerRadius, 50)
    }
    
    func testParentViewController() {
        let viewController = UIViewController()
        XCTAssertNotNil(viewController.view.mp.parentViewController)
        XCTAssertEqual(viewController.view.mp.parentViewController, viewController)

        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertNil(view.mp.parentViewController)
    }
    
    func testScreenshot() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.backgroundColor = .black
        let screenshot = view.mp.screenshot
        XCTAssertNotNil(screenshot)

        let view2 = UIView()
        XCTAssertNil(view2.mp.screenshot)
    }
    
    func testFirstResponder() {
        // When there's no firstResponder
        XCTAssertNil(UIView().mp.firstResponder())

        let window = UIWindow()

        // When self is firstResponder
        let txtView = UITextField(frame: CGRect.zero)
        window.addSubview(txtView)
        txtView.becomeFirstResponder()
        XCTAssertTrue(txtView.mp.firstResponder() === txtView)

        // When a subview is firstResponder
        let superView = UIView()
        window.addSubview(superView)
        let subView = UITextField(frame: CGRect.zero)
        superView.addSubview(subView)
        subView.becomeFirstResponder()
        XCTAssertTrue(superView.mp.firstResponder() === subView)

        // When you have to find recursively
        XCTAssertTrue(window.mp.firstResponder() === subView)

    }
    
    func testAddShadow() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.mp.addShadow(ofColor: .red, radius: 5.0, offset: .zero, opacity: 0.5)
        XCTAssertNotNil(view.layer.shadowColor)
        XCTAssertEqual(view.layer.shadowColor, UIColor.red.cgColor)
        XCTAssertEqual(view.layer.shadowRadius, 5.0)
        XCTAssertEqual(view.layer.shadowOffset, CGSize.zero)
        XCTAssertEqual(view.layer.shadowOpacity, 0.5)
    }
    
    func testRoundCorners() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.mp.roundCorners([.allCorners], radius: 5.0)

        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.allCorners],
                                    cornerRadii: CGSize(width: 5.0, height: 5.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        XCTAssertEqual(view.layer.mask?.bounds, shape.bounds)
        XCTAssertEqual(view.layer.mask?.cornerRadius, shape.cornerRadius)
    }
}
