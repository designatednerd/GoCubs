//
//  GoCubsKIFTests.swift
//  GoCubsKIFTests
//
//  Created by Ellen Shapiro on 10/13/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import XCTest
import KIF

class GoCubsKIFTests: KIFTestCase, RobotTests {
    
    var basicRobot: KIFRobot!
    var listRobot: GameListRobot!
    var detailRobot: GameDetailRobot!
    
    //MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        
        self.basicRobot = KIFRobot(testCase: self)
        self.listRobot = KIFRobot(testCase: self)
        self.detailRobot = KIFRobot(testCase: self)

        self.listRobot.verifyOnGameList()
    }

    override func tearDown() {
        self.detailRobot.goBackToList()
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
