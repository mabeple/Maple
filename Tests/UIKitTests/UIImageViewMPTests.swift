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
class UIImageViewMPTests: XCTestCase {
    
    func testAverageColor() {
        let size = CGSize(width: 10, height: 5)

        // simple fill test
        XCTAssertEqual(UIColor.blue, UIImage(color: .blue, size: size).mp.averageColor()!, accuracy: 0.01)
        XCTAssertEqual(UIColor.orange, UIImage(color: .orange, size: size).mp.averageColor()!, accuracy: 0.01)

        // more interesting - red + green = yellow
        let renderer = UIGraphicsImageRenderer(size: size)
        let yellow = renderer.image {
            var rect = CGRect(x: 0, y: 0, width: size.width / 2, height: size.height)
            for color in [UIColor.red, UIColor.green] {
                $0.cgContext.beginPath()
                $0.cgContext.setFillColor(color.cgColor)
                $0.cgContext.addRect(rect)
                $0.cgContext.fillPath()
                rect.origin.x += rect.size.width
            }
        }
        XCTAssertEqual(UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1), yellow.mp.averageColor()!)
    }
    
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
