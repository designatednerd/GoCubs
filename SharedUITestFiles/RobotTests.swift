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
    
    //MARK: - Common test code
    
    func verifyAllOfChicagoWasNotDreaming() {
        //November 2, 2016: HOLY COW! Cubs won game 7 of the WORLD SERIES 8-7.
        self.listRobot.selectRow(forMonth: 11,
                                 day: 2,
                                 homeTeam: .Indians,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Cubs,
                                      runs: 8,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Indians,
                                     runs: 7,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinningAndLosingPitcherLabelsAreDisplayed(testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyCubsRecord(wins: 4,
                                          losses: 3,
                                          testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.worldSeries,
                                             testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWasSeriesWin(true,
                                            testInfo: self.currentLineTestInfo())
    }
    
    func verifyLeagueChampionshipSeriesWin() {
        //October 19: Cubs beat the Dodgers on the road 10-2, tying the NLCS 2-2
        self.listRobot.selectRow(forMonth: 10,
                                 day: 19,
                                 homeTeam: .Dodgers,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Cubs,
                                      runs: 10,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Dodgers,
                                     runs: 2,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinningAndLosingPitcherLabelsAreDisplayed(testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .win,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyCubsRecord(wins: 2,
                                          losses: 2,
                                          testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.leagueChampionshipSeries,
                                             testInfo: self.currentLineTestInfo())
    }
    
    func verifyDivisionSeriesLoss() {
        //October 10: Cubs lost to the Giants on the road 6-5, bringing the NLDS to 2-1
        self.listRobot.selectRow(forMonth: 10,
                                 day: 10,
                                 homeTeam: .Giants,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Giants,
                                      runs: 6,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Cubs,
                                     runs: 5,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinningAndLosingPitcherLabelsAreDisplayed(testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .loss,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyCubsRecord(wins: 2,
                                          losses: 1,
                                          testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.divisionSeries,
                                             testInfo: self.currentLineTestInfo())
    }
    
    func verifyTheFirstRegularSeasonTieInElevenYears() {
        //September 29: Cubs and the pirates tied(!) on the road 1-1
        self.listRobot.selectRow(forMonth: 9,
                                 day: 29,
                                 homeTeam: .Pirates,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyTieScoreAgainst(team: .Pirates,
                                               runs: 1,
                                               testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyCubsAndOpponentPitcherLabelsAreDisplayed(opposingTeam: .Pirates,
                                                                        testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .tie,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.regularSeason,
                                             testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownRegularSeasonWin() {
        //August 7: Cubs beat the Athletics on the road, 3-1
        self.listRobot.selectRow(forMonth: 8,
                                 day: 7,
                                 homeTeam: .Athletics,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .Cubs,
                                      runs: 3,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Athletics,
                                     runs: 1,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinningAndLosingPitcherLabelsAreDisplayed(testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .win,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.regularSeason,
                                             testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownRegularSeasonLoss() {
        //July 26: Cubs lost to the White Sox on the road 3-0
        self.listRobot.selectRow(forMonth: 7,
                                 day: 26,
                                 homeTeam: .WhiteSox,
                                 awayTeam: .Cubs,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinner(team: .WhiteSox,
                                      runs: 3,
                                      testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyLoser(team: .Cubs,
                                     runs: 0,
                                     testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyWinningAndLosingPitcherLabelsAreDisplayed(testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .loss,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.regularSeason,
                                            testInfo: self.currentLineTestInfo())
    }
    
    func verifyKnownRegularSeasonPostponement() {
        //May 9: Padres and Cubs were rained out at home
        self.listRobot.selectRow(forMonth: 5,
                                 day: 9,
                                 homeTeam: .Cubs,
                                 awayTeam: .Padres,
                                 testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyRainoutScoreAgainst(team: .Padres,
                                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyCubsAndOpponentPitcherLabelsAreDisplayed(opposingTeam: .Padres,
                                                                        testInfo: self.currentLineTestInfo())
        self.detailRobot.checkFlag(forResult: .postponed,
                                   testInfo: self.currentLineTestInfo())
        self.detailRobot.verifyPortionOfYear(.regularSeason,
                                             testInfo: self.currentLineTestInfo())
    }
}
