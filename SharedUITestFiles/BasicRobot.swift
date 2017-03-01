//
//  BasicRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import UIKit
import XCTest

//MARK: - Basic Robot Protocol 

protocol BasicRobot {
    
    var currentTestCase: XCTestCase { get }
    
    func launchApplication(file: StaticString,
                           line: UInt)

    func tapButton(withAccessibilityLabel label: String,
                   file: StaticString,
                   line: UInt)
    
    func checkViewIsVisible(withAccessibilityLabel label: String,
                            file: StaticString,
                            line: UInt)
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: String,
                            file: StaticString,
                            line: UInt)
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: String,
                                 file: StaticString,
                                 line: UInt)
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   file: StaticString,
                   line: UInt) -> String?
}

//MARK: - Default Implementation

extension BasicRobot {
    
    func launchApplication(file: StaticString = #file,
                           line: UInt = #line) {
        //Default: No-op
    }
}
