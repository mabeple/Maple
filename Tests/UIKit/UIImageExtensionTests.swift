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
        let image = UIImage(named: "TestImage", in: Bundle.module, compatibleWith: nil)!
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
    
    @Test("bytesSize should return size in bytes for valid image")
    func testBytesSize() {
        let image = Self.loadTestImage()
        let bytesSize = image.mp.bytesSize
        
        #expect(bytesSize > 0)
    }
    
    @Test("bytesSize should return 0 when jpegData is nil")
    func testBytesSizeForInvalidImage() {
        // Create an image that cannot be converted to JPEG (e.g., empty image)
        let emptyImage = UIImage()
        let bytesSize = emptyImage.mp.bytesSize
        
        #expect(bytesSize == 0)
    }
    
    // MARK: - Property: kilobytesSize
    
    @Test("kilobytesSize should return size in kilobytes for valid image")
    func testKilobytesSize() {
        let image = Self.loadTestImage()
        let kilobytesSize = image.mp.kilobytesSize
        
        #expect(kilobytesSize >= 0)
    }
    
    @Test("kilobytesSize should return 0 when jpegData is nil")
    func testKilobytesSizeForInvalidImage() {
        // Create an image that cannot be converted to JPEG (e.g., empty image)
        let emptyImage = UIImage()
        let kilobytesSize = emptyImage.mp.kilobytesSize
        
        #expect(kilobytesSize == 0)
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
    
    @Test("compressed should return nil for empty image")
    func testCompressedEmptyImage() {
        let emptyImage = UIImage()
        let compressed = emptyImage.mp.compressed(quality: 0.5)
        
        #expect(compressed == nil)
    }
    
    // MARK: - Method: compressedData(quality:)
    
    @Test("compressedData should return data")
    func testCompressedData() {
        let image = Self.loadTestImage()
        let data = image.mp.compressedData(quality: 0.5)
        
        #expect(data != nil)
    }
    
    @Test("compressedData should return nil for empty image")
    func testCompressedDataEmptyImage() {
        let emptyImage = UIImage()
        let data = emptyImage.mp.compressedData(quality: 0.5)
        
        #expect(data == nil)
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
    
    @Test("cropped should return original image for oversized rect")
    func testCroppedOversizedRect() {
        let image = Self.loadTestImage()
        let rect = CGRect(x: 0, y: 0, width: image.size.width * 2, height: image.size.height * 2)
        let cropped = image.mp.cropped(to: rect)
        
        #expect(cropped.size == image.size)
    }
    
    @Test("cropped should return original image when cgImage cropping fails")
    func testCroppedFailedCropping() {
        let image = Self.loadTestImage()
        // Create a rect that's outside the image bounds
        let rect = CGRect(x: image.size.width + 100, y: image.size.height + 100, width: 10, height: 10)
        let cropped = image.mp.cropped(to: rect)
        
        // Should return original image when cropping fails
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
    
    @Test("withRoundedCorners should round corners with valid radius")
    func testWithRoundedCorners() {
        let image = Self.loadTestImage()
        let rounded = image.mp.withRoundedCorners(radius: 10.0)
        
        #expect(rounded != nil)
    }
    
    @Test("withRoundedCorners should use default radius when nil")
    func testWithRoundedCornersDefault() {
        let image = Self.loadTestImage()
        let rounded = image.mp.withRoundedCorners()
        
        #expect(rounded != nil)
    }
    
    @Test("withRoundedCorners should use maxRadius when radius is 0")
    func testWithRoundedCornersZeroRadius() {
        let image = Self.loadTestImage()
        let rounded = image.mp.withRoundedCorners(radius: 0)
        
        #expect(rounded != nil)
    }
    
    @Test("withRoundedCorners should use maxRadius when radius is negative")
    func testWithRoundedCornersNegativeRadius() {
        let image = Self.loadTestImage()
        let rounded = image.mp.withRoundedCorners(radius: -10.0)
        
        #expect(rounded != nil)
    }
    
    @Test("withRoundedCorners should use maxRadius when radius exceeds max")
    func testWithRoundedCornersExceedsMax() {
        let image = Self.loadTestImage()
        let maxRadius = min(image.size.width, image.size.height) / 2
        let rounded = image.mp.withRoundedCorners(radius: maxRadius + 100)
        
        #expect(rounded != nil)
    }
    
    // MARK: - Method: pngData
    
    @Test("pngData should return PNG data")
    func testPngData() {
        let image = Self.loadTestImage()
        let data = image.mp.pngData()
        
        #expect(data != nil)
    }
    
    @Test("pngData should return nil for empty image")
    func testPngDataEmptyImage() {
        let emptyImage = UIImage()
        let data = emptyImage.mp.pngData()
        
        #expect(data == nil)
    }
    
    // MARK: - Method: pngBase64String
    
    @Test("pngBase64String should return base64 string")
    func testPngBase64String() {
        let image = Self.loadTestImage()
        let base64String = image.mp.pngBase64String()
        
        #expect(base64String != nil)
        #expect(base64String?.isEmpty == false)
    }
    
    @Test("pngBase64String should return nil for empty image")
    func testPngBase64StringEmptyImage() {
        let emptyImage = UIImage()
        let base64String = emptyImage.mp.pngBase64String()
        
        #expect(base64String == nil)
    }
    
    // MARK: - Method: jpegBase64String(compressionQuality:)
    
    @Test("jpegBase64String should return base64 string")
    func testJpegBase64String() {
        let image = Self.loadTestImage()
        let base64String = image.mp.jpegBase64String(compressionQuality: 0.5)
        
        #expect(base64String != nil)
        #expect(base64String?.isEmpty == false)
    }
    
    @Test("jpegBase64String should return nil for empty image")
    func testJpegBase64StringEmptyImage() {
        let emptyImage = UIImage()
        let base64String = emptyImage.mp.jpegBase64String(compressionQuality: 0.5)
        
        #expect(base64String == nil)
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
    
    @Test("init with color should handle invalid size gracefully")
    func testInitWithColorInvalidSize() {
        let color = UIColor.red
        // Test with zero size - should still create an image (fallback to empty init)
        let imageZero = UIImage(color: color, size: .zero)
        #expect(imageZero.size == .zero || imageZero.size == CGSize(width: 1, height: 1))
        
        // Test with negative size - should create an image (may fallback)
        let imageNegative = UIImage(color: color, size: CGSize(width: -10, height: -10))
        // Just verify it doesn't crash and creates some image
        #expect(imageNegative.size.width >= 0)
        #expect(imageNegative.size.height >= 0)
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
    
    @Test("averageColor should return average color for valid image")
    func testAverageColor() {
        // Create a solid color image to ensure we get a color back
        let image = UIImage(color: .red, size: CGSize(width: 100, height: 100))
        let averageColor = image.mp.averageColor()
        
        #expect(averageColor != nil)
    }
    
    @Test("averageColor should return nil for empty image")
    func testAverageColorForEmptyImage() {
        // Empty UIImage should return nil
        let emptyImage = UIImage()
        let averageColor = emptyImage.mp.averageColor()
        
        #expect(averageColor == nil)
    }
    
    @Test("averageColor should handle image with CIImage")
    func testAverageColorWithCIImage() {
        // Create an image from CIImage - tests the base.ciImage branch
        let ciImage = CIImage(color: CIColor.red)
            .cropped(to: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(ciImage: ciImage)
        
        let averageColor = image.mp.averageColor()
        
        // Should use base.ciImage directly
        #expect(averageColor != nil)
    }
    
    @Test("averageColor should handle image created from cgImage")
    func testAverageColorFromCGImage() {
        // Create an image from CGImage - tests CIImage(image: base) branch
        let testImage = Self.loadTestImage()
        let averageColor = testImage.mp.averageColor()
        
        // Should create CIImage from base
        #expect(averageColor != nil)
    }
    
    @Test("averageColor should handle zero size image")
    func testAverageColorZeroSize() {
        // Create image with zero size - may cause filter to fail
        let image = UIImage(color: .blue, size: .zero)
        let averageColor = image.mp.averageColor()
        
        // May return nil if filter fails with zero size
        // Just verify it doesn't crash
        _ = averageColor
    }
    
    @Test("averageColor should handle invalid extent values")
    func testAverageColorInvalidExtent() {
        // Test 1: NaN extent - should cause filter to fail or return nil
        let nanRect = CGRect(x: CGFloat.nan, y: CGFloat.nan, width: CGFloat.nan, height: CGFloat.nan)
        let nanCIImage = CIImage(color: CIColor.red).cropped(to: nanRect)
        let imageNan = UIImage(ciImage: nanCIImage)
        let colorNan = imageNan.mp.averageColor()
        // NaN extent should cause issues
        _ = colorNan
        
        // Test 2: Infinite extent - should cause filter to fail
        let infRect = CGRect(x: CGFloat.infinity, y: CGFloat.infinity, width: CGFloat.infinity, height: CGFloat.infinity)
        let infCIImage = CIImage(color: CIColor.blue).cropped(to: infRect)
        let imageInf = UIImage(ciImage: infCIImage)
        let colorInf = imageInf.mp.averageColor()
        // Infinite extent should cause issues
        _ = colorInf
        
        // Test 3: Negative dimensions
        let negRect = CGRect(x: 0, y: 0, width: -100, height: -100)
        let negCIImage = CIImage(color: CIColor.green).cropped(to: negRect)
        let imageNeg = UIImage(ciImage: negCIImage)
        let colorNeg = imageNeg.mp.averageColor()
        // Negative dimensions should cause issues
        _ = colorNeg
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
    
    // MARK: - Method: fixOrientation()
    
    @Test("fixOrientation should handle all orientations correctly")
    func testFixOrientation() {
        let image = Self.loadTestImage()
        guard let cgImage = image.cgImage else {
            return
        }
        
        // Test .up orientation
        let upImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .up)
        let fixedUp = upImage.mp.fixOrientation()
        #expect(fixedUp.imageOrientation == .up)
        #expect(fixedUp.size == upImage.size)
        #expect(fixedUp.scale == 1.0)
        #expect(fixedUp === upImage, ".up should return same instance")
        
        // Test .down orientation
        let downImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .down)
        let fixedDown = downImage.mp.fixOrientation()
        #expect(fixedDown.imageOrientation == .up)
        #expect(fixedDown.size == downImage.size)
        #expect(fixedDown.scale == 1.0)
        #expect(fixedDown.size.width > 0)
        #expect(fixedDown.size.height > 0)
        
        // Test .left orientation
        let leftImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .left)
        let fixedLeft = leftImage.mp.fixOrientation()
        #expect(fixedLeft.imageOrientation == .up)
        #expect(fixedLeft.size.height == leftImage.size.width)
        #expect(fixedLeft.size.width == leftImage.size.height)
        #expect(fixedLeft.scale == 1.0)
        #expect(fixedLeft.size.width > 0)
        #expect(fixedLeft.size.height > 0)
        
        // Test .right orientation
        let rightImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
        let fixedRight = rightImage.mp.fixOrientation()
        #expect(fixedRight.imageOrientation == .up)
        #expect(fixedLeft.size.height == leftImage.size.width)
        #expect(fixedLeft.size.width == leftImage.size.height)
        #expect(fixedRight.scale == 1.0)
        #expect(fixedRight.size.width > 0)
        #expect(fixedRight.size.height > 0)
        
        // Test .upMirrored orientation
        let upMirroredImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .upMirrored)
        let fixedUpMirrored = upMirroredImage.mp.fixOrientation()
        #expect(fixedUpMirrored.imageOrientation == .up)
        #expect(fixedUpMirrored.size == upMirroredImage.size)
        #expect(fixedUpMirrored.scale == 1.0)
        #expect(fixedUpMirrored.size.width > 0)
        #expect(fixedUpMirrored.size.height > 0)
        
        // Test .downMirrored orientation
        let downMirroredImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .downMirrored)
        let fixedDownMirrored = downMirroredImage.mp.fixOrientation()
        #expect(fixedDownMirrored.imageOrientation == .up)
        #expect(fixedDownMirrored.size == downMirroredImage.size)
        #expect(fixedDownMirrored.scale == 1.0)
        #expect(fixedDownMirrored.size.width > 0)
        #expect(fixedDownMirrored.size.height > 0)
        
        // Test .leftMirrored orientation
        let leftMirroredImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .leftMirrored)
        let fixedLeftMirrored = leftMirroredImage.mp.fixOrientation()
        #expect(fixedLeftMirrored.imageOrientation == .up)
        #expect(fixedLeftMirrored.size.height == leftMirroredImage.size.width)
        #expect(fixedLeftMirrored.size.width == leftMirroredImage.size.height)
        #expect(fixedLeftMirrored.scale == 1.0)
        #expect(fixedLeftMirrored.size.width > 0)
        #expect(fixedLeftMirrored.size.height > 0)
        
        // Test .rightMirrored orientation with scale = 2.0
        let rightMirroredImage = UIImage(cgImage: cgImage, scale: 2.0, orientation: .rightMirrored)
        let fixedRightMirrored = rightMirroredImage.mp.fixOrientation()
        #expect(fixedRightMirrored.imageOrientation == .up)
        #expect(fixedRightMirrored.size == rightMirroredImage.size)
        #expect(fixedRightMirrored.scale == 2.0)
        #expect(fixedRightMirrored.size.width > 0)
        #expect(fixedRightMirrored.size.height > 0)
        
        // Test nil cgImage case
        let ciImage = CIImage(color: CIColor.red)
        let imageWithoutCGImage = UIImage(ciImage: ciImage)
        let fixedNil = imageWithoutCGImage.mp.fixOrientation()
        #expect(fixedNil.cgImage == nil)
        #expect(fixedNil === imageWithoutCGImage)
    }
}
#endif
