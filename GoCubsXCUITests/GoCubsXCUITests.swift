//
//  GoCubsUITests.swift
//  GoCubsUITests
//
//  Created by Ellen Shapiro on 10/12/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import XCTest

class GoCubsXCUITests: XCTestCase, RobotTests {
    
    var basicRobot: XCUIRobot!
    var listRobot: GameListRobot!
    var detailRobot: GameDetailRobot!

    override func setUp() {
        super.setUp()
        
        self.basicRobot = XCUIRobot(testCase: self)
        self.detailRobot = XCUIRobot(testCase: self)
        self.listRobot = XCUIRobot(testCase: self)

        self.continueAfterFailure = false
        self.basicRobot.launchApplication()
    }
    
    override func tearDown() {
        //NOTE: This must be cast or it will use the default implementation.
        (self.detailRobot as? XCUIRobot)?.goBackToList()
        self.listRobot.verifyOnGameList()
        
        self.listRobot = nil
        self.detailRobot = nil
        self.basicRobot = nil 
        
        super.tearDown()
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
