//
//  NSImageMPTests.swift
//  Maple-macOSTests
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class NSImageMPTests: XCTestCase {
    
    func testScaledToMaxSize() {
        let bundle = Bundle.init(for: NSImageMPTests.self)
        let image = bundle.image(forResource: NSImage.Name(stringLiteral: "TestImage"))
        XCTAssertNotNil(image)

        let scaledImage = image?.mp.scaled(toMaxSize: NSSize(width: 150, height: 150))
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage?.size.width, 150)
    }
}
