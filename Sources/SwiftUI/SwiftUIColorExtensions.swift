//
//  SwiftUIColorExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/21.
//

#if canImport(SwiftUI)
import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

#if !os(watchOS)
import CoreImage
#endif

extension SwiftUI.Color: MapleCompatibleValue { }

// MARK: - Properties

public extension MapleWrapper where Base == SwiftUI.Color {
    
    /// Convert SwiftUI Color to platform color (UIColor/NSColor)
    private var platformColor: MPCrossPlatformColor {
        #if canImport(UIKit)
        return UIColor(base)
        #elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
        return NSColor(base)
        #else
        fatalError("Unsupported platform")
        #endif
    }
    
    /// RGB components for a Color (between 0 and 255).
    ///
    ///     Color.red.mp.rgbComponents.red -> 255
    ///     Color.green.mp.rgbComponents.green -> 255
    ///     Color.blue.mp.rgbComponents.blue -> 255
    ///
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        platformColor.mp.rgbComponents
    }
    
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1).
    ///
    ///     Color.red.mp.cgFloatComponents.red -> 1.0
    ///     Color.green.mp.cgFloatComponents.green -> 1.0
    ///     Color.blue.mp.cgFloatComponents.blue -> 1.0
    ///
    var cgFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        platformColor.mp.cgFloatComponents
    }
    
    /// Get components of hue, saturation, and brightness, and alpha (read-only).
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        platformColor.mp.hsbaComponents
    }
    
    /// Hexadecimal value string (read-only).
    var hexString: String {
        platformColor.mp.hexString
    }
    
    /// Short hexadecimal value string (read-only, if applicable).
    var shortHexString: String? {
        platformColor.mp.shortHexString
    }
    
    /// Short hexadecimal value string, or full hexadecimal string if not possible (read-only).
    var shortHexOrHexString: String {
        platformColor.mp.shortHexOrHexString
    }
    
    /// Alpha of Color (read-only)
    var alpha: CGFloat {
        platformColor.mp.alpha
    }
    
    /// Relative luminance of the color using the WCAG formula.
    var luminance: CGFloat {
        let components = cgFloatComponents
        let convert: (CGFloat) -> CGFloat = { component in
            if component <= 0.03928 {
                return component / 12.92
            }
            return CGFloat(pow((Double(component) + 0.055) / 1.055, 2.4))
        }
        
        let red = convert(components.red)
        let green = convert(components.green)
        let blue = convert(components.blue)
        return (0.2126 * red) + (0.7152 * green) + (0.0722 * blue)
    }
    
    /// Whether the color reads as light against a dark foreground.
    var isLight: Bool {
        luminance >= 0.6
    }
    
    #if !os(watchOS)
    /// CoreImage.CIColor (read-only).
    var coreImageColor: CoreImage.CIColor? {
        platformColor.mp.coreImageColor
    }
    #endif
    
    /// Get UInt representation of a Color (read-only).
    var uInt: UInt {
        platformColor.mp.uInt
    }
    
    /// Lighten a color
    ///
    ///     let color = Color.red
    ///     let lighterColor: Color = color.mp.lighten(by: 0.2)
    ///
    /// - Parameter percentage: Percentage by which to lighten the color
    /// - Returns: A lightened color
    func lighten(by percentage: CGFloat = 0.2) -> SwiftUI.Color {
        SwiftUI.Color(platformColor.mp.lighten(by: percentage))
    }
    
    /// Darken a color
    ///
    ///     let color = Color.red
    ///     let darkerColor: Color = color.mp.darken(by: 0.2)
    ///
    /// - Parameter percentage: Percentage by which to darken the color
    /// - Returns: A darkened color
    func darken(by percentage: CGFloat = 0.2) -> SwiftUI.Color {
        SwiftUI.Color(platformColor.mp.darken(by: percentage))
    }
    
    /// Returns a foreground color that contrasts with the receiver.
    ///
    /// - Parameters:
    ///   - light: The color returned for dark backgrounds.
    ///   - dark: The color returned for light backgrounds.
    /// - Returns: Either `light` or `dark` depending on the receiver's luminance.
    func contrastingColor(light: Color = .white, dark: Color = .black) -> SwiftUI.Color {
        isLight ? dark : light
    }
    
    /// Returns the same color with a new alpha value.
    ///
    /// - Parameter alpha: The alpha value to apply.
    /// - Returns: A color with the provided alpha.
    func withAlpha(_ alpha: CGFloat) -> SwiftUI.Color {
        let clampedAlpha = min(max(alpha, 0), 1)
        return SwiftUI.Color(platformColor.withAlphaComponent(clampedAlpha))
    }
    
    /// Blends the color with another color by the given amount.
    ///
    /// - Parameters:
    ///   - color: The color to blend with.
    ///   - amount: The blend amount between `0` and `1`.
    /// - Returns: The blended color.
    func blended(with color: Color, amount: CGFloat) -> SwiftUI.Color {
        let clampedAmount = min(max(amount, 0), 1)
        let targetColor = MPCrossPlatformColor(color)
        let source = platformColor.mp.cgFloatComponents
        let target = targetColor.mp.cgFloatComponents
        let blendedAlpha = alpha + ((targetColor.mp.alpha - alpha) * clampedAmount)
        let blendedColor = MPCrossPlatformColor(
            red: source.red + ((target.red - source.red) * clampedAmount),
            green: source.green + ((target.green - source.green) * clampedAmount),
            blue: source.blue + ((target.blue - source.blue) * clampedAmount),
            alpha: blendedAlpha
        )
        return SwiftUI.Color(blendedColor)
    }
}

// MARK: - Initializers
public extension SwiftUI.Color {
    
    /// Create Color from RGB values with optional opacity and color space.
    ///
    ///     let color1 = Color(red: 255, green: 100, blue: 50)
    ///     let color2 = Color(.displayP3, red: 255, green: 100, blue: 50, opacity: 0.8)
    ///
    /// - Parameters:
    ///   - colorSpace: The RGB color space to use (default is .sRGB).
    ///   - red: Red component (0-255).
    ///   - green: Green component (0-255).
    ///   - blue: Blue component (0-255).
    ///   - opacity: Opacity value (0.0-1.0, default is 1.0).
    init(_ colorSpace: Color.RGBColorSpace = .sRGB, red: Int, green: Int, blue: Int, opacity: Double = 1) {
        let r = Double(max(0, min(255, red))) / 255.0
        let g = Double(max(0, min(255, green))) / 255.0
        let b = Double(max(0, min(255, blue))) / 255.0
        let o = max(0, min(1, opacity))
        self.init(colorSpace, red: r, green: g, blue: b, opacity: o)
    }
    
    /// Create Color from hexadecimal value with optional opacity and color space.
    ///
    ///     let color1 = Color(hex: 0xDECEB5)
    ///     let color2 = Color(.displayP3, hex: 0xFF6432, opacity: 0.8)
    ///
    /// - Parameters:
    ///   - colorSpace: The RGB color space to use (default is .sRGB).
    ///   - hex: Hexadecimal integer value (example: 0xDECEB5).
    ///   - opacity: Opacity value (0.0-1.0, default is 1.0).
    init(_ colorSpace: Color.RGBColorSpace = .sRGB, hex: Int, opacity: Double = 1) {
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(colorSpace, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    /// Create Color from hexadecimal string with optional opacity and color space.
    ///
    ///     let color1 = Color(hexString: "#FF6432")
    ///     let color2 = Color(.displayP3, hexString: "0xEDE7F6", opacity: 0.8)
    ///     let color3 = Color(hexString: "#0ff")  // Short format
    ///
    /// - Parameters:
    ///   - colorSpace: The RGB color space to use (default is .sRGB).
    ///   - hexString: Hexadecimal string (examples: "EDE7F6", "0xEDE7F6", "#EDE7F6", "#0ff").
    ///   - opacity: Opacity value (0.0-1.0, default is 1.0).
    init?(_ colorSpace: Color.RGBColorSpace = .sRGB, hexString: String, opacity: Double = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string = hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        self.init(colorSpace, hex: hexValue, opacity: opacity)
    }
    
    /// Create a dynamic color that adapts to light and dark mode.
    ///
    ///     let dynamicColor = Color(light: .white, dark: .black)
    ///     let customColor = Color(
    ///         light: Color(red: 255, green: 255, blue: 255),
    ///         dark: Color(red: 0, green: 0, blue: 0)
    ///     )
    ///
    /// - Parameters:
    ///   - light: Color to use in light mode.
    ///   - dark: Color to use in dark mode.
    init(light: Color, dark: Color) {
        let lightPlatformColor = MPCrossPlatformColor(light)
        let darkPlatformColor = MPCrossPlatformColor(dark)
        let dynamicColor = MPCrossPlatformColor(light: lightPlatformColor, dark: darkPlatformColor)
        self.init(dynamicColor)
    }
    
    /// Generate a random color.
    ///
    ///     let color1 = Color.random
    ///     let color2 = Color.random()
    ///     let color3 = Color.random(.displayP3)
    ///
    /// - Parameter colorSpace: The RGB color space to use (default is .sRGB).
    /// - Returns: A random color.
    static func random(_ colorSpace: Color.RGBColorSpace = .sRGB) -> SwiftUI.Color {
        SwiftUI.Color(colorSpace,
                      red: .random(in: 0...255),
                      green: .random(in: 0...255),
                      blue: .random(in: 0...255))
    }
    
    /// Random color (computed property for convenience).
    ///
    ///     let color = Color.random
    ///
    static var random: SwiftUI.Color {
        random()
    }
}

// MARK: - Cross-Platform Conversion
public extension MapleWrapper where Base == MPCrossPlatformColor {
    
    /// Convert to SwiftUI Color
    var color: SwiftUI.Color {
        SwiftUI.Color(base)
    }
}

#endif
