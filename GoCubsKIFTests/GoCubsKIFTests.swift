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
    
    var basicRobot: BasicRobot = KIFRobot()
    var listRobot: GameListRobot = KIFRobot()
    var detailRobot: GameDetailRobot = KIFRobot()
    
    //MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        self.listRobot.verifyOnGameList(testInfo: self.currentLineTestInfo())
    }

    override func tearDown() {
        self.detailRobot.goBackToList(testInfo: self.currentLineTestInfo())
        self.listRobot.verifyOnGameList(testInfo: self.currentLineTestInfo())
        super.tearDown()
    }
    
    //MARK: - Actual Tests
    
    func testKnownPostseasonWin() {
        self.verifyKnownPostseasonWin()
    }
    
    func testKnownPostseasonLoss() {
        self.verifyKnownPostseasonLoss()
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
