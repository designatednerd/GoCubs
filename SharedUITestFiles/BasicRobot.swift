//
//  BasicRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import UIKit
import XCTest

struct TestInfo {

    let testCase: XCTestCase
    let file: StaticString
    let line: UInt
}

protocol BasicRobot {
    
    func launchApplication(file: StaticString,
                           line: UInt)

    func tapButton(withAccessibilityLabel label: String,
                   testInfo: TestInfo)
    
    func waitForLabel(withText text: String,
                      testInfo: TestInfo)
    
    func waitForView(withAccessibilityIdentifier identifier: String,
                     testInfo: TestInfo)
    
    func waitForTableView(withAccessibilityIdentifier identifier: String,
                          testInfo: TestInfo)
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   testInfo: TestInfo) -> String?
}

extension BasicRobot {
    
    func launchApplication(file: StaticString = #file,
                           line: UInt = #line) {
        //Default: No-op
    }
}
