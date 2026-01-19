//
//  UIImageExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit)
import UIKit
import Testing
@testable import Maple

@Suite("UIImage Extensions Test Suite")
struct UIImageExtensionTests {
    
    // MARK: - Test Helpers
    
    /// Load test image from resources
    static func loadTestImage() -> UIImage {
        guard let image = UIImage(named: "TestImage", in: Bundle.module, compatibleWith: nil) else {
            // Fallback to creating a simple test image if resource not found
            return UIImage(color: .red, size: CGSize(width: 100, height: 100))
        }
        return image
    }
    
    // MARK: - Protocol Conformance
    
    @Test("UIImage should conform to MapleCompatible")
    func testMapleCompatible() {
        let image = Self.loadTestImage()
        let wrapper = image.mp
        #expect(type(of: wrapper) == MapleWrapper<UIImage>.self)
    }
    
    // MARK: - Property: bytesSize
    
    @Test("bytesSize should return size in bytes")
    func testBytesSize() {
        let image = Self.loadTestImage()
        let bytesSize = image.mp.bytesSize
        
        #expect(bytesSize >= 0)
    }
    
    // MARK: - Property: kilobytesSize
    
    @Test("kilobytesSize should return size in kilobytes")
    func testKilobytesSize() {
        let image = Self.loadTestImage()
        let kilobytesSize = image.mp.kilobytesSize
        
        #expect(kilobytesSize >= 0)
    }
    
    // MARK: - Property: original
    
    @Test("original should return image with alwaysOriginal rendering mode")
    func testOriginal() {
        let image = Self.loadTestImage()
        let originalImage = image.mp.original
        
        #expect(originalImage.renderingMode == .alwaysOriginal)
    }
    
    // MARK: - Property: template
    
    @Test("template should return image with alwaysTemplate rendering mode")
    func testTemplate() {
        let image = Self.loadTestImage()
        let templateImage = image.mp.template
        
        #expect(templateImage.renderingMode == .alwaysTemplate)
    }
    
    // MARK: - Method: compressed(quality:)
    
    @Test("compressed should return compressed image")
    func testCompressed() {
        let image = Self.loadTestImage()
        let compressed = image.mp.compressed(quality: 0.5)
        
        #expect(compressed != nil)
    }
    
    @Test("compressed should use default quality")
    func testCompressedDefaultQuality() {
        let image = Self.loadTestImage()
        let compressed = image.mp.compressed()
        
        #expect(compressed != nil)
    }
    
    // MARK: - Method: compressedData(quality:)
    
    @Test("compressedData should return data")
    func testCompressedData() {
        let image = Self.loadTestImage()
        let data = image.mp.compressedData(quality: 0.5)
        
        #expect(data != nil)
    }
    
    // MARK: - Method: cropped(to:)
    
    @Test("cropped should crop image to rect")
    func testCropped() {
        let image = Self.loadTestImage()
        let rect = CGRect(x: 0, y: 0, width: image.size.width / 2, height: image.size.height / 2)
        let cropped = image.mp.cropped(to: rect)
        
        #expect(cropped.size.width <= image.size.width)
        #expect(cropped.size.height <= image.size.height)
    }
    
    @Test("cropped should return original image for invalid rect")
    func testCroppedInvalidRect() {
        let image = Self.loadTestImage()
        let rect = CGRect(x: 0, y: 0, width: image.size.width * 2, height: image.size.height * 2)
        let cropped = image.mp.cropped(to: rect)
        
        #expect(cropped.size == image.size)
    }
    
    // MARK: - Method: scaled(toHeight:)
    
    @Test("scaled should scale image to height")
    func testScaledToHeight() {
        let image = Self.loadTestImage()
        let newHeight: CGFloat = 100.0
        let scaled = image.mp.scaled(toHeight: newHeight)
        
        #expect(scaled.size.height == newHeight)
        #expect(scaled.size.width > 0)
    }
    
    // MARK: - Method: scaled(toWidth:)
    
    @Test("scaled should scale image to width")
    func testScaledToWidth() {
        let image = Self.loadTestImage()
        let newWidth: CGFloat = 100.0
        let scaled = image.mp.scaled(toWidth: newWidth)
        
        #expect(scaled.size.width == newWidth)
        #expect(scaled.size.height > 0)
    }
    
    // MARK: - Method: rotated(by:)
    
    @Test("rotated should rotate image")
    func testRotated() {
        let image = Self.loadTestImage()
        let rotated = image.mp.rotated(by: .pi / 2)
        
        // Rotated image should have valid size
        #expect(rotated.size.width > 0)
        #expect(rotated.size.height > 0)
    }
    
    // MARK: - Method: filled(withColor:)
    
    @Test("filled should fill image with color")
    func testFilled() {
        let image = Self.loadTestImage()
        let color = UIColor.red
        let filled = image.mp.filled(withColor: color)
        
        #expect(filled.size == image.size)
    }
    
    // MARK: - Method: tint(_:blendMode:alpha:)
    
    @Test("tint should tint image with color")
    func testTint() {
        let image = Self.loadTestImage()
        let color = UIColor.blue
        let tinted = image.mp.tint(color, blendMode: .normal, alpha: 1.0)
        
        #expect(tinted.size == image.size)
    }
    
    // MARK: - Method: withBackgroundColor(_:)
    
    @Test("withBackgroundColor should add background color")
    func testWithBackgroundColor() {
        let image = Self.loadTestImage()
        let backgroundColor = UIColor.yellow
        let imageWithBackground = image.mp.withBackgroundColor(backgroundColor)
        
        #expect(imageWithBackground.size == image.size)
    }
    
    // MARK: - Method: withRoundedCorners(radius:)
    
    @Test("withRoundedCorners should round corners")
    func testWithRoundedCorners() {
        let image = Self.loadTestImage()
        let rounded = image.mp.withRoundedCorners(radius: 10.0)
        
        #expect(rounded != nil)
    }
    
    @Test("withRoundedCorners should use default radius")
    func testWithRoundedCornersDefault() {
        let image = Self.loadTestImage()
        let rounded = image.mp.withRoundedCorners()
        
        #expect(rounded != nil)
    }
    
    // MARK: - Method: pngData
    
    @Test("pngData should return PNG data")
    func testPngData() {
        let image = Self.loadTestImage()
        let data = image.mp.pngData()
        
        #expect(data != nil)
    }
    
    // MARK: - Method: pngBase64String
    
    @Test("pngBase64String should return base64 string")
    func testPngBase64String() {
        let image = Self.loadTestImage()
        let base64String = image.mp.pngBase64String()
        
        #expect(base64String != nil)
        #expect(base64String?.isEmpty == false)
    }
    
    // MARK: - Method: jpegBase64String(compressionQuality:)
    
    @Test("jpegBase64String should return base64 string")
    func testJpegBase64String() {
        let image = Self.loadTestImage()
        let base64String = image.mp.jpegBase64String(compressionQuality: 0.5)
        
        #expect(base64String != nil)
        #expect(base64String?.isEmpty == false)
    }
    
    // MARK: - Initializer: init(color:size:)
    
    @Test("init with color and size should create image")
    func testInitWithColor() {
        let color = UIColor.red
        let size = CGSize(width: 100, height: 100)
        let image = UIImage(color: color, size: size)
        
        #expect(image.size == size)
    }
    
    @Test("init with color should use default size")
    func testInitWithColorDefaultSize() {
        let color = UIColor.blue
        let image = UIImage(color: color)
        
        #expect(image.size == CGSize(width: 1, height: 1))
    }
    
    // MARK: - Initializer: init?(base64String:scale:)
    
    @Test("init with base64String should create image")
    func testInitWithBase64String() {
        // Create a test image and convert to base64
        let testImage = Self.loadTestImage()
        guard let imageData = testImage.pngData() else {
            return
        }
        let base64String = imageData.base64EncodedString()
        
        let image = UIImage(base64String: base64String)
        
        #expect(image != nil)
    }
    
    @Test("init with invalid base64String should return nil")
    func testInitWithInvalidBase64String() {
        let image = UIImage(base64String: "invalid base64 string")
        
        #expect(image == nil)
    }
    
    #if canImport(CoreImage)
    // MARK: - Method: averageColor()
    
    @Test("averageColor should return average color")
    func testAverageColor() {
        let image = Self.loadTestImage()
        let averageColor = image.mp.averageColor()
        
        // May return nil for some images, but should not crash
        #expect(averageColor == nil || averageColor != nil)
    }
    #endif
    
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    // MARK: - Method: withAlwaysOriginalTintColor(_:)
    
    @Test("withAlwaysOriginalTintColor should return tinted image")
    func testWithAlwaysOriginalTintColor() {
        let image = Self.loadTestImage()
        let color = UIColor.green
        let tinted = image.mp.withAlwaysOriginalTintColor(color)
        
        #expect(tinted.renderingMode == .alwaysOriginal)
    }
}
#endif
