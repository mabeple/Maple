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
        if #available(iOS 17.0, *) {
            XCTAssertEqual(image.mp.bytesSize, 68717)
        } else {
            XCTAssertEqual(image.mp.bytesSize, 68665)
        }
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
    
    func testRotatedByRadians() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        
        let halfRotatedImage = image.mp.rotated(by: .pi / 2)
        XCTAssertNotNil(halfRotatedImage)
        XCTAssertEqual(halfRotatedImage!.size, CGSize(width: image.size.height, height: image.size.width))
        
        let rotatedImage = image.mp.rotated(by: .pi)
        XCTAssertNotNil(rotatedImage)
        XCTAssertEqual(rotatedImage!.size, image.size)
        XCTAssertNotEqual(image.jpegData(compressionQuality: 1), rotatedImage!.jpegData(compressionQuality: 1))
    }
    
    func testFilled() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        let image2 = UIImage(color: .yellow, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.mp.filled(withColor: .yellow).mp.bytesSize, image2.mp.bytesSize)
        
        var emptyImage = UIImage()
        var filledImage = emptyImage.mp.filled(withColor: .red)
        XCTAssertEqual(emptyImage, filledImage)
        
        emptyImage = UIImage(color: .yellow, size: CGSize.zero)
        filledImage = emptyImage.mp.filled(withColor: .red)
        XCTAssertEqual(emptyImage, filledImage)
    }
    
    func testWithBackgroundColor() {
        let size = CGSize(width: 1, height: 1)
        let clearImage = UIImage(color: .clear, size: size)
        let imageWithBackgroundColor = clearImage.mp.withBackgroundColor(.black)
        XCTAssertNotNil(imageWithBackgroundColor)
    }
    
    func testWithCornerRadius() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        XCTAssertNotNil(image.mp.withRoundedCorners())
        XCTAssertNotNil(image.mp.withRoundedCorners(radius: 5))
        XCTAssertNotNil(image.mp.withRoundedCorners(radius: -10))
        XCTAssertNotNil(image.mp.withRoundedCorners(radius: 30))
    }
    
    func testPngData() {
        let bundle = Bundle(for: UIImageMPTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        let originalData = image.pngData()
        let imageData = image.mp.pngData()
        XCTAssertNotNil(originalData)
        XCTAssertEqual(originalData, imageData)
    }
    
    func testPNGBase64String() {
        let image = UIImage(color: .blue, size: CGSize(width: 1, height: 1))
        let base64String: String
        if #available(iOS 17.0, *) {
            base64String =
            "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAIRlWElmTU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgEoAAMAAAABAAIAAIdpAAQAAAABAAAAWgAAAAAAAABIAAAAAQAAAEgAAAABAAOgAQADAAAAAQABAACgAgAEAAAAAQAAAAGgAwAEAAAAAQAAAAEAAAAAChjw/QAAAAlwSFlzAAALEwAACxMBAJqcGAAAAA1JREFUCB1jYGD4/x8AAwIB/6fhVKUAAAAASUVORK5CYII="
        } else {
            base64String =
            "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD5Ip3+AAAADUlEQVQIHWNgYPj/HwADAgH/p+FUpQAAAABJRU5ErkJggg=="
        }
        XCTAssertEqual(
            image.mp.pngBase64String(),
            base64String)
    }
    
    func testJPEGBase64String() {
        let image = UIImage(color: .blue, size: CGSize(width: 1, height: 1))
        let base64String: String
        if #available(iOS 17.0, *) {
            base64String =
            "/9j/4AAQSkZJRgABAQAASABIAAD/4QCMRXhpZgAATU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgEoAAMAAAABAAIAAIdpAAQAAAABAAAAWgAAAAAAAABIAAAAAQAAAEgAAAABAAOgAQADAAAAAQABAACgAgAEAAAAAQAAAAGgAwAEAAAAAQAAAAEAAAAA/+0AOFBob3Rvc2hvcCAzLjAAOEJJTQQEAAAAAAAAOEJJTQQlAAAAAAAQ1B2M2Y8AsgTpgAmY7PhCfv/AABEIAAEAAQMBEQACEQEDEQH/xAAfAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/3QAEAAH/2gAMAwEAAhEDEQA/AP456/7+D+Vz/9k="
        } else {
            base64String =
            "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAAQABAwERAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/dAAQAAf/aAAwDAQACEQMRAD8A/jnr/v4P5XP/2Q=="
        }
        XCTAssertEqual(
            image.mp.jpegBase64String(compressionQuality: 1),
            base64String)
    }
    
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testWithAlwaysOriginalTintColor() {
        let image = UIImage(color: .blue, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(
            image.mp.withAlwaysOriginalTintColor(.red),
            image.withTintColor(.red, renderingMode: .alwaysOriginal))
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
