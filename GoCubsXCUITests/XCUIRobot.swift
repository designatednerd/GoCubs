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
    
    var currentTestCase: XCTestCase
    
    static var app: XCUIApplication!
    
    init(testCase: XCTestCase) {
        self.currentTestCase = testCase
    }
    
    fileprivate let waitTimeout: TimeInterval = 5
    
    fileprivate var existsPredicate: NSPredicate {
        return NSPredicate(format: "exists == true")
    }
    
    func launchApplication(file: StaticString = #file,
                           line: UInt = #line) {
        if XCUIRobot.app == nil {
            let app = XCUIApplication()
            app.launch()
            XCUIRobot.app = app
        }
        
        // Set the initial state - such as interface orientation - required for tests before they run.
        XCUIDevice.shared.orientation = .portrait
    }
    
    func tapButton(withAccessibilityLabel label: String,
                   file: StaticString,
                   line: UInt) {
        let app = XCUIApplication()
        let buttonElement = app.buttons[label]
        self.currentTestCase.expectation(for: self.existsPredicate,
                                         evaluatedWith: buttonElement)
        self.currentTestCase.waitForExpectations(timeout: 2) {
            error in
            XCTFail("Could not find button with accessibility label \(label). Error: \(String(describing: error))",
                    file: file,
                    line: line)
        }

        buttonElement.tap()
    }
    
    func checkViewIsVisible(withAccessibilityLabel label: String,
                            file: StaticString,
                            line: UInt) {
        let app = XCUIApplication()
        let labelElement = app.staticTexts[label]

        self.currentTestCase.expectation(for: self.existsPredicate,
                                         evaluatedWith: labelElement)
        self.currentTestCase.waitForExpectations(timeout: self.waitTimeout)
    }
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: AccessibilityIdentifier,
                            file: StaticString,
                            line: UInt) {
        let app = XCUIApplication()
        let labelElement = app.staticTexts[identifier.rawValue]
        
        self.currentTestCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: labelElement)
        self.currentTestCase.waitForExpectations(timeout: self.waitTimeout)
    }
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: AccessibilityIdentifier,
                                 file: StaticString,
                                 line: UInt) {
        let app = XCUIApplication()
        let tableElement = app.tables[identifier.rawValue]
        
        self.currentTestCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: tableElement)
        self.currentTestCase.waitForExpectations(timeout: self.waitTimeout)
    }
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: AccessibilityIdentifier,
                   file: StaticString,
                   line: UInt) -> String? {
        let app = XCUIApplication()
        let labelElement = app.staticTexts[identifier.rawValue]
        
        self.currentTestCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: labelElement)
        self.currentTestCase.waitForExpectations(timeout: self.waitTimeout)
        
        return labelElement.label
    }
}

//MARK: - Game List Robot

extension XCUIRobot: GameListRobot {

    @discardableResult
    func tapCell(withDateText dateText: String,
                 gameText: String,
                 file: StaticString,
                 line: UInt) -> GameListRobot {
        let app = XCUIApplication()
        let tableElement = app.tables[AccessibilityIdentifier.games_table_view.rawValue]
        
        self.currentTestCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: tableElement)
        self.currentTestCase.waitForExpectations(timeout: self.waitTimeout)
        
        let cellElement = tableElement.cells
            .containing(.staticText, identifier: dateText)
            .staticTexts[gameText]
        
        self.currentTestCase.expectation(for: self.existsPredicate,
                                      evaluatedWith: cellElement)
        self.currentTestCase.waitForExpectations(timeout: self.waitTimeout)
        
        cellElement.tap()
        
        return self 
    }
}

//MARK: - Game Detail Robot conformance

extension XCUIRobot: GameDetailRobot {
    
    @discardableResult
    func goBackToList(file: StaticString = #file,
                      line: UInt = #line) -> GameDetailRobot {
        let app = XCUIApplication()
        app.navigationBars
            .buttons[LocalizedString.listTitle]
            .tap()        
        return self
    }
}
