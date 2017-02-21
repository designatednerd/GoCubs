//
//  RobotTests.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Vokal. All rights reserved.
//

import Foundation
import XCTest
@testable import GoCubs 

protocol RobotTests {
    var basicRobot: BasicRobot { get }
    var listRobot: GameListRobot { get }
    var detailRobot: GameDetailRobot { get }
}

extension RobotTests where Self: XCTestCase {
    
    //MARK: - Helper Methods
    
    func currentLineTestInfo(file: StaticString = #file, line: UInt = #line) -> TestInfo {
        return TestInfo(testCase: self,
                        file: file,
                        line: line)
    }
    
    //MARK: - Test Lifecycle
    
    func launchToGameList() {
        self.basicRobot.launchApplication()
        self.listRobot.verifyOnGameList(testInfo: self.currentLineTestInfo())
    }
    
    //MARK: - Common test code
    
    func verifyKnownPostseasonWin() {
        //October 10: Cubs beat the Cardinals on the road, 6-3
        self.listRobot.selectRow(forMonth: 10,
                                 day: 10,
                                 homeTeam: .Cardinals,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Cubs,
                                      runs: 6,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Cardinals,
                                     runs: 3,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .win,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyIsPostseason(true,
                                            testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownPostseasonLoss() {
        //October 9: Cubs lost to the Cardinals on the road, 4-0
        self.listRobot.selectRow(forMonth: 10,
                                 day: 9,
                                 homeTeam: .Cardinals,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Cardinals,
                                      runs: 4,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Cubs,
                                     runs: 0,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .loss,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyIsPostseason(true,
                                            testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownRegularSeasonWin() {
        //October 4: Cubs beat the Brewers on the road, 3-1
        self.listRobot.selectRow(forMonth: 10,
                                 day: 4,
                                 homeTeam: .Brewers,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Cubs,
                                      runs: 3,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Brewers,
                                     runs: 1,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .win,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyIsPostseason(false,
                                            testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownRegularSeasonLoss() {
        //August 29: Cubs lost to the Dodgers on the road 5-2
        self.listRobot.selectRow(forMonth: 8,
                                 day: 29,
                                 homeTeam: .Dodgers,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Dodgers,
                                      runs: 5,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Cubs,
                                     runs: 2,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .loss,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyIsPostseason(false,
                                            testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownRegularSeasonPostponement() {
        //September 10: Cubs and Phillies were rained out on the road.
        self.listRobot.selectRow(forMonth: 9,
                                 day: 10,
                                 homeTeam: .Phillies,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyRainoutScoreAgainst(team: .Phillies,
                                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .postponed,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyIsPostseason(false,
                                            testInfo: self.currentLineTestInfo())
    }
    
}
