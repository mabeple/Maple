//
//  UIStackViewMPTests.swift
//  Maple-iOS
//
//  Created by cy on 2024/1/6.
//  Copyright © 2024 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIStackViewMPTests: XCTestCase {
    
    func testAddArrangedSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        let stack = UIStackView()
        stack.mp.addArrangedSubviews([view1, view2])
        XCTAssertEqual(stack.arrangedSubviews.count, 2)
    }
    
    func testRemoveArrangedSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        let stack = UIStackView()
        stack.addArrangedSubview(view1)
        stack.addArrangedSubview(view2)
        stack.mp.removeArrangedSubviews()
        XCTAssert(stack.arrangedSubviews.isEmpty)
    }
    
    func testInitWithViews() {
         let view1 = UIView()
         let view2 = UIView()
         var stack = UIStackView(arrangedSubviews: [view1, view2], axis: .horizontal)

         XCTAssertEqual(stack.arrangedSubviews.count, 2)
         XCTAssert(stack.arrangedSubviews[0] === view1)
         XCTAssert(stack.arrangedSubviews[1] === view2)

         XCTAssertEqual(stack.axis, .horizontal)
         XCTAssertEqual(stack.alignment, .fill)
         XCTAssertEqual(stack.distribution, .fill)
         XCTAssertEqual(stack.spacing, 0.0)

         XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical).axis, .vertical)
         XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical, alignment: .center).alignment,
                        .center)

         XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical,
                                    distribution: .fillEqually).distribution, .fillEqually)

         XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical, spacing: 16.0).spacing, 16.0)

         stack = UIStackView(arrangedSubviews: [view1, view2], axis: .vertical, spacing: 16.0,
                             alignment: .center, distribution: .fillEqually)

         XCTAssertEqual(stack.axis, .vertical)
         XCTAssertEqual(stack.alignment, .center)
         XCTAssertEqual(stack.distribution, .fillEqually)
         XCTAssertEqual(stack.spacing, 16.0)
     }
}

#endif
