//
//  XCUIRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import XCTest
@testable import GoCubs 

struct XCUIRobot: BasicRobot {
    
    fileprivate let waitTimeout: TimeInterval = 5
    
    fileprivate var existsPredicate: NSPredicate {
        return NSPredicate(format: "exists == true")
    }
    
    func launchApplication(file: StaticString = #file,
                           line: UInt = #line) {
        XCUIApplication().launch()
        
        // Set the initial state - such as interface orientation - required for tests before they run.
        XCUIDevice.shared().orientation = .portrait
    }
    
    func tapButton(withAccessibilityLabel label: String,
                   testInfo: TestInfo) {
        let app = XCUIApplication()
        let buttonElement = app.buttons[label]
        testInfo.testCase.expectation(for: self.existsPredicate,
                             evaluatedWith: buttonElement)
        testInfo.testCase.waitForExpectations(timeout: 2) {
            error in
            XCTFail("Could not find button with accessibility label \(label). Error: \(error)",
                    file: testInfo.file,
                    line: testInfo.line)
        }

        buttonElement.tap()
    }
    
    func checkViewIsVisible(withAccessibilityLabel label: String,
                            testInfo: TestInfo) {
        let app = XCUIApplication()
        let labelElement = app.staticTexts[label]

        testInfo.testCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: labelElement)
        testInfo.testCase.waitForExpectations(timeout: self.waitTimeout)
    }
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: String,
                            testInfo: TestInfo) {
        let app = XCUIApplication()
        let labelElement = app.staticTexts[identifier]
        
        testInfo.testCase.expectation(for: self.existsPredicate,
                             evaluatedWith: labelElement)
        testInfo.testCase.waitForExpectations(timeout: self.waitTimeout)
    }
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: String,
                                 testInfo: TestInfo) {
        let app = XCUIApplication()
        let tableElement = app.tables[identifier]
        
        testInfo.testCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: tableElement)
        testInfo.testCase.waitForExpectations(timeout: self.waitTimeout)
    }
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   testInfo: TestInfo) -> String? {
        let app = XCUIApplication()
        let labelElement = app.staticTexts[identifier]
        
        testInfo.testCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: labelElement)
        testInfo.testCase.waitForExpectations(timeout: self.waitTimeout)
        
        return labelElement.label
    }
}

//MARK: - Game List Robot

extension XCUIRobot: GameListRobot {

    func tapCell(withDateText dateText: String,
                 gameText: String,
                 testInfo: TestInfo) {
        let app = XCUIApplication()
        let tableElement = app.tables[AccessibilityString.gamesTableview]
        
        testInfo.testCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: tableElement)
        testInfo.testCase.waitForExpectations(timeout: self.waitTimeout)
        
        let cellElement = tableElement.cells
            .containing(.staticText, identifier: dateText)
            .staticTexts[gameText]
        
        testInfo.testCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: cellElement)
        testInfo.testCase.waitForExpectations(timeout: self.waitTimeout)
        
        cellElement.tap()
    }
}

//MARK: - Game Detail Robot

extension XCUIRobot: GameDetailRobot { /* mix-in */ }
