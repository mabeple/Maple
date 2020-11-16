//
//  ColorExtensionsTests.swift
//  Maple
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class ColorExtensionsTests: XCTestCase {
    
    func testRgbComponents() {
        XCTAssertEqual(MPCrossPlatformColor.red.mp.rgbComponents.red, 255)
        XCTAssertEqual(MPCrossPlatformColor.red.mp.rgbComponents.green, 0)
        XCTAssertEqual(MPCrossPlatformColor.red.mp.rgbComponents.blue, 0)
        
        XCTAssertEqual(MPCrossPlatformColor.green.mp.rgbComponents.red, 0)
        XCTAssertEqual(MPCrossPlatformColor.green.mp.rgbComponents.green, 255)
        XCTAssertEqual(MPCrossPlatformColor.green.mp.rgbComponents.blue, 0)
        
        XCTAssertEqual(MPCrossPlatformColor.blue.mp.rgbComponents.red, 0)
        XCTAssertEqual(MPCrossPlatformColor.blue.mp.rgbComponents.green, 0)
        XCTAssertEqual(MPCrossPlatformColor.blue.mp.rgbComponents.blue, 255)
        
        XCTAssertEqual(MPCrossPlatformColor.black.mp.rgbComponents.red, 0)
        XCTAssertEqual(MPCrossPlatformColor.black.mp.rgbComponents.green, 0)
        XCTAssertEqual(MPCrossPlatformColor.black.mp.rgbComponents.blue, 0)
        
        XCTAssertEqual(MPCrossPlatformColor.white.mp.rgbComponents.red, 255)
        XCTAssertEqual(MPCrossPlatformColor.white.mp.rgbComponents.green, 255)
        XCTAssertEqual(MPCrossPlatformColor.white.mp.rgbComponents.blue, 255)
        
        XCTAssertEqual(MPCrossPlatformColor(hex: 0x12FFFF).mp.rgbComponents.red, 0x12)
    }
    
    func testCGFloatComponents() {
        XCTAssertEqual(MPCrossPlatformColor.red.mp.cgFloatComponents.red, 1.0)
        XCTAssertEqual(MPCrossPlatformColor.red.mp.cgFloatComponents.green, 0.0)
        XCTAssertEqual(MPCrossPlatformColor.red.mp.cgFloatComponents.blue, 0.0)
        
        XCTAssertEqual(MPCrossPlatformColor.green.mp.cgFloatComponents.red, 0.0)
        XCTAssertEqual(MPCrossPlatformColor.green.mp.cgFloatComponents.green, 1.0)
        XCTAssertEqual(MPCrossPlatformColor.green.mp.cgFloatComponents.blue, 0.0)
        
        XCTAssertEqual(MPCrossPlatformColor.blue.mp.cgFloatComponents.red, 0.0)
        XCTAssertEqual(MPCrossPlatformColor.blue.mp.cgFloatComponents.green, 0.0)
        XCTAssertEqual(MPCrossPlatformColor.blue.mp.cgFloatComponents.blue, 1.0)
        
        XCTAssertEqual(MPCrossPlatformColor.black.mp.cgFloatComponents.red, 0.0)
        XCTAssertEqual(MPCrossPlatformColor.black.mp.cgFloatComponents.green, 0.0)
        XCTAssertEqual(MPCrossPlatformColor.black.mp.cgFloatComponents.blue, 0.0)
        
        XCTAssertEqual(MPCrossPlatformColor.white.mp.cgFloatComponents.red, 1.0)
        XCTAssertEqual(MPCrossPlatformColor.white.mp.cgFloatComponents.green, 1.0)
        XCTAssertEqual(MPCrossPlatformColor.white.mp.cgFloatComponents.blue, 1.0)
        
        XCTAssertEqual(Int(MPCrossPlatformColor(hex: 0x12FFFF).mp.cgFloatComponents.red * 255.0), 0x12)
    }
    
    func testHsbaComponents() {
        var color = MPCrossPlatformColor(hex: 0x00FF00, transparency: 1.0)
        XCTAssertEqual(CGFloat(round(1000 * color.mp.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (120/360)) / 1000))
        XCTAssertEqual(color.mp.hsbaComponents.saturation, 1.0)
        XCTAssertEqual(color.mp.hsbaComponents.brightness, 1.0)
        
        color = MPCrossPlatformColor(hex: 0x0000FF, transparency: 1.0)
        XCTAssertEqual(CGFloat(round(1000 * color.mp.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (240/360)) / 1000))
        XCTAssertEqual(color.mp.hsbaComponents.saturation, 1.0)
        XCTAssertEqual(color.mp.hsbaComponents.brightness, 1.0)
        
        color = MPCrossPlatformColor(hex: 0x000000, transparency: 1.0)
        XCTAssertEqual(color.mp.hsbaComponents.hue, 0.0)
        XCTAssertEqual(color.mp.hsbaComponents.saturation, 0.0)
        XCTAssertEqual(color.mp.hsbaComponents.brightness, 0.0)
        
        color = MPCrossPlatformColor(hex: 0xFFFFFF, transparency: 1.0)
        XCTAssertEqual(color.mp.hsbaComponents.hue, 0.0)
        XCTAssertEqual(color.mp.hsbaComponents.saturation, 0.0)
        XCTAssertEqual(color.mp.hsbaComponents.brightness, 1.0)
        
        color = MPCrossPlatformColor(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(CGFloat(round(1000 * color.mp.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (210/360)) / 1000))
        XCTAssertEqual((color.mp.hsbaComponents.saturation * 100).rounded(), 79)
        XCTAssertEqual((color.mp.hsbaComponents.brightness * 100).rounded(), 34)
        
        color = MPCrossPlatformColor(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(CGFloat(round(1000 * color.mp.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (27/360)) / 1000))
        XCTAssertEqual((color.mp.hsbaComponents.saturation * 100).rounded(), 60)
        XCTAssertEqual((color.mp.hsbaComponents.brightness * 100).rounded(), 99)
        
        color = MPCrossPlatformColor(hex: 0x1F2D3C, transparency: 1.0)
        XCTAssertEqual(CGFloat(round(1000 * color.mp.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (211/360)) / 1000))
        XCTAssertEqual((color.mp.hsbaComponents.saturation * 100).rounded(), 48)
        XCTAssertEqual((color.mp.hsbaComponents.brightness * 100).rounded(), 24)
    }
    
    func testHexString() {
        var color: MPCrossPlatformColor? = MPCrossPlatformColor.red
        XCTAssertEqual(color?.mp.hexString, "#FF0000")
        
        color = MPCrossPlatformColor.blue
        XCTAssertEqual(color?.mp.hexString, "#0000FF")
        
        color = MPCrossPlatformColor(hex: 0xABCDEF)
        XCTAssertEqual(color?.mp.hexString, "#ABCDEF")
        
        color = MPCrossPlatformColor(hex: 0xABC)
        XCTAssertEqual(color?.mp.hexString, "#000ABC")
        
        color = MPCrossPlatformColor.black
        XCTAssertEqual(color?.mp.hexString, "#000000")
    }
    
    func testShortHexString() {
        var color: MPCrossPlatformColor? = MPCrossPlatformColor.red
        XCTAssertEqual(color?.mp.shortHexString, "#F00")
        
        color = MPCrossPlatformColor.blue
        XCTAssertEqual(color?.mp.shortHexString, "#00F")
        
        color = MPCrossPlatformColor(hexString: "#0F120F")
        XCTAssertNil(color?.mp.shortHexString)
        
        color = MPCrossPlatformColor(hexString: "#8FFFF")
        XCTAssertNil(color?.mp.shortHexString)
    }
    
    func testShortHexOrHexString() {
        var color: MPCrossPlatformColor? = MPCrossPlatformColor.red
        XCTAssertEqual(color?.mp.shortHexOrHexString, "#F00")
        
        color = MPCrossPlatformColor(hexString: "#8FFFFF")
        XCTAssertEqual(color?.mp.shortHexOrHexString, "#8FFFFF")
        
        color = MPCrossPlatformColor(hexString: "#F")
        XCTAssertEqual(color?.mp.shortHexOrHexString, "#00000F")
        
        color = MPCrossPlatformColor(hexString: "#11")
        XCTAssertEqual(color?.mp.shortHexOrHexString, "#001")
    }
    
    func testAlpha() {
        var color = MPCrossPlatformColor.red
        XCTAssertEqual(color.mp.alpha, 1.0)
        
        color = MPCrossPlatformColor.white.withAlphaComponent(0.5)
        XCTAssertEqual(color.mp.alpha, 0.5)
        
        color = MPCrossPlatformColor(red: 0, green: 0, blue: 0, transparency: 0.7)
        XCTAssertEqual(color.mp.alpha, 0.7)
        
        color = MPCrossPlatformColor(red: 0, green: 0, blue: 0, transparency: 1.1)
        XCTAssertEqual(color.mp.alpha, 1.0)
    }
    
    #if !os(watchOS)
    func testCoreImageColor() {
        let color = MPCrossPlatformColor.red
        let coreImageColor = color.mp.coreImageColor
        XCTAssertNotNil(color.mp.coreImageColor)
        XCTAssertEqual(color.mp.coreImageColor!, coreImageColor)
    }
    #endif
    
    func testUInt() {
        var color = MPCrossPlatformColor(hex: 0xFF0000, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0xFF0000)
        
        color = MPCrossPlatformColor(hex: 0x00FF00, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0x00FF00)
        
        color = MPCrossPlatformColor(hex: 0x0000FF, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0x0000FF)
        
        color = MPCrossPlatformColor(hex: 0x000000, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0x000000)
        
        color = MPCrossPlatformColor(hex: 0xFFFFFF, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0xFFFFFF)
        
        color = MPCrossPlatformColor(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0x123456)
        
        color = MPCrossPlatformColor(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0xFCA864)
        
        color = MPCrossPlatformColor(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0xFCA864)
        
        color = MPCrossPlatformColor(hex: 0x1F2D3C, transparency: 1.0)
        XCTAssertEqual(color.mp.uInt, 0x1F2D3C)
    }
    
    func testLighten() {
        let color = MPCrossPlatformColor.blue
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let lighterColor = color.mp.lighten(by: 0.3)
        var lightR: CGFloat = 0, lightG: CGFloat = 0, lightB: CGFloat = 0
        lighterColor.getRed(&lightR, green: &lightG, blue: &lightB, alpha: nil)
        
        XCTAssertEqual(lightR, min(red + 0.3, 1.0))
        XCTAssertEqual(lightG, min(green + 0.3, 1.0))
        XCTAssertEqual(lightB, min(blue + 0.3, 1.0))
    }
    
    func testDarken() {
        let color = MPCrossPlatformColor.blue
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let darkerColor = color.mp.darken(by: 0.3)
        var darkR: CGFloat = 0, darkG: CGFloat = 0, darkB: CGFloat = 0
        darkerColor.getRed(&darkR, green: &darkG, blue: &darkB, alpha: nil)
        
        XCTAssertEqual(darkR, max(red - 0.3, 0))
        XCTAssertEqual(darkG, max(green - 0.3, 0))
        XCTAssertEqual(darkB, max(blue - 0.3, 0))
    }
    
    func testInitWithComponents() {
        var red1: CGFloat = 0
        var red2: CGFloat = 0
        var green1: CGFloat = 0
        var green2: CGFloat = 0
        var blue1: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha1: CGFloat = 0
        var alpha2: CGFloat = 0
        
        var color1 = MPCrossPlatformColor(red: 255, green: 244, blue: 255, transparency: 2.0)
        var color2 = MPCrossPlatformColor(red: 1.0, green: 244.0 / 255.0, blue: 1.0, alpha: 1.0)
        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)
        
        color1 = MPCrossPlatformColor(red: 25, green: 244, blue: 55, transparency: -1.0)
        color2 = MPCrossPlatformColor(red: 25.0 / 255.0, green: 244.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.0)
        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)
        
        color1 = MPCrossPlatformColor(red: 2, green: 4, blue: 5)
        color2 = MPCrossPlatformColor(red: 2.0 / 255.0, green: 4.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)
    }
    
    func testFailableInitWithComponents() {
        let color1 = MPCrossPlatformColor(red: 258, green: 0, blue: 0)
        XCTAssertNotNil(color1)
        
        let color2 = MPCrossPlatformColor(red: 0, green: 258, blue: 0)
        XCTAssertNotNil(color2)
        
        let color3 = MPCrossPlatformColor(red: 0, green: 0, blue: 258)
        XCTAssertNotNil(color3)
        
        let color4 = MPCrossPlatformColor(red: 258, green: 258, blue: 258)
        XCTAssertNotNil(color4)
        
    }
    
    func testInit() {
        var color = MPCrossPlatformColor(hex: 0xFFF)
        XCTAssertEqual(color.mp.rgbComponents.red, 0)
        XCTAssertEqual(color.mp.rgbComponents.green, 0xf)
        XCTAssertEqual(color.mp.rgbComponents.blue, 0xff)
        XCTAssertEqual(color.mp.alpha, 1.0)
        
        color = MPCrossPlatformColor(hex: 0xFFFFFFF)
        XCTAssertEqual(color.mp.rgbComponents.red, 0xff)
        XCTAssertEqual(color.mp.rgbComponents.green, 0xff)
        XCTAssertEqual(color.mp.rgbComponents.blue, 0xff)
        XCTAssertEqual(color.mp.alpha, 1.0)
        
        color = MPCrossPlatformColor(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(color.mp.rgbComponents.red, 0x12)
        XCTAssertEqual(color.mp.rgbComponents.green, 0x34)
        XCTAssertEqual(color.mp.rgbComponents.blue, 0x56)
        XCTAssertEqual(color.mp.alpha, 1.0)
        
        color = MPCrossPlatformColor(hex: 0x999, transparency: 21.0)
        XCTAssertEqual(color.mp.rgbComponents.red, 0)
        XCTAssertEqual(color.mp.rgbComponents.green, 0x09)
        XCTAssertEqual(color.mp.rgbComponents.blue, 0x99)
        XCTAssertEqual(color.mp.alpha, 1.0)
        
        color = MPCrossPlatformColor(hex: 0xaabbcc, transparency: 0.0)
        XCTAssertEqual(color.mp.rgbComponents.red, 0xaa)
        XCTAssertEqual(color.mp.rgbComponents.green, 0xbb)
        XCTAssertEqual(color.mp.rgbComponents.blue, 0xcc)
        XCTAssertEqual(color.mp.alpha, 0.0)
        
        color = MPCrossPlatformColor(hex: 0x1, transparency: 0.5)
        XCTAssertEqual(color.mp.rgbComponents.red, 0)
        XCTAssertEqual(color.mp.rgbComponents.green, 0)
        XCTAssertEqual(color.mp.rgbComponents.blue, 1)
        XCTAssertEqual(color.mp.alpha, 0.5)
        let color1 = MPCrossPlatformColor(hex: 0xFFF, transparency: -0.4)
        let color2 = MPCrossPlatformColor(hex: 0xFFF, transparency: 0)
        XCTAssertEqual(color1, color2)
        
        let color3 = MPCrossPlatformColor(hex: 0xFFF, transparency: 1.5)
        let color4 = MPCrossPlatformColor(hex: 0xFFF, transparency: 1)
        XCTAssertEqual(color3, color4)
    }
    
    func testFailableInit() {
        var color = MPCrossPlatformColor(hexString: "0xFFFFFF")
        XCTAssertNotNil(color)
        
        color = MPCrossPlatformColor(hexString: "#FFFFFF")
        XCTAssertNotNil(color)
        
        color = MPCrossPlatformColor(hexString: "FFFFFF")
        XCTAssertNotNil(color)
        
        color = MPCrossPlatformColor(hexString: "#ABC")
        XCTAssertNotNil(color)
        
        color = MPCrossPlatformColor(hexString: "#GGG")
        XCTAssertNil(color)
        
        color = MPCrossPlatformColor(hexString: "4#fff")
        XCTAssertNil(color)
        
        color = MPCrossPlatformColor(hexString: "FFFFFFF")
        XCTAssertNotNil(color)
    }
    
    #if canImport(AppKit)
    func testInitLightDark() {
        let lightModeColor = MPCrossPlatformColor.red
        let darkModeColor = MPCrossPlatformColor.blue
        
        if #available(OSX 10.15, *) {
            let color = MPCrossPlatformColor(light: lightModeColor, dark: darkModeColor)
            let view = NSView()
            NSAppearance.current = NSAppearance(named: .aqua)
            view.mp.backgroundColor = color
            XCTAssertEqual(view.mp.backgroundColor, lightModeColor)
            
            NSAppearance.current = NSAppearance(named: .darkAqua)
            view.mp.backgroundColor = color
            XCTAssertEqual(view.mp.backgroundColor, darkModeColor)
        }
    }
    #endif
    
    #if canImport(UIKit) && !os(watchOS)
    func testInitLightDark() {
        let lightModeColor = UIColor.red
        let darkModeColor = UIColor.blue
        let color = UIColor(light: lightModeColor, dark: darkModeColor)

        if #available(iOS 13.0, tvOS 13.0, *) {
            XCTAssertEqual(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)), lightModeColor)
            XCTAssertEqual(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)), darkModeColor)
        } else {
            XCTAssertEqual(color, lightModeColor)
        }
    }
    #endif
    
    func testRandom() {
        let color1 = MPCrossPlatformColor.random
        let color2 = MPCrossPlatformColor.random
        XCTAssertNotEqual(color1, color2)
    }
}
