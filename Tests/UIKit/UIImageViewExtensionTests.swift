//
//  UIImageViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIImageView Extensions Test Suite")
struct UIImageViewExtensionTests {
    
    // MARK: - Method: blur(withStyle:)
    
    @Test("blur should add blur effect view")
    @MainActor
    func testBlur() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let initialSubviewCount = imageView.subviews.count
        
        imageView.mp.blur(withStyle: .light)
        
        #expect(imageView.subviews.count > initialSubviewCount)
        #expect(imageView.clipsToBounds == true)
        
        // Verify blur effect view is added
        let hasBlurView = imageView.subviews.contains { $0 is UIVisualEffectView }
        #expect(hasBlurView == true)
    }
    
    @Test("blur should work with different styles")
    @MainActor
    func testBlurDifferentStyles() {
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        imageView1.mp.blur(withStyle: .light)
        imageView2.mp.blur(withStyle: .dark)
        imageView3.mp.blur(withStyle: .extraLight)
        
        #expect(imageView1.subviews.count > 0)
        #expect(imageView2.subviews.count > 0)
        #expect(imageView3.subviews.count > 0)
    }
    
    @Test("blur should use default style when not specified")
    @MainActor
    func testBlurDefaultStyle() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        imageView.mp.blur()
        
        #expect(imageView.subviews.count > 0)
        #expect(imageView.clipsToBounds == true)
    }
    
    // MARK: - Method: blurred(withStyle:)
    
    @Test("blurred should return blurred image view")
    @MainActor
    func testBlurred() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let blurredView = imageView.mp.blurred(withStyle: .light)
        
        #expect(blurredView === imageView)
        #expect(blurredView.subviews.count > 0)
        #expect(blurredView.clipsToBounds == true)
    }
    
    @Test("blurred should work with different styles")
    @MainActor
    func testBlurredDifferentStyles() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let blurred1 = imageView.mp.blurred(withStyle: .light)
        let blurred2 = imageView.mp.blurred(withStyle: .dark)
        
        #expect(blurred1.subviews.count > 0)
        #expect(blurred2.subviews.count > 0)
    }
}
#endif
