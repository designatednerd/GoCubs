//
//  GoCubsUITests.swift
//  GoCubsUITests
//
//  Created by Ellen Shapiro on 10/12/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import XCTest

class GoCubsXCUITests: XCTestCase, RobotTests {
    
    var basicRobot: XCUIRobot = XCUIRobot()
    var listRobot: GameListRobot = XCUIRobot()
    var detailRobot: GameDetailRobot = XCUIRobot()

    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        self.basicRobot.launchApplication()
    }
    
    //MARK: - Actual Tests
    
    func testWorldSeriesGame7() {
        self.verifyAllOfChicagoWasNotDreaming()
    }
    
    func testNLCSGameWin() {
        self.verifyLeagueChampionshipSeriesWin()
    }
    
    func testNLDSGameLoss() {
        self.verifyDivisionSeriesLoss()
    }
    
    func testKnownRegularSeasonTie() {
        self.verifyTheFirstRegularSeasonTieInElevenYears()
    }
    
    func testKnownRegularSeasonWin() {
        self.verifyKnownRegularSeasonWin()
    }
    
    func testKnownRegularSeasonLoss() {
        self.verifyKnownRegularSeasonLoss()
    }
    
    func testKnownRegularSeasonPostponement() {
        self.verifyKnownRegularSeasonPostponement()
    }
}
