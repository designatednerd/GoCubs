//
//  Xcode7UITestingUITests.swift
//  Xcode7UITestingUITests
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import XCTest

class Xcode7UITestingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // Launch the application to be tested.
        XCUIApplication().launch()

        // TODO: Set the initial state - such as interface orientation - required for tests before they run. 
        
        XCTFail("WRITE YOU SOME UI TESTS!")
    }
}
