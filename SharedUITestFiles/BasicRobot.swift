//
//  BasicRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import UIKit
import XCTest

@testable import GoCubs

//MARK: - Basic Robot Protocol 

protocol BasicRobot {
    
    var currentTestCase: XCTestCase { get }
    
    @discardableResult
    func launchApplication(file: StaticString,
                           line: UInt) -> BasicRobot

    func tapButton(withAccessibilityLabel label: String,
                   file: StaticString,
                   line: UInt)
    
    func checkViewIsVisible(withAccessibilityLabel label: String,
                            file: StaticString,
                            line: UInt)
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: AccessibilityIdentifier,
                            file: StaticString,
                            line: UInt)
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: AccessibilityIdentifier,
                                 file: StaticString,
                                 line: UInt)
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: AccessibilityIdentifier,
                   file: StaticString,
                   line: UInt) -> String?
}

//MARK: - Default Implementation

extension BasicRobot {
    
    @discardableResult
    func launchApplication(file: StaticString = #file,
                           line: UInt = #line) -> BasicRobot {
        //Default: Don't do anything
        return self
    }
}
