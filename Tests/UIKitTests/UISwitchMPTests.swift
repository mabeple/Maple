//
//  UISwitchMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2021/4/29.
//  Copyright © 2021 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
class UISwitchMPTests: XCTestCase {
    
    func testToggle() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let aSwitch = UISwitch(frame: frame)
        XCTAssertFalse(aSwitch.isOn)
        aSwitch.mp.toggle(animated: false)
        XCTAssert(aSwitch.isOn)
    }
}
#endif
