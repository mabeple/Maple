//
//  ColorExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if !os(Linux)

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

import CoreGraphics
import Testing
@testable import Maple

@Suite("Color Extensions Test Suite")
struct ColorExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("MPCrossPlatformColor should conform to MapleCompatibleValue")
    func testColorConformsToMapleCompatibleValue() {
        let color = MPCrossPlatformColor.red
        let wrapper = color.mp
        #expect(wrapper.base == color)
    }
    
    // MARK: - Property: rgbComponents
    
    @Test("rgbComponents should return RGB components as Int")
    func testRgbComponents() {
        let red = MPCrossPlatformColor.red
        let redComponents = red.mp.rgbComponents
        #expect(redComponents.red == 255)
        #expect(redComponents.green == 0)
        #expect(redComponents.blue == 0)
        
        let green = MPCrossPlatformColor.green
        let greenComponents = green.mp.rgbComponents
        #expect(greenComponents.red == 0)
        #expect(greenComponents.green == 255)
        #expect(greenComponents.blue == 0)
        
        let blue = MPCrossPlatformColor.blue
        let blueComponents = blue.mp.rgbComponents
        #expect(blueComponents.red == 0)
        #expect(blueComponents.green == 0)
        #expect(blueComponents.blue == 255)
        
        // Test grayscale color (2 components) to cover the else branch
        #if canImport(UIKit)
        let grayColor = UIColor(white: 0.5, alpha: 1.0)
        #elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
        let grayColor = NSColor(white: 0.5, alpha: 1.0)
        #endif
        let grayComponents = grayColor.mp.rgbComponents
        // For grayscale, all RGB components should be the same
        #expect(grayComponents.red == grayComponents.green)
        #expect(grayComponents.green == grayComponents.blue)
    }
    
    // MARK: - Property: cgFloatComponents
    
    @Test("cgFloatComponents should return RGB components as CGFloat")
    func testCgFloatComponents() {
        let red = MPCrossPlatformColor.red
        let redComponents = red.mp.cgFloatComponents
        #expect(abs(redComponents.red - 1.0) < 0.0001)
        #expect(abs(redComponents.green - 0.0) < 0.0001)
        #expect(abs(redComponents.blue - 0.0) < 0.0001)
        
        let white = MPCrossPlatformColor.white
        let whiteComponents = white.mp.cgFloatComponents
        #expect(abs(whiteComponents.red - 1.0) < 0.0001)
        #expect(abs(whiteComponents.green - 1.0) < 0.0001)
        #expect(abs(whiteComponents.blue - 1.0) < 0.0001)
    }
    
    // MARK: - Property: hsbaComponents
    
    @Test("hsbaComponents should return HSBA components")
    func testHsbaComponents() {
        let color = MPCrossPlatformColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.8)
        let components = color.mp.hsbaComponents
        #expect(components.alpha == 0.8)
        #expect(components.hue >= 0.0 && components.hue <= 1.0)
        #expect(components.saturation >= 0.0 && components.saturation <= 1.0)
        #expect(components.brightness >= 0.0 && components.brightness <= 1.0)
    }
    
    // MARK: - Property: hexString
    
    @Test("hexString should return hexadecimal string")
    func testHexString() {
        let red = MPCrossPlatformColor.red
        let hex = red.mp.hexString
        #expect(hex.hasPrefix("#"))
        #expect(hex.count == 7)
        
        let green = MPCrossPlatformColor.green
        let greenHex = green.mp.hexString
        #expect(greenHex.hasPrefix("#"))
        #expect(greenHex.count == 7)
        
        let blue = MPCrossPlatformColor.blue
        let blueHex = blue.mp.hexString
        #expect(blueHex.hasPrefix("#"))
        #expect(blueHex.count == 7)
        
        // Test grayscale color (2 components) to cover the else branch
        #if canImport(UIKit)
        let grayColor = UIColor(white: 0.5, alpha: 1.0)
        #elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
        let grayColor = NSColor(white: 0.5, alpha: 1.0)
        #endif
        let grayHex = grayColor.mp.hexString
        #expect(grayHex.hasPrefix("#"))
        #expect(grayHex.count == 7)
    }
    
    // MARK: - Property: shortHexString
    
    @Test("shortHexString should return short hexadecimal string when applicable")
    func testShortHexString() {
        // Test with color that can be shortened (e.g., #FF0000 -> #F00)
        let red = MPCrossPlatformColor.red
        let shortHex = red.mp.shortHexString
        #expect(shortHex != nil)
        if let hex = shortHex {
            #expect(hex.hasPrefix("#"))
            #expect(hex.count == 4)
        }
        
        // Test with color that cannot be shortened
        let customColor = MPCrossPlatformColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1.0)
        let customShortHex = customColor.mp.shortHexString
        // For colors that cannot be shortened, shortHexString returns nil
        // The hex representation would be something like #8033B3, which cannot be shortened
        #expect(customShortHex == nil)
    }
    
    // MARK: - Property: shortHexOrHexString
    
    @Test("shortHexOrHexString should return short or full hexadecimal string")
    func testShortHexOrHexString() {
        let red = MPCrossPlatformColor.red
        let hex = red.mp.shortHexOrHexString
        #expect(hex.hasPrefix("#"))
        #expect(hex.count == 4 || hex.count == 7)
        
        let customColor = MPCrossPlatformColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1.0)
        let customHex = customColor.mp.shortHexOrHexString
        #expect(customHex.hasPrefix("#"))
        #expect(customHex.count == 4 || customHex.count == 7)
    }
    
    // MARK: - Property: alpha
    
    @Test("alpha should return alpha component")
    func testAlpha() {
        let opaqueColor = MPCrossPlatformColor.red
        #expect(opaqueColor.mp.alpha == 1.0)
        
        let transparentColor = MPCrossPlatformColor.red.withAlphaComponent(0.5)
        #expect(abs(transparentColor.mp.alpha - 0.5) < 0.0001)
    }
    
    #if !os(watchOS)
    // MARK: - Property: coreImageColor
    
    @Test("coreImageColor should return CoreImage.CIColor")
    func testCoreImageColor() {
        let color = MPCrossPlatformColor.red
        let ciColor = color.mp.coreImageColor
        #expect(ciColor != nil)
    }
    #endif
    
    // MARK: - Property: uInt
    
    @Test("uInt should return UInt representation")
    func testUInt() {
        let red = MPCrossPlatformColor.red
        let uintValue = red.mp.uInt
        #expect(uintValue > 0)
        
        let green = MPCrossPlatformColor.green
        let greenUInt = green.mp.uInt
        #expect(greenUInt > 0)
        #expect(greenUInt != uintValue)
    }
    
    // MARK: - Method: lighten(by:)
    
    @Test("lighten should lighten color by percentage")
    func testLighten() {
        let color = MPCrossPlatformColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let lightened = color.mp.lighten(by: 0.2)
        let lightenedComponents = lightened.mp.cgFloatComponents
        #expect(lightenedComponents.red > 0.5)
        #expect(lightenedComponents.green > 0.5)
        #expect(lightenedComponents.blue > 0.5)
        
        // Test with default percentage
        let lightenedDefault = color.mp.lighten()
        let defaultComponents = lightenedDefault.mp.cgFloatComponents
        #expect(defaultComponents.red > 0.5)
    }
    
    // MARK: - Method: darken(by:)
    
    @Test("darken should darken color by percentage")
    func testDarken() {
        let color = MPCrossPlatformColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let darkened = color.mp.darken(by: 0.2)
        let darkenedComponents = darkened.mp.cgFloatComponents
        #expect(darkenedComponents.red < 0.5)
        #expect(darkenedComponents.green < 0.5)
        #expect(darkenedComponents.blue < 0.5)
        
        // Test with default percentage
        let darkenedDefault = color.mp.darken()
        let defaultComponents = darkenedDefault.mp.cgFloatComponents
        #expect(defaultComponents.red < 0.5)
    }
    
    // MARK: - Initializer: init(red:green:blue:transparency:)
    
    @Test("init(red:green:blue:transparency:) should create color from RGB values")
    func testInitWithRGB() {
        let color = MPCrossPlatformColor(red: 255, green: 128, blue: 64, transparency: 0.8)
        let components = color.mp.cgFloatComponents
        #expect(abs(components.red - 1.0) < 0.01)
        #expect(abs(components.green - 0.5) < 0.01)
        #expect(abs(components.blue - 0.25) < 0.01)
        #expect(abs(color.mp.alpha - 0.8) < 0.0001)
        
        // Test with default transparency
        let color2 = MPCrossPlatformColor(red: 100, green: 200, blue: 50)
        #expect(color2.mp.alpha == 1.0)
        
        // Test with invalid values (should clamp to 255)
        let color3 = MPCrossPlatformColor(red: 300, green: -10, blue: 500)
        let components3 = color3.mp.rgbComponents
        #expect(components3.red == 255)
        #expect(components3.green == 255)
        #expect(components3.blue == 255)
        
        // Test with invalid transparency values (should clamp)
        let color4 = MPCrossPlatformColor(red: 100, green: 200, blue: 50, transparency: -0.5)
        #expect(color4.mp.alpha == 0.0)
        
        let color5 = MPCrossPlatformColor(red: 100, green: 200, blue: 50, transparency: 1.5)
        #expect(color5.mp.alpha == 1.0)
    }
    
    // MARK: - Initializer: init(hex:transparency:)
    
    @Test("init(hex:transparency:) should create color from hex Int")
    func testInitWithHex() {
        // Test with red color (0xFF0000)
        let red = MPCrossPlatformColor(hex: 0xFF0000)
        let redComponents = red.mp.rgbComponents
        #expect(redComponents.red == 255)
        #expect(redComponents.green == 0)
        #expect(redComponents.blue == 0)
        
        // Test with green color (0x00FF00)
        let green = MPCrossPlatformColor(hex: 0x00FF00)
        let greenComponents = green.mp.rgbComponents
        #expect(greenComponents.red == 0)
        #expect(greenComponents.green == 255)
        #expect(greenComponents.blue == 0)
        
        // Test with transparency
        let blue = MPCrossPlatformColor(hex: 0x0000FF, transparency: 0.5)
        #expect(abs(blue.mp.alpha - 0.5) < 0.0001)
        
        // Test with invalid transparency values (should clamp)
        let color1 = MPCrossPlatformColor(hex: 0xFF0000, transparency: -0.5)
        #expect(color1.mp.alpha == 0.0)
        
        let color2 = MPCrossPlatformColor(hex: 0xFF0000, transparency: 1.5)
        #expect(color2.mp.alpha == 1.0)
    }
    
    // MARK: - Initializer: init(hexString:transparency:)
    
    @Test("init(hexString:transparency:) should create color from hex string")
    func testInitWithHexString() {
        // Test with # prefix
        let color1 = MPCrossPlatformColor(hexString: "#FF0000")
        #expect(color1 != nil)
        if let c1 = color1 {
            #expect(c1.mp.rgbComponents.red == 255)
        }
        
        // Test with 0x prefix
        let color2 = MPCrossPlatformColor(hexString: "0xFF0000")
        #expect(color2 != nil)
        
        // Test without prefix
        let color3 = MPCrossPlatformColor(hexString: "FF0000")
        #expect(color3 != nil)
        
        // Test with short format (#F00)
        let color4 = MPCrossPlatformColor(hexString: "#F00")
        #expect(color4 != nil)
        
        // Test with invalid string
        let color5 = MPCrossPlatformColor(hexString: "INVALID")
        #expect(color5 == nil)
        
        // Test with transparency
        let color6 = MPCrossPlatformColor(hexString: "#FF0000", transparency: 0.5)
        #expect(color6 != nil)
        if let c6 = color6 {
            #expect(abs(c6.mp.alpha - 0.5) < 0.0001)
        }
        
        // Test with invalid transparency values (should clamp)
        let color7 = MPCrossPlatformColor(hexString: "#FF0000", transparency: -0.5)
        #expect(color7 != nil)
        if let c7 = color7 {
            #expect(c7.mp.alpha == 0.0)
        }
        
        let color8 = MPCrossPlatformColor(hexString: "#FF0000", transparency: 1.5)
        #expect(color8 != nil)
        if let c8 = color8 {
            #expect(c8.mp.alpha == 1.0)
        }
        
        // Test with 6-digit hex string (not 3-digit)
        let color9 = MPCrossPlatformColor(hexString: "ABCDEF")
        #expect(color9 != nil)
    }
    
    // MARK: - Initializer: init(light:dark:)
    
    @Test("init(light:dark:) should create color with light and dark variants")
    func testInitWithLightDark() {
        let lightColor = MPCrossPlatformColor.red
        let darkColor = MPCrossPlatformColor.blue
        let dynamicColor = MPCrossPlatformColor(light: lightColor, dark: darkColor)
        // The color should be valid
        #expect(dynamicColor.mp.alpha >= 0.0 && dynamicColor.mp.alpha <= 1.0)
    }
    
    // MARK: - Static Property: random
    
    @Test("random should return random color")
    func testRandom() {
        let color1 = MPCrossPlatformColor.random
        let color2 = MPCrossPlatformColor.random
        // Colors should be valid (alpha should be 1.0 for random)
        #expect(color1.mp.alpha == 1.0)
        #expect(color2.mp.alpha == 1.0)
        // Components should be in valid range
        let components1 = color1.mp.rgbComponents
        #expect(components1.red >= 0 && components1.red <= 255)
        #expect(components1.green >= 0 && components1.green <= 255)
        #expect(components1.blue >= 0 && components1.blue <= 255)
    }
}

#endif
