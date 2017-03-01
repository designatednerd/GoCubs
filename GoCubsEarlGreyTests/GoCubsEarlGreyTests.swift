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
    
    var basicRobot: EarlGreyRobot!
    var listRobot: GameListRobot!
    var detailRobot: GameDetailRobot!
    
    //MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        self.basicRobot = EarlGreyRobot(testCase: self)
        self.listRobot = EarlGreyRobot(testCase: self)
        self.detailRobot = EarlGreyRobot(testCase: self)        
        self.listRobot.verifyOnGameList()
    }
    
    override func tearDown() {
        //NOTE: This must be cast or it will use the default implementation, which Earl doesn't seem to like.
        (self.detailRobot as? EarlGreyRobot)?.goBackToList()
        self.listRobot.verifyOnGameList()
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

