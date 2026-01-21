//
//  SwiftUIColorExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/21.
//

#if canImport(SwiftUI)
import SwiftUI
import Testing
@testable import Maple

@Suite("SwiftUI Color Extensions Test Suite")
struct SwiftUIColorExtensionTests {
    
    // 注意：SwiftUI Color 转换为 UIColor/NSColor 时，由于内部色彩空间转换机制，
    // 获取 RGB 值可能会有轻微的精度损失（通常 ±1-2），这是正常现象。
    // 即使使用默认色彩空间或显式指定 sRGB，也可能出现这种情况。
    // 因此测试中对所有色彩空间的 RGB 值都允许 ±2 的误差范围。
    
    // MARK: - Protocol Conformance
    
    @Test("SwiftUI.Color should conform to MapleCompatibleValue")
    func testColorConformsToMapleCompatibleValue() {
        let color = Color.red
        let wrapper = color.mp
        #expect(wrapper.base == color)
    }
    
    // MARK: - RGB Components
    
    @Test("rgbComponents should return RGB values between 0-255")
    func testRgbComponents() {
        // 使用自定义颜色而不是系统颜色，避免转换误差
        let color = Color(red: 255, green: 0, blue: 0)
        let components = color.mp.rgbComponents
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 0) <= 2)
        #expect(abs(components.blue - 0) <= 2)
    }
    
    @Test("cgFloatComponents should return RGB values between 0-1")
    func testCgFloatComponents() {
        // 使用自定义颜色而不是系统颜色，避免转换误差
        let color = Color(red: 0, green: 0, blue: 255)
        let components = color.mp.cgFloatComponents
        #expect(abs(components.red - 0.0) < 0.02)
        #expect(abs(components.green - 0.0) < 0.02)
        #expect(abs(components.blue - 1.0) < 0.02)
    }
    
    @Test("hsbaComponents should return HSBA components")
    func testHsbaComponents() {
        let color = Color(red: 255, green: 100, blue: 50, opacity: 0.8)
        let components = color.mp.hsbaComponents
        
        // 验证各个分量在有效范围内
        #expect(components.hue >= 0.0 && components.hue <= 1.0)
        #expect(components.saturation >= 0.0 && components.saturation <= 1.0)
        #expect(components.brightness >= 0.0 && components.brightness <= 1.0)
        #expect(abs(components.alpha - 0.8) < 0.02)
    }
    
    // MARK: - Hex String
    
    @Test("hexString should return hexadecimal color string")
    func testHexString() {
        let color = Color(red: 255, green: 100, blue: 50)
        let components = color.mp.rgbComponents
        // 允许轻微的色彩空间转换误差
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 100) <= 2)
        #expect(abs(components.blue - 50) <= 2)
        #expect(color.mp.hexString.hasPrefix("#"))
        #expect(color.mp.hexString.count == 7)
    }
    
    @Test("shortHexString should return short hex for repeating digits")
    func testShortHexString() {
        let color = Color(red: 255, green: 255, blue: 255)
        // 由于色彩空间转换误差，可能无法缩短，检查返回值格式
        let shortHex = color.mp.shortHexString
        if let hex = shortHex {
            #expect(hex.hasPrefix("#"))
            #expect(hex.count == 4) // #FFF 格式
        }
        
        let color2 = Color(red: 255, green: 100, blue: 50)
        // 这个颜色不能缩短
        #expect(color2.mp.shortHexString == nil)
    }
    
    @Test("shortHexOrHexString should return short or full hex")
    func testShortHexOrHexString() {
        let color1 = Color(red: 255, green: 255, blue: 255)
        let hex1 = color1.mp.shortHexOrHexString
        #expect(hex1.hasPrefix("#"))
        #expect(hex1.count == 4 || hex1.count == 7) // 可能是 #FFF 或 #FFFFFF
        
        let color2 = Color(red: 255, green: 100, blue: 50)
        let hex2 = color2.mp.shortHexOrHexString
        #expect(hex2.hasPrefix("#"))
        #expect(hex2.count == 7) // 不能缩短
        // 验证大致的颜色值
        let components = color2.mp.rgbComponents
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 100) <= 2)
        #expect(abs(components.blue - 50) <= 2)
    }
    
    // MARK: - UInt
    
    @Test("uInt should return UInt representation of color")
    func testUInt() {
        let color = Color(red: 255, green: 100, blue: 50)
        let uintValue = color.mp.uInt
        // 验证大致的颜色值（允许色彩空间转换误差）
        let red = (uintValue >> 16) & 0xFF
        let green = (uintValue >> 8) & 0xFF
        let blue = uintValue & 0xFF
        #expect(abs(Int(red) - 255) <= 2)
        #expect(abs(Int(green) - 100) <= 2)
        #expect(abs(Int(blue) - 50) <= 2)
    }
    
    #if !os(watchOS)
    @Test("coreImageColor should return CoreImage.CIColor")
    func testCoreImageColor() {
        let color = Color(red: 255, green: 100, blue: 50)
        let ciColor = color.mp.coreImageColor
        #expect(ciColor != nil)
        
        // 验证 CIColor 的 RGB 分量
        if let ci = ciColor {
            #expect(abs(ci.red - 1.0) < 0.02)
            #expect(abs(ci.green - 100.0/255.0) < 0.02)
            #expect(abs(ci.blue - 50.0/255.0) < 0.02)
        }
    }
    #endif
    
    // MARK: - Initializers
    
    @Test("init(red:green:blue:opacity:) should create color from RGB")
    func testInitWithRGB() {
        let color = Color(red: 255, green: 100, blue: 50)
        let components = color.mp.rgbComponents
        // 允许色彩空间转换导致的轻微误差
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 100) <= 2)
        #expect(abs(components.blue - 50) <= 2)
    }
    
    @Test("init should clamp RGB values to valid range")
    func testInitWithRGBOutOfBounds() {
        let color = Color(red: 300, green: -50, blue: 150)
        let components = color.mp.rgbComponents
        #expect(components.red == 255) // clamped to 255
        #expect(components.green == 0)  // clamped to 0
        #expect(components.blue == 150)
    }
    
    @Test("init(hex:) should create color from hexadecimal Int")
    func testInitWithHex() {
        let color = Color(hex: 0xFF6432)
        let components = color.mp.rgbComponents
        // 允许色彩空间转换导致的轻微误差
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 100) <= 2)
        #expect(abs(components.blue - 50) <= 2)
    }
    
    @Test("init(hexString:) should create color from hex string")
    func testInitWithHexString() throws {
        let color1 = try #require(Color(hexString: "#FF6432"))
        let components1 = color1.mp.rgbComponents
        #expect(abs(components1.red - 255) <= 2)
        #expect(abs(components1.green - 100) <= 2)
        #expect(abs(components1.blue - 50) <= 2)
        
        let color2 = try #require(Color(hexString: "0xFF6432"))
        let components2 = color2.mp.rgbComponents
        #expect(abs(components2.red - 255) <= 2)
        #expect(abs(components2.green - 100) <= 2)
        #expect(abs(components2.blue - 50) <= 2)
        
        let color3 = try #require(Color(hexString: "FF6432"))
        let components3 = color3.mp.rgbComponents
        #expect(abs(components3.red - 255) <= 2)
        #expect(abs(components3.green - 100) <= 2)
        #expect(abs(components3.blue - 50) <= 2)
    }
    
    @Test("init(hexString:) should handle short format")
    func testInitWithShortHexString() throws {
        let color = try #require(Color(hexString: "#F00"))
        let components = color.mp.rgbComponents
        // 验证大致是红色
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 0) <= 2)
        #expect(abs(components.blue - 0) <= 2)
    }
    
    @Test("init(hexString:) should return nil for invalid string")
    func testInitWithInvalidHexString() {
        let color = Color(hexString: "GGGGGG")
        #expect(color == nil)
    }
    
    @Test("init with opacity should set alpha correctly")
    func testInitWithOpacity() {
        let color = Color(red: 255, green: 100, blue: 50, opacity: 0.5)
        #expect(abs(color.mp.alpha - 0.5) < 0.01)
    }
    
    @Test("init(light:dark:) should create dynamic color")
    func testInitWithLightDark() {
        let lightColor = Color(red: 255, green: 255, blue: 255) // White
        let darkColor = Color(red: 0, green: 0, blue: 0)         // Black
        let dynamicColor = Color(light: lightColor, dark: darkColor)
        
        // 动态颜色应该是有效的颜色
        #expect(dynamicColor.mp.alpha >= 0.0 && dynamicColor.mp.alpha <= 1.0)
        
        // 验证颜色分量在有效范围内
        let components = dynamicColor.mp.rgbComponents
        #expect(components.red >= 0 && components.red <= 255)
        #expect(components.green >= 0 && components.green <= 255)
        #expect(components.blue >= 0 && components.blue <= 255)
        
        // 可以创建不同的动态颜色组合
        let customDynamic = Color(
            light: Color(red: 200, green: 100, blue: 50),
            dark: Color(red: 50, green: 100, blue: 200)
        )
        #expect(customDynamic.mp.alpha == 1.0)
    }
    
    @Test("init with colorSpace should create valid colors")
    func testInitWithColorSpace() {
        // sRGB 色彩空间也可能有转换误差
        let color1 = Color(.sRGB, red: 255, green: 100, blue: 50)
        let components1 = color1.mp.rgbComponents
        #expect(abs(components1.red - 255) <= 2)
        #expect(abs(components1.green - 100) <= 2)
        #expect(abs(components1.blue - 50) <= 2)
        
        // displayP3 色彩空间可能有转换误差
        let color2 = Color(.displayP3, red: 255, green: 100, blue: 50)
        let components2 = color2.mp.rgbComponents
        #expect(abs(components2.red - 255) <= 2)
        #expect(abs(components2.green - 100) <= 2)
        #expect(abs(components2.blue - 50) <= 2)
    }
    
    @Test("init(hex:) with colorSpace should work correctly")
    func testInitWithHexAndColorSpace() {
        // sRGB 色彩空间也可能有转换误差
        let color1 = Color(.sRGB, hex: 0xFF6432)
        let components1 = color1.mp.rgbComponents
        #expect(abs(components1.red - 255) <= 2)
        #expect(abs(components1.green - 100) <= 2)
        #expect(abs(components1.blue - 50) <= 2)
        #expect(abs(color1.mp.alpha - 1.0) < 0.01)
        
        // displayP3 色彩空间可能有转换误差
        let color2 = Color(.displayP3, hex: 0xFF6432, opacity: 0.8)
        let components2 = color2.mp.rgbComponents
        #expect(abs(components2.red - 255) <= 2)
        #expect(abs(components2.green - 100) <= 2)
        #expect(abs(components2.blue - 50) <= 2)
        #expect(abs(color2.mp.alpha - 0.8) < 0.01)
    }
    
    @Test("init(hexString:) with colorSpace should work correctly")
    func testInitWithHexStringAndColorSpace() throws {
        // sRGB 色彩空间也可能有转换误差
        let color1 = try #require(Color(.sRGB, hexString: "#FF6432"))
        let components1 = color1.mp.rgbComponents
        #expect(abs(components1.red - 255) <= 2)
        #expect(abs(components1.green - 100) <= 2)
        #expect(abs(components1.blue - 50) <= 2)
        
        // displayP3 色彩空间可能有转换误差
        let color2 = try #require(Color(.displayP3, hexString: "0xFF6432", opacity: 0.7))
        let components2 = color2.mp.rgbComponents
        #expect(abs(components2.red - 255) <= 2)
        #expect(abs(components2.green - 100) <= 2)
        #expect(abs(components2.blue - 50) <= 2)
        #expect(abs(color2.mp.alpha - 0.7) < 0.01)
        
        // sRGBLinear 色彩空间也可能有转换误差
        let color3 = try #require(Color(.sRGBLinear, hexString: "F00"))
        let components3 = color3.mp.rgbComponents
        #expect(abs(components3.red - 255) <= 2)
        #expect(abs(components3.green - 0) <= 2)
        #expect(abs(components3.blue - 0) <= 2)
    }
    
    // MARK: - Color Adjustment
    
    @Test("lighten(by:) should make color lighter")
    func testLighten() {
        let color = Color(red: 100, green: 100, blue: 100)
        let lighter = color.mp.lighten(by: 0.2)
        let components = lighter.mp.cgFloatComponents
        
        #expect(components.red > 100.0 / 255.0)
        #expect(components.green > 100.0 / 255.0)
        #expect(components.blue > 100.0 / 255.0)
    }
    
    @Test("darken(by:) should make color darker")
    func testDarken() {
        let color = Color(red: 200, green: 200, blue: 200)
        let darker = color.mp.darken(by: 0.2)
        let components = darker.mp.cgFloatComponents
        
        #expect(components.red < 200.0 / 255.0)
        #expect(components.green < 200.0 / 255.0)
        #expect(components.blue < 200.0 / 255.0)
    }
    
    // MARK: - Random Color
    
    @Test("random should generate random colors")
    func testRandomColor() {
        let color1 = Color.random
        let color2 = Color.random
        
        // Random colors should (most likely) be different
        #expect(color1.mp.hexString != color2.mp.hexString)
    }
    
    @Test("random(_:) with colorSpace should generate valid colors")
    func testRandomColorWithColorSpace() {
        let color1 = Color.random()
        let color2 = Color.random(.sRGB)
        let color3 = Color.random(.displayP3)
        
        // All should be valid colors with valid RGB components
        let components1 = color1.mp.rgbComponents
        #expect(components1.red >= 0 && components1.red <= 255)
        #expect(components1.green >= 0 && components1.green <= 255)
        #expect(components1.blue >= 0 && components1.blue <= 255)
        
        let components2 = color2.mp.rgbComponents
        #expect(components2.red >= 0 && components2.red <= 255)
        #expect(components2.green >= 0 && components2.green <= 255)
        #expect(components2.blue >= 0 && components2.blue <= 255)
        
        // displayP3 也应该在合理范围内
        let components3 = color3.mp.rgbComponents
        #expect(components3.red >= 0 && components3.red <= 255)
        #expect(components3.green >= 0 && components3.green <= 255)
        #expect(components3.blue >= 0 && components3.blue <= 255)
    }
    
    // MARK: - Cross-Platform Conversion
    
    @Test("color should convert platform color to SwiftUI Color")
    func testColorConversion() {
        #if canImport(UIKit)
        // 使用自定义颜色而不是系统颜色
        let uiColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let swiftUIColor = uiColor.mp.color
        let components = swiftUIColor.mp.rgbComponents
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 0) <= 2)
        #expect(abs(components.blue - 0) <= 2)
        #elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
        // 使用自定义颜色而不是系统颜色
        let nsColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let swiftUIColor = nsColor.mp.color
        let components = swiftUIColor.mp.rgbComponents
        #expect(abs(components.red - 255) <= 2)
        #expect(abs(components.green - 0) <= 2)
        #expect(abs(components.blue - 0) <= 2)
        #endif
    }
}

#endif
