//
//  GoCubsUITests.swift
//  GoCubsUITests
//
//  Created by Ellen Shapiro (Vokal) on 10/12/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import XCTest

class GoCubsUITests: XCTestCase {
    
    //MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        // Stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // Launch the application to be tested.
        XCUIApplication.launch()
        
        // Set the initial state - such as interface orientation - required for tests before they run.
        XCUIDevice.sharedDevice().orientation = .Portrait

    }
    
    //MARK: - Helper methods
    
    private func checkResult(app: XCUIApplication,
        expectedWinningTeamName: String,
        expectedWinningTeamScore: String,
        expectedLosingTeamName: String,
        expectedLosingTeamScore: String) {
    
            
            XCTAssertEqual(app.staticTexts[AccessibilityString.winningTeamName].label, expectedWinningTeamName)
            XCTAssertEqual(app.staticTexts[AccessibilityString.losingTeamName].label, expectedLosingTeamName)

            XCTAssertEqual(app.staticTexts[AccessibilityString.winningTeamScore].label, expectedWinningTeamScore)
            
            XCTAssertEqual(app.staticTexts[AccessibilityString.losingTeamScore].label, expectedLosingTeamScore)
    }
    
    func checkIsPostseason(app: XCUIApplication, isPostseason: Bool) {
        let recordString = app.staticTexts[AccessibilityString.cubsRecord].label
        if isPostseason {
            XCTAssertTrue(recordString.containsString(LocalizedString.inThePostseason))
        } else {
            XCTAssertTrue(recordString.containsString(LocalizedString.onTheSeason))
        }
    }
    
    //MARK: - Actual Tests
    
    func testKnownPostseasonWin() {
        let app = XCUIApplication()
        
        //Select october 10 game
        let tablesQuery = app.tables
        tablesQuery.cells
            .containingType(.StaticText, identifier:"Oct 10")
            .staticTexts["Cubs vs. Cardinals"]
            .tap()
        
        //Cubs beat the cardinals 6-3 in this game
        checkResult(app,
            expectedWinningTeamName: "CUBS",
            expectedWinningTeamScore: "6",
            expectedLosingTeamName: "CARDINALS",
            expectedLosingTeamScore: "3")
        
        //Verify posteason verbiage
        checkIsPostseason(app, isPostseason: true)

        //Is the W showing
        XCTAssertTrue(app.staticTexts[AccessibilityString.cubsWin].exists)
    }
    
    func testKnownPostseasonLoss() {
        let app = XCUIApplication()
        
        //Select October 9 game
        let cubsVsCardinalsStaticText = app.tables[AccessibilityString.gamesTableview].cells.containingType(.StaticText, identifier:"Oct 9").staticTexts["Cubs vs. Cardinals"]
        cubsVsCardinalsStaticText.tap()
        
        //Cubs lost to the cardinals 4-0 in this game
        checkResult(app,
            expectedWinningTeamName: "CARDINALS",
            expectedWinningTeamScore: "4",
            expectedLosingTeamName: "CUBS",
            expectedLosingTeamScore: "0")
    
        checkIsPostseason(app, isPostseason: true)
        XCTAssertTrue(app.staticTexts[AccessibilityString.cubsLose].exists)
    }
    
    func testKnownRegularSeasonWin() {
        let app = XCUIApplication()
        
        //Select October 4 game
        app.tables[AccessibilityString.gamesTableview].cells.containingType(.StaticText, identifier:"Oct 4").staticTexts["Cubs vs. Brewers"].tap()
        
        //Cubs beat the brewers 3-1 in this game
        checkResult(app,
            expectedWinningTeamName: "CUBS",
            expectedWinningTeamScore: "3",
            expectedLosingTeamName: "BREWERS",
            expectedLosingTeamScore: "1")
        
        checkIsPostseason(app, isPostseason: false)

        XCTAssertTrue(app.staticTexts[AccessibilityString.cubsWin].exists)
    }
    
    func testKnownRegularSeasonLoss() {
    
    }
    
    func testKnownRegularSeasonPostponement() {
        
    }    
}
