//
//  UIImageViewMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/11/16.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(UIKit)
import UIKit

@MainActor
class UIImageViewMPTests: XCTestCase {
    
    func testBlur() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        imageView.mp.blur(withStyle: .dark)

        let blurView = imageView.subviews.first as? UIVisualEffectView
        XCTAssertNotNil(blurView)
        XCTAssertNotNil(blurView?.effect)
        XCTAssertEqual(blurView?.frame, imageView.bounds)
        XCTAssertEqual(blurView?.autoresizingMask, [.flexibleWidth, .flexibleHeight])
        XCTAssert(imageView.clipsToBounds)
    }

    func testBlurred() {
        let imageView = UIImageView()
        let blurredImageView = imageView.mp.blurred(withStyle: .extraLight)
        XCTAssertEqual(blurredImageView, imageView)
    }

}
#endif
