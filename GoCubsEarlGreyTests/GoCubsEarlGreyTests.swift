//
//  GoCubsEarlGreyTests.swift
//  GoCubsEarlGreyTests
//
//  Created by Ellen Shapiro on 2/25/17.
//  Copyright © 2017 Vokal. All rights reserved.
//

import XCTest
import EarlGrey

class GoCubsEarlGreyTests: XCTestCase, RobotTests {
    
    var basicRobot = EarlGreyRobot()
    var listRobot: GameListRobot = EarlGreyRobot()
    var detailRobot: GameDetailRobot = EarlGreyRobot()
    
    //MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        self.listRobot.verifyOnGameList(testInfo: self.currentLineTestInfo())
    }
    
    override func tearDown() {
        (self.detailRobot as? EarlGreyRobot)?.goBackToList(testInfo: self.currentLineTestInfo())
        self.listRobot.verifyOnGameList(testInfo: self.currentLineTestInfo())
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

