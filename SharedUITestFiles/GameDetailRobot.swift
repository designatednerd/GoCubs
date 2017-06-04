//
//  GameDetailRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import UIKit
import XCTest

//NOTE: @testable imports will no-op in XCUI bundles.
// Any file you use from the main app should also be added to the XCUI target.
@testable import GoCubs

//MARK: - Game Detail Robot Protocol

protocol GameDetailRobot: BasicRobot {
    // No methods without default implementations
}

//MARK: - Game Detail Robot Default Implementation

extension GameDetailRobot {
    
    //MARK: - Reusable private methods
    
    private func checkWinnerName(name: String,
                                 file: StaticString,
                                 line: UInt) {
        let winnerText = self.labelText(forLabelWithAccessibilityIdentifier: .winning_team_name,
                                        file: file,
                                        line: line)
        XCTAssertEqual(winnerText,
                       name.uppercased(),
                       file: file,
                       line: line)
    }
    
    private func checkWinnerScore(score: String,
                                  file: StaticString,
                                  line: UInt) {
        let winnerScoreText = self.labelText(forLabelWithAccessibilityIdentifier: .winning_score,
                                             file: file,
                                             line: line)
        XCTAssertEqual(winnerScoreText,
                       score,
                       file: file,
                       line: line)
    }
    
    private func checkLoserName(name: String,
                                file: StaticString,
                                line: UInt) {
        let loserText = self.labelText(forLabelWithAccessibilityIdentifier: .losing_team_name,
                                       file: file,
                                       line: line)
        XCTAssertEqual(loserText,
                       name.uppercased(),
                       file: file,
                       line: line)
    }
    
    private func checkLoserScore(score: String,
                                 file: StaticString,
                                 line: UInt) {
        let loserScoreText = self.labelText(forLabelWithAccessibilityIdentifier: .losing_score,
                                            file: file,
                                            line: line)
        
        XCTAssertEqual(loserScoreText,
                       score,
                       file: file,
                       line: line)
    }
    
    private func recordText(file: StaticString,
                            line: UInt) -> String? {
        return self.labelText(forLabelWithAccessibilityIdentifier: .cubs_record,
                              file: file,
                              line: line)
    }

    //MARK: - Public robot methods
    
    //MARK: Actions
    
    @discardableResult
    func goBackToList(file: StaticString = #file, line: UInt = #line) -> GameDetailRobot {
        NSLog("Go Back To List")
        self.tapButton(withAccessibilityLabel: "Back",
                       file: file,
                       line: line)
        return self
    }
    
    //MARK: Verifiers
    
    @discardableResult
    func verifyOnGameDetails(file: StaticString = #file, line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify on game details")
        //Can we see both winning and losing team names
        self.checkViewIsVisible(withAccessibilityIdentifier: .winning_team_name,
                                file: file,
                                line: line)
        self.checkViewIsVisible(withAccessibilityIdentifier: .losing_team_name,
                                file: file,
                                line: line)
        return self
    }

    @discardableResult
    func verifyWinner(team: Team,
                      runs: Int,
                      file: StaticString = #file,
                      line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify winner")
        self.checkWinnerName(name: team.rawValue,
                             file: file,
                             line: line)
        self.checkWinnerScore(score: String(runs),
                              file: file,
                              line: line)
        return self
    }
    
    @discardableResult
    func verifyLoser(team: Team,
                     runs: Int,
                     file: StaticString = #file,
                     line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify loser")
        self.checkLoserName(name: team.rawValue,
                            file: file,
                            line: line)
        self.checkLoserScore(score: String(runs),
                             file: file,
                             line: line)
        return self
    }
    
    @discardableResult
    func verifyFlag(showsResult result: ResultType,
                   file: StaticString = #file,
                   line: UInt = #line) -> GameDetailRobot {
        NSLog("Check Flag")
        self.checkViewIsVisible(withAccessibilityLabel: result.accessibilityString,
                                file: file,
                                line: line)
        return self
    }
    
    @discardableResult
    func verifyRainoutScoreAgainst(team: Team,
                                   file: StaticString = #file,
                                   line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify rainout")
        self.checkWinnerName(name: Team.Cubs.rawValue,
                             file: file,
                             line: line)
        self.checkWinnerScore(score: LocalizedString.noResult,
                              file: file,
                              line: line)
        self.checkLoserName(name: team.rawValue,
                            file: file,
                            line: line)
        self.checkLoserScore(score: LocalizedString.noResult,
                             file: file,
                             line: line)
        return self
    }
    
    @discardableResult
    func verifyTieScoreAgainst(team: Team,
                               runs: Int,
                               file: StaticString = #file,
                               line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify Tie")
        self.checkWinnerName(name: Team.Cubs.rawValue,
                             file: file,
                             line: line)
        self.checkWinnerScore(score: String(runs),
                              file: file,
                              line: line)
        self.checkLoserName(name: team.rawValue,
                            file: file,
                            line: line)
        self.checkLoserScore(score: String(runs),
                             file: file,
                             line: line)
        
        return self
    }
    
    @discardableResult
    func verifyPitcherLabelsAreDisplayed(winningPitcherName: String,
                                         losingPitcherName: String,
                                         file: StaticString = #file,
                                         line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify winning and losing pitcher labels displayed")
        self.checkViewIsVisible(withAccessibilityLabel: LocalizedString.winningPitcher.uppercased(),
                                file: file,
                                line: line)
        let retrievedWinningPitcherName = self.labelText(forLabelWithAccessibilityIdentifier: .winning_pitcher_name,
                                                         file: file,
                                                         line: line)
        XCTAssertEqual(retrievedWinningPitcherName,
                       winningPitcherName,
                       file: file,
                       line: line)
        
        self.checkViewIsVisible(withAccessibilityLabel: LocalizedString.losingPitcher.uppercased(),
                                file: file,
                                line: line)
        let retrievedLosingPitcherName = self.labelText(forLabelWithAccessibilityIdentifier: .losing_pitcher_name,
                                                        file: file,
                                                        line: line)
        XCTAssertEqual(retrievedLosingPitcherName,
                       losingPitcherName,
                       file: file,
                       line: line)
        
        return self
    }
    
    @discardableResult
    func verifyNoResultPitcherLabelsAreDisplayed(cubsPitcherName: String,
                                         opponentPitcherName: String,
                                         opposingTeam: Team,
                                                        file: StaticString = #file,
                                                        line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify cubs and opponent pitchers displayed when there is no winner or loser (ie, rainouts and ties)")
        let cubsPitcher = LocalizedString.pitcher(for: Team.Cubs.rawValue).uppercased()
        self.checkViewIsVisible(withAccessibilityLabel: cubsPitcher,
                                file: file,
                                line: line)
        self.checkViewIsVisible(withAccessibilityLabel: cubsPitcherName,
                                file: file,
                                line: line)
        // Cubs "win" any game with no result. 
        let retrievedCubsPitcherName = self.labelText(forLabelWithAccessibilityIdentifier: .winning_pitcher_name,
                                                      file: file,
                                                      line: line)
        XCTAssertEqual(retrievedCubsPitcherName,
                       cubsPitcherName,
                       file: file,
                       line: line)        
        
        let opponentPitcher = LocalizedString.pitcher(for: opposingTeam.rawValue).uppercased()
        self.checkViewIsVisible(withAccessibilityLabel: opponentPitcher,
                                file: file,
                                line: line)
        let retrievedOpponentPitcherName = self.labelText(forLabelWithAccessibilityIdentifier: .losing_pitcher_name,
            file: file,
            line: line)
        XCTAssertEqual(retrievedOpponentPitcherName,
                       opponentPitcherName,
                       file: file,
                       line: line)
        return self
    }
    
    @discardableResult
    func verifyWasSeriesWin(_ wasWin: Bool,
                            file: StaticString = #file,
                            line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify was series win")
        guard let recordText = self.recordText(file: file, line: line) else {
            XCTFail("Couldn't get record text",
                    file: file,
                    line: line)
            return self
        }
        
        let winFormat = LocalizedString.winSeriesFormat
        var hitFormat = false
        let nonFormatWords = winFormat
            .components(separatedBy: " ")
            .filter {
                word in
                guard !hitFormat else {
                    return false
                }
                
                hitFormat = word.contains("%")
                return !hitFormat
        }
        
        let winSeriesString = nonFormatWords.joined(separator: " ")
        
        if wasWin {
            XCTAssertTrue(recordText.contains(winSeriesString),
                          file: file,
                          line: line)
        } else {
            XCTAssertFalse(recordText.contains(winSeriesString),
                           file: file,
                           line: line)
        }
        
        return self
    }
    
    @discardableResult
    func verifyPortionOfYear(_ portion: PortionOfYear,
                             file: StaticString = #file,
                             line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify portion of year")
        guard let recordText = self.recordText(file: file, line: line) else {
            XCTFail("Could not get record text!",
                    file: file,
                    line: line)
            return self
        }
        
        XCTAssertTrue(recordText.contains(portion.localizedName),
                      file: file,
                      line: line)
        
        return self
    }
    
    @discardableResult
    func verifyCubsRecord(wins: Int,
                          losses: Int,
                          file: StaticString = #file,
                          line: UInt = #line) -> GameDetailRobot {
        NSLog("Verify Cubs Record")
        guard let recordText = self.recordText(file: file, line: line) else {
            XCTFail("Could not get record text!",
                    file: file,
                    line: line)
            return self
        }
        
        let expectedRecord = LocalizedString.recordString(wins: wins, losses: losses)
        XCTAssertTrue(recordText.contains(expectedRecord),
                      file: file,
                      line: line)
        return self 
    }
}

