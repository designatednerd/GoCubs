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
    var listRobot: GameListRobot! { get }
    var detailRobot: GameDetailRobot! { get }
}

extension RobotTests where Self: XCTestCase {
    
    //MARK: - Common test code
    
    func verifyAllOfChicagoWasNotDreaming() {
        //November 2, 2016: HOLY COW! Cubs won game 7 of the WORLD SERIES 8-7.
        self.listRobot
            .selectRow(forMonth: 11,
                       day: 2,
                       homeTeam: .Indians,
                       awayTeam: .Cubs)
        
        self.detailRobot
            .verifyWinner(team: .Cubs,
                          runs: 8)
            .verifyLoser(team: .Indians,
                         runs: 7)
            .verifyPitcherLabelsAreDisplayed(winningPitcherName: "Chapman",
                                             losingPitcherName: "Shaw")
            .verifyCubsRecord(wins: 4,
                              losses: 3)
            .verifyPortionOfYear(.worldSeries)
            .verifyWasSeriesWin(true)
    }
    
    func verifyLeagueChampionshipSeriesWin() {
        //October 19: Cubs beat the Dodgers on the road 10-2, tying the NLCS 2-2
        self.listRobot
            .selectRow(forMonth: 10,
                       day: 19,
                       homeTeam: .Dodgers,
                       awayTeam: .Cubs)
        
        self.detailRobot
            .verifyWinner(team: .Cubs,
                          runs: 10)
            .verifyLoser(team: .Dodgers,
                         runs: 2)
            .verifyPitcherLabelsAreDisplayed(winningPitcherName: "Montgomery",
                                             losingPitcherName: "Urias")
            .verifyFlag(showsResult: .win)
            .verifyCubsRecord(wins: 2,
                              losses: 2)
            .verifyPortionOfYear(.leagueChampionshipSeries)
    }
    
    func verifyDivisionSeriesLoss() {
        //October 10: Cubs lost to the Giants on the road 6-5, bringing the NLDS to 2-1
        self.listRobot
            .selectRow(forMonth: 10,
                       day: 10,
                       homeTeam: .Giants,
                       awayTeam: .Cubs)
        
        self.detailRobot
            .verifyWinner(team: .Giants,
                          runs: 6)
            .verifyLoser(team: .Cubs,
                         runs: 5)
            .verifyPitcherLabelsAreDisplayed(winningPitcherName: "Blach",
                                             losingPitcherName: "Montgomery")
            .verifyFlag(showsResult: .loss)
            .verifyCubsRecord(wins: 2,
                              losses: 1)
            .verifyPortionOfYear(.divisionSeries)
    }
    
    func verifyTheFirstRegularSeasonTieInElevenYears() {
        //September 29: Cubs and the pirates tied(!) on the road 1-1
        self.listRobot
            .selectRow(forMonth: 9,
                       day: 29,
                       homeTeam: .Pirates,
                       awayTeam: .Cubs)
        
        self.detailRobot
            .verifyTieScoreAgainst(team: .Pirates,
                                   runs: 1)
            .verifyNoResultPitcherLabelsAreDisplayed(cubsPitcherName: "Wood",
                                                     opponentPitcherName: "Nova",
                                                     opposingTeam: .Pirates)
            .verifyFlag(showsResult: .tie)
            .verifyPortionOfYear(.regularSeason)
    }
    
    func verifyKnownRegularSeasonWin() {
        //August 7: Cubs beat the Athletics on the road, 3-1
        self.listRobot
            .selectRow(forMonth: 8,
                       day: 7,
                       homeTeam: .Athletics,
                       awayTeam: .Cubs)
        
        self.detailRobot
            .verifyWinner(team: .Cubs,
                          runs: 3)
            .verifyLoser(team: .Athletics,
                         runs: 1)
            .verifyPitcherLabelsAreDisplayed(winningPitcherName: "Hendricks",
                                             losingPitcherName: "Manaea")
            .verifyFlag(showsResult: .win)
            .verifyPortionOfYear(.regularSeason)
    }
    
    func verifyKnownRegularSeasonLoss() {
        //July 26: Cubs lost to the White Sox on the road 3-0
        self.listRobot
            .selectRow(forMonth: 7,
                       day: 26,
                       homeTeam: .WhiteSox,
                       awayTeam: .Cubs)
        
        self.detailRobot
            .verifyWinner(team: .WhiteSox,
                          runs: 3)
            .verifyLoser(team: .Cubs,
                         runs: 0)
            .verifyPitcherLabelsAreDisplayed(winningPitcherName: "Shields",
                                             losingPitcherName: "Hendricks")
            .verifyFlag(showsResult: .loss)
            .verifyPortionOfYear(.regularSeason)
    }
    
    func verifyKnownRegularSeasonPostponement() {
        //May 9: Padres and Cubs were rained out at home
        self.listRobot
            .selectRow(forMonth: 5,
                       day: 9,
                       homeTeam: .Cubs,
                       awayTeam: .Padres)
        
        self.detailRobot
            .verifyRainoutScoreAgainst(team: .Padres)
            .verifyNoResultPitcherLabelsAreDisplayed(cubsPitcherName: "Strop",
                                                     opponentPitcherName: "Villanueva",
                                                     opposingTeam: .Padres)
            .verifyFlag(showsResult: .postponed)
            .verifyPortionOfYear(.regularSeason)
    }
}
