//
//  BinaryFloatingPointExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("BinaryFloatingPoint Extensions Test Suite")
struct BinaryFloatingPointExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("BinaryFloatingPoint should have mp property")
    func testBinaryFloatingPointHasMPProperty() {
        let double: Double = 3.14
        let wrapper = double.mp
        #expect(wrapper.base == double)
    }
    
    // MARK: - Method: rounded
    
    @Test("rounded should round with specified decimal places and rule")
    func testRounded() {
        let num: Double = 3.1415927
        
        // Test rounding up
        let roundedUp = num.mp.rounded(numberOfDecimalPlaces: 3, rule: .up)
        #expect(abs(roundedUp - 3.142) < 0.0001)
        
        // Test rounding down
        let roundedDown = num.mp.rounded(numberOfDecimalPlaces: 3, rule: .down)
        #expect(abs(roundedDown - 3.141) < 0.0001)
        
        // Test away from zero
        let roundedAway = num.mp.rounded(numberOfDecimalPlaces: 2, rule: .awayFromZero)
        #expect(abs(roundedAway - 3.15) < 0.0001)
        
        // Test toward zero
        let roundedToward = num.mp.rounded(numberOfDecimalPlaces: 4, rule: .towardZero)
        #expect(abs(roundedToward - 3.1415) < 0.0001)
        
        // Test to nearest or even
        let roundedNearest = num.mp.rounded(numberOfDecimalPlaces: -1, rule: .toNearestOrEven)
        #expect(abs(roundedNearest - 3.0) < 0.1)
        
        // Test with Float
        let floatNum: Float = 2.71828
        let roundedFloat = floatNum.mp.rounded(numberOfDecimalPlaces: 2, rule: .toNearestOrEven)
        #expect(abs(roundedFloat - 2.72) < 0.01)
        
        // Test with zero decimal places
        let roundedZero = num.mp.rounded(numberOfDecimalPlaces: 0, rule: .toNearestOrEven)
        #expect(abs(roundedZero - 3.0) < 0.1)
        
        // Test with negative decimal places (should use 0)
        let roundedNegative = num.mp.rounded(numberOfDecimalPlaces: -5, rule: .toNearestOrEven)
        #expect(abs(roundedNegative - 3.0) < 0.1)
    }
}
