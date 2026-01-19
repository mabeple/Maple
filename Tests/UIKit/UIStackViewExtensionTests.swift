//
//  UIStackViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UIStackView Extensions Test Suite")
struct UIStackViewExtensionTests {
    
    // MARK: - Method: addArrangedSubviews
    
    @Test("addArrangedSubviews should add multiple views")
    @MainActor
    func testAddArrangedSubviews() {
        let stackView = UIStackView()
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        
        stackView.mp.addArrangedSubviews([view1, view2, view3])
        
        #expect(stackView.arrangedSubviews.count == 3)
        #expect(stackView.arrangedSubviews.contains(view1))
        #expect(stackView.arrangedSubviews.contains(view2))
        #expect(stackView.arrangedSubviews.contains(view3))
    }
    
    @Test("addArrangedSubviews should work with empty array")
    @MainActor
    func testAddArrangedSubviewsEmpty() {
        let stackView = UIStackView()
        let initialCount = stackView.arrangedSubviews.count
        
        stackView.mp.addArrangedSubviews([])
        
        #expect(stackView.arrangedSubviews.count == initialCount)
    }
    
    // MARK: - Method: removeArrangedSubviews
    
    @Test("removeArrangedSubviews should remove all arranged subviews")
    @MainActor
    func testRemoveArrangedSubviews() {
        let stackView = UIStackView()
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        
        #expect(stackView.arrangedSubviews.count == 3)
        
        stackView.mp.removeArrangedSubviews()
        
        #expect(stackView.arrangedSubviews.count == 0)
    }
    
    @Test("removeArrangedSubviews should work with empty stack view")
    @MainActor
    func testRemoveArrangedSubviewsEmpty() {
        let stackView = UIStackView()
        
        stackView.mp.removeArrangedSubviews()
        
        #expect(stackView.arrangedSubviews.count == 0)
    }
    
    // MARK: - Initializer: init(arrangedSubviews:axis:spacing:alignment:distribution)
    
    @Test("convenience initializer should create stack view with parameters")
    @MainActor
    func testConvenienceInitializer() {
        let view1 = UIView()
        let view2 = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [view1, view2],
            axis: .vertical,
            spacing: 10.0,
            alignment: .center,
            distribution: .equalSpacing
        )
        
        #expect(stackView.arrangedSubviews.count == 2)
        #expect(stackView.axis == .vertical)
        #expect(stackView.spacing == 10.0)
        #expect(stackView.alignment == .center)
        #expect(stackView.distribution == .equalSpacing)
    }
    
    @Test("convenience initializer should use default values")
    @MainActor
    func testConvenienceInitializerDefaults() {
        let view1 = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [view1],
            axis: .horizontal
        )
        
        #expect(stackView.arrangedSubviews.count == 1)
        #expect(stackView.axis == .horizontal)
        #expect(stackView.spacing == 0.0)
        #expect(stackView.alignment == .fill)
        #expect(stackView.distribution == .fill)
    }
}
#endif
