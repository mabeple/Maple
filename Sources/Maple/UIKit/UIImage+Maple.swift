//
//  UIImage+Maple.swift
//  Maple
//
//  Created by cy on 2020/11/16.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
extension UIImage: MabpleCompatible { }

// MARK: - Properties
public extension MabpleWrapper where Base == UIImage {
    
    /// Size in bytes of UIImage
    var bytesSize: Int {
        base.jpegData(compressionQuality: 1)?.count ?? 0
    }

    /// Size in kilo bytes of UIImage
    var kilobytesSize: Int {
        (base.jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }

    /// UIImage with .alwaysOriginal rendering mode.
    var original: UIImage {
        base.withRenderingMode(.alwaysOriginal)
    }

    /// UIImage with .alwaysTemplate rendering mode.
    var template: UIImage {
        base.withRenderingMode(.alwaysTemplate)
    }
}

// MARK: - Methods
public extension MabpleWrapper where Base == UIImage {
    
    #if canImport(CoreImage)
    /// Average color for this image.
    func averageColor() -> UIColor? {
        // https://stackoverflow.com/questions/26330924
        guard let ciImage = base.ciImage ?? CIImage(image: base) else { return nil }

        // CIAreaAverage returns a single-pixel image that contains the average color for a given region of an image.
        let parameters = [kCIInputImageKey: ciImage, kCIInputExtentKey: CIVector(cgRect: ciImage.extent)]
        guard let outputImage = CIFilter(name: "CIAreaAverage", parameters: parameters)?.outputImage else {
            return nil
        }

        // After getting the single-pixel image from the filter extract pixel's RGBA8 data
        var bitmap = [UInt8](repeating: 0, count: 4)
        let workingColorSpace: Any = base.cgImage?.colorSpace ?? NSNull()
        let context = CIContext(options: [.workingColorSpace: workingColorSpace])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        // Convert pixel data to UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: CGFloat(bitmap[3]) / 255.0)
    }
    #endif
    
    /// Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = base.jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    /// Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return base.jpegData(compressionQuality: quality)
    }
    
    /// UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= base.size.width, rect.size.height <= base.size.height else { return base }
        let scaledRect = rect.applying(CGAffineTransform(scaleX: base.scale, y: base.scale))
        guard let image = base.cgImage?.cropping(to: scaledRect) else { return base }
        return UIImage(cgImage: image, scale: base.scale, orientation: base.imageOrientation)
    }
    
    /// UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / base.size.height
        let newWidth = base.size.width * scale
        let size = CGSize(width: newWidth, height: toHeight)
        let rect = CGRect(origin: .zero, size: size)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, opaque, base.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            base.draw(in: rect)
        }
        #endif
    }
    
    /// UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / base.size.width
        let newHeight = base.size.height * scale
        let size = CGSize(width: toWidth, height: newHeight)
        let rect = CGRect(origin: .zero, size: size)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, opaque, base.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            base.draw(in: rect)
        }
        #endif
    }
    
    /// Creates a copy of the receiver rotated by the given angle (in radians).
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    ///
    /// - Parameter radians: The angle, in radians, by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: base.size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        let actions = { (contextRef: CGContext) in
            contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
            contextRef.rotate(by: radians)

            base.draw(in: CGRect(origin: CGPoint(x: -base.size.width / 2,
                                                 y: -base.size.height / 2),
                                 size: base.size))
        }

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(roundedDestRect.size, false, base.scale)
        defer { UIGraphicsEndImageContext() }
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        actions(contextRef)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        return UIGraphicsImageRenderer(size: roundedDestRect.size, format: format).image {
            actions($0.cgContext)
        }
        #endif
    }
    
    /// UIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    func filled(withColor color: UIColor) -> UIImage {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        context.translateBy(x: 0, y: base.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        let renderer = UIGraphicsImageRenderer(size: base.size, format: format)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: base.size))
        }
        #endif
    }
    
    /// UIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    func tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: base.size)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        return UIGraphicsImageRenderer(size: base.size, format: format).image { context in
            color.setFill()
            context.fill(drawRect)
            base.draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        }
        #endif
    }

    /// UImage with background color
    ///
    /// - Parameters:
    ///   - backgroundColor: Color to use as background color
    /// - Returns: UIImage with a background color that is visible where alpha < 1
    func withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        defer { UIGraphicsEndImageContext() }
        
        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: base.size))
        draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        return UIGraphicsImageRenderer(size: base.size, format: format).image { context in
            backgroundColor.setFill()
            context.fill(context.format.bounds)
            base.draw(at: .zero)
        }
        #endif
    }

    /// UIImage with rounded corners
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(base.size.width, base.size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0, radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        let actions = {
            let rect = CGRect(origin: .zero, size: base.size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            base.draw(in: rect)
        }

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        defer { UIGraphicsEndImageContext() }
        actions()
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = base.scale
        return UIGraphicsImageRenderer(size: base.size, format: format).image { _ in
            actions()
        }
        #endif
    }
    
    /// PNG data of the image.
    ///
    /// - Returns: PNG data of the image.
    func pngData() -> Data? {
        base.pngData()
    }
    
    /// Base 64 encoded PNG data of the image.
    ///
    /// - returns: Base 64 encoded PNG data of the image as a String.
    func pngBase64String() -> String? {
        base.pngData()?.base64EncodedString()
    }

    /// Base 64 encoded JPEG data of the image.
    ///
    /// - parameter compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    /// - returns: Base 64 encoded JPEG data of the image as a String.
    func jpegBase64String(compressionQuality: CGFloat) -> String? {
        base.jpegData(compressionQuality: compressionQuality)?.base64EncodedString()
    }
    
    /// UIImage with color uses .alwaysOriginal rendering mode.
    ///
    /// - Parameters:
    ///   - color: Color of image.
    /// - Returns: UIImage with color.
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func withAlwaysOriginalTintColor(_ color: UIColor) -> UIImage {
        base.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}

// MARK: - Initializers
public extension UIImage {
    
    /// Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        guard let image = UIGraphicsImageRenderer(size: size, format: format).image(actions: { context in
            color.setFill()
            context.fill(context.format.bounds)
        }).cgImage else {
            self.init()
            return
        }
        self.init(cgImage: image)
        #endif
    }
    
    /// Create a new image from a base 64 string.
    ///
    ///
    /// - Parameters:
    ///   - base64String: a base-64 `String`, representing the image
    ///   - scale: The scale factor to assume when interpreting the image data created from the base-64 string. Applying a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }
}

#endif
