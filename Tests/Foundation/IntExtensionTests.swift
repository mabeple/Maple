//
//  IntExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

#if canImport(CoreGraphics)
import CoreGraphics
#endif

@Suite("Int Extensions Test Suite")
struct IntExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Int should conform to MapleCompatibleValue")
    func testIntConformsToMapleCompatibleValue() {
        let int = 42
        let wrapper = int.mp
        #expect(wrapper.base == int)
        #expect(type(of: wrapper) == MapleWrapper<Int>.self)
    }
    
    // MARK: - Property: countableRange
    
    @Test("countableRange should return range from 0 to base")
    func testCountableRange() {
        #expect(5.mp.countableRange == 0..<5)
        #expect(0.mp.countableRange == 0..<0)
        #expect(10.mp.countableRange == 0..<10)
    }
    
    // MARK: - Property: degreesToRadians
    
    @Test("degreesToRadians should convert degrees to radians")
    func testDegreesToRadians() {
        #expect(abs(180.mp.degreesToRadians - Double.pi) < 0.0001)
        #expect(abs(90.mp.degreesToRadians - Double.pi / 2) < 0.0001)
        #expect(abs(0.mp.degreesToRadians - 0) < 0.0001)
        #expect(abs(360.mp.degreesToRadians - 2 * Double.pi) < 0.0001)
    }
    
    // MARK: - Property: radiansToDegrees
    
    @Test("radiansToDegrees should convert radians to degrees")
    func testRadiansToDegrees() {
        #expect(abs(Double.pi.mp.radiansToDegrees - 180) < 0.0001)
        #expect(abs((Double.pi / 2).mp.radiansToDegrees - 90) < 0.0001)
        #expect(abs(0.mp.radiansToDegrees - 0) < 0.0001)
    }
    
    // MARK: - Property: uInt
    
    @Test("uInt should convert Int to UInt")
    func testUInt() {
        #expect(42.mp.uInt == 42)
        #expect(0.mp.uInt == 0)
        #expect(100.mp.uInt == 100)
    }
    
    // MARK: - Property: double
    
    @Test("double should convert Int to Double")
    func testDouble() {
        #expect(42.mp.double == 42.0)
        #expect(0.mp.double == 0.0)
        #expect(-10.mp.double == -10.0)
    }
    
    // MARK: - Property: float
    
    @Test("float should convert Int to Float")
    func testFloat() {
        #expect(42.mp.float == 42.0)
        #expect(0.mp.float == 0.0)
        #expect(-10.mp.float == -10.0)
    }
    
    // MARK: - Property: cgFloat
    
    #if canImport(CoreGraphics)
    @Test("cgFloat should convert Int to CGFloat")
    func testCGFloat() {
        #expect(42.mp.cgFloat == 42.0)
        #expect(0.mp.cgFloat == 0.0)
        #expect(-10.mp.cgFloat == -10.0)
    }
    #endif
    
    // MARK: - Property: digits
    
    @Test("digits should return array of digits")
    func testDigits() {
        #expect(123.mp.digits == [1, 2, 3])
        #expect(0.mp.digits == [0])
        #expect(987654321.mp.digits == [9, 8, 7, 6, 5, 4, 3, 2, 1])
        #expect(100.mp.digits == [1, 0, 0])
        #expect((-123).mp.digits == [1, 2, 3]) // abs value
    }
    
    // MARK: - Property: digitsCount
    
    @Test("digitsCount should return number of digits")
    func testDigitsCount() {
        #expect(123.mp.digitsCount == 3)
        #expect(0.mp.digitsCount == 1)
        #expect(9.mp.digitsCount == 1)
        #expect(10.mp.digitsCount == 2)
        #expect(100.mp.digitsCount == 3)
        #expect(9999.mp.digitsCount == 4)
        #expect((-123).mp.digitsCount == 3) // abs value
    }
    
    // MARK: - Method: isPrime
    
    @Test("isPrime should check if number is prime")
    func testIsPrime() {
        // Prime numbers
        #expect(2.mp.isPrime() == true)
        #expect(3.mp.isPrime() == true)
        #expect(5.mp.isPrime() == true)
        #expect(7.mp.isPrime() == true)
        #expect(11.mp.isPrime() == true)
        #expect(13.mp.isPrime() == true)
        #expect(17.mp.isPrime() == true)
        #expect(19.mp.isPrime() == true)
        #expect(23.mp.isPrime() == true)
        
        // Non-prime numbers
        #expect(1.mp.isPrime() == false)
        #expect(4.mp.isPrime() == false)
        #expect(6.mp.isPrime() == false)
        #expect(8.mp.isPrime() == false)
        #expect(9.mp.isPrime() == false)
        #expect(10.mp.isPrime() == false)
        #expect(12.mp.isPrime() == false)
        #expect(15.mp.isPrime() == false)
        #expect(0.mp.isPrime() == false)
        #expect((-5).mp.isPrime() == false)
    }
    
    // MARK: - Method: romanNumeral
    
    @Test("romanNumeral should convert integer to roman numeral")
    func testRomanNumeral() {
        #expect(1.mp.romanNumeral() == "I")
        #expect(2.mp.romanNumeral() == "II")
        #expect(3.mp.romanNumeral() == "III")
        #expect(4.mp.romanNumeral() == "IV")
        #expect(5.mp.romanNumeral() == "V")
        #expect(9.mp.romanNumeral() == "IX")
        #expect(10.mp.romanNumeral() == "X")
        #expect(40.mp.romanNumeral() == "XL")
        #expect(50.mp.romanNumeral() == "L")
        #expect(90.mp.romanNumeral() == "XC")
        #expect(100.mp.romanNumeral() == "C")
        #expect(400.mp.romanNumeral() == "CD")
        #expect(500.mp.romanNumeral() == "D")
        #expect(900.mp.romanNumeral() == "CM")
        #expect(1000.mp.romanNumeral() == "M")
        #expect(1994.mp.romanNumeral() == "MCMXCIV")
        #expect(2024.mp.romanNumeral() == "MMXXIV")
        
        // Invalid cases
        #expect(0.mp.romanNumeral() == nil)
        #expect((-5).mp.romanNumeral() == nil)
    }
    
    // MARK: - Method: roundToNearest
    
    @Test("roundToNearest should round to nearest multiple")
    func testRoundToNearest() {
        #expect(10.mp.roundToNearest(5) == 10)
        #expect(12.mp.roundToNearest(5) == 10)
        #expect(13.mp.roundToNearest(5) == 15)
        #expect(17.mp.roundToNearest(5) == 15)
        #expect(18.mp.roundToNearest(5) == 20)
        #expect(25.mp.roundToNearest(10) == 30) // round(2.5) = 3, so 3 * 10 = 30
        #expect(26.mp.roundToNearest(10) == 30)
        #expect(24.mp.roundToNearest(10) == 20) // round(2.4) = 2, so 2 * 10 = 20
        #expect(0.mp.roundToNearest(5) == 0)
        #expect(5.mp.roundToNearest(0) == 5) // number == 0 returns base
    }
    
    // MARK: - Operator: **
    
    @Test("exponentiation operator should calculate power")
    func testExponentiationOperator() {
        #expect(abs((2 ** 3) - 8.0) < 0.0001)
        #expect(abs((3 ** 2) - 9.0) < 0.0001)
        #expect(abs((5 ** 0) - 1.0) < 0.0001)
        #expect(abs((10 ** 2) - 100.0) < 0.0001)
    }
    
    // MARK: - Operator: √
    
    @Test("square root operator should calculate square root")
    func testSquareRootOperator() {
        #expect(abs(√4 - 2.0) < 0.0001)
        #expect(abs(√9 - 3.0) < 0.0001)
        #expect(abs(√16 - 4.0) < 0.0001)
        #expect(abs(√25 - 5.0) < 0.0001)
        #expect(abs(√0 - 0.0) < 0.0001)
    }
    
    // MARK: - Operator: ± (infix)
    
    @Test("plus-minus infix operator should return tuple")
    func testPlusMinusInfixOperator() {
        let result1 = 2 ± 3
        #expect(result1.0 == 5)
        #expect(result1.1 == -1)
        
        let result2 = 10 ± 5
        #expect(result2.0 == 15)
        #expect(result2.1 == 5)
        
        let result3 = 0 ± 5
        #expect(result3.0 == 5)
        #expect(result3.1 == -5)
    }
    
    // MARK: - Operator: ± (prefix)
    
    @Test("plus-minus prefix operator should return tuple")
    func testPlusMinusPrefixOperator() {
        let result1 = ±2
        #expect(result1.0 == 2)
        #expect(result1.1 == -2)
        
        let result2 = ±10
        #expect(result2.0 == 10)
        #expect(result2.1 == -10)
        
        let result3 = ±0
        #expect(result3.0 == 0)
        #expect(result3.1 == 0)
    }
}
