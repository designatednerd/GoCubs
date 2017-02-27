//
//  BasicRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import UIKit
import XCTest

/// A structure to help pass necessary information to tests
struct TestInfo {
    let testCase: XCTestCase
    let file: StaticString
    let line: UInt
}

//MARK: - Basic Robot Protocol 

protocol BasicRobot {
    
    func launchApplication(file: StaticString,
                           line: UInt)

    func tapButton(withAccessibilityLabel label: String,
                   testInfo: TestInfo)
    
    func checkViewIsVisible(withAccessibilityLabel label: String,
                            testInfo: TestInfo)
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: String,
                            testInfo: TestInfo)
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: String,
                                 testInfo: TestInfo)
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   testInfo: TestInfo) -> String?
}

//MARK: - Default Implementation

extension BasicRobot {
    
    func launchApplication(file: StaticString = #file,
                           line: UInt = #line) {
        //Default: No-op
    }
}
