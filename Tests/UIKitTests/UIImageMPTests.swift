//
//  UIImageMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/11/16.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class UIImageMPTests: XCTestCase {
    
    func testBytesSize() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        XCTAssertEqual(image.mp.bytesSize, 68665)
        XCTAssertEqual(UIImage().mp.bytesSize, 0)
    }

    func testKilobytesSize() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        XCTAssertEqual(image.mp.kilobytesSize, 67)
    }
    
    func testOriginal() {
        let image = UIImage(color: .blue, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.mp.original, image.withRenderingMode(.alwaysOriginal))
    }

    func testTemplate() {
        let image = UIImage(color: .blue, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.mp.template, image.withRenderingMode(.alwaysTemplate))
    }
    
    func testCompressed() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        let originalSize = image.mp.kilobytesSize
        let compressedImage = image.mp.compressed(quality: 0.2)
        XCTAssertNotNil(compressedImage)
        XCTAssertLessThan(compressedImage!.mp.kilobytesSize, originalSize)
        XCTAssertNil(UIImage().mp.compressed())
    }

    func testCompressedData() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        let originalSize = image.mp.bytesSize
        let compressedImageData = image.mp.compressedData(quality: 0.2)
        XCTAssertNotNil(compressedImageData)
        XCTAssertLessThan(compressedImageData!.count, originalSize)
        XCTAssertNil(UIImage().mp.compressedData())
    }

    func testCropped() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        var cropped = image.mp.cropped(to: CGRect(x: 0, y: 0, width: 40, height: 40))
        XCTAssertEqual(image, cropped)
        cropped = image.mp.cropped(to: CGRect(x: 0, y: 0, width: 10, height: 10))
        let small = UIImage(color: .black, size: CGSize(width: 10, height: 10))
        XCTAssertEqual(cropped.mp.bytesSize, small.mp.bytesSize)

        let equalHeight = image.mp.cropped(to: CGRect(x: 0, y: 0, width: 18, height: 20))
        XCTAssertNotEqual(image, equalHeight)

        let equalWidth = image.mp.cropped(to: CGRect(x: 0, y: 0, width: 20, height: 18))
        XCTAssertNotEqual(image, equalWidth)

        guard let cgImage = image.cgImage else {
            XCTFail("Get cgImage from image failed")
            return
        }

        let imageWithScale = UIImage(cgImage: cgImage, scale: 2.0, orientation: .up)
        cropped = imageWithScale.mp.cropped(to: CGRect(x: 0, y: 0, width: 15, height: 15))
        XCTAssertEqual(imageWithScale, cropped)

        cropped = imageWithScale.mp.cropped(to: CGRect(x: 0, y: 0, width: 5, height: 6))
        XCTAssertEqual(imageWithScale.scale, cropped.scale)

        XCTAssertEqual(10, cropped.size.width * cropped.scale)
        XCTAssertEqual(12, cropped.size.height * cropped.scale)
    }

    func testScaledToHeight() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let scaledImage = image.mp.scaled(toHeight: 300)
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage!.size.height, 300, accuracy: 0.1)
    }

    func testScaledToWidth() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let scaledImage = image.mp.scaled(toWidth: 300)
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage!.size.width, 300, accuracy: 0.1)
    }
    
    func testInitWithColor() {
        let size = CGSize(width: 5, height: 5)
        let image = UIImage(color: .white, size: size)
        XCTAssertNotNil(image)
        XCTAssertEqual(image.size, size)
    }
    
    func testInitBase64String() {
        let base64String =
            "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAE0lEQVR42mP8v5JhEwMaYKSBIADNAwvIr8dhZAAAAABJRU5ErkJggg=="
        let image = UIImage(base64String: base64String)
        XCTAssertNotNil(image)
        
        let size = CGSize(width: 5, height: 5)
        XCTAssertEqual(image?.size, size)
    }

}
