//
//  ComparableExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Comparable Extensions Test Suite")
struct ComparableExtensionTests {
    
    // MARK: - Method: isBetween
    
    @Test("isBetween should check if value is in range")
    func testIsBetween() {
        // Test with Int
        #expect(7.mp.isBetween(6...12) == true)
        #expect(1.mp.isBetween(5...7) == false)
        #expect(5.mp.isBetween(5...7) == true)
        #expect(7.mp.isBetween(5...7) == true)
        #expect(4.mp.isBetween(5...7) == false)
        #expect(8.mp.isBetween(5...7) == false)
        
        // Test with String
        #expect("c".mp.isBetween("a"..."d") == true)
        #expect("a".mp.isBetween("a"..."d") == true)
        #expect("d".mp.isBetween("a"..."d") == true)
        #expect("e".mp.isBetween("a"..."d") == false)
        
        // Test with Double
        #expect(0.32.mp.isBetween(0.31...0.33) == true)
        #expect(0.31.mp.isBetween(0.31...0.33) == true)
        #expect(0.33.mp.isBetween(0.31...0.33) == true)
        #expect(0.30.mp.isBetween(0.31...0.33) == false)
        #expect(0.34.mp.isBetween(0.31...0.33) == false)
    }
    
    // MARK: - Method: clamped
    
    @Test("clamped should limit value to range")
    func testClamped() {
        // Test with Int - value below range
        #expect(1.mp.clamped(to: 3...8) == 3)
        
        // Test with Int - value in range
        #expect(4.mp.clamped(to: 3...7) == 4)
        #expect(5.mp.clamped(to: 3...7) == 5)
        #expect(7.mp.clamped(to: 3...7) == 7)
        
        // Test with Int - value above range
        #expect(10.mp.clamped(to: 3...8) == 8)
        
        // Test with String
        #expect("c".mp.clamped(to: "e"..."g") == "e")
        #expect("f".mp.clamped(to: "e"..."g") == "f")
        #expect("h".mp.clamped(to: "e"..."g") == "g")
        
        // Test with Double
        #expect(0.32.mp.clamped(to: 0.1...0.29) == 0.29)
        #expect(0.25.mp.clamped(to: 0.1...0.29) == 0.25)
        #expect(0.05.mp.clamped(to: 0.1...0.29) == 0.1)
    }
}
