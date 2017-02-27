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
                                 testInfo: TestInfo) {
        let winnerText = self.labelText(forLabelWithAccessibilityIdentifier: AccessibilityString.winningTeamName,
                                        testInfo: testInfo)
        XCTAssertEqual(winnerText,
                       name.uppercased(),
                       file: testInfo.file,
                       line: testInfo.line)
    }
    
    private func checkWinnerScore(score: String,
                                  testInfo: TestInfo) {
        let winnerScoreText = self.labelText(forLabelWithAccessibilityIdentifier: AccessibilityString.winningTeamScore,
                                             testInfo: testInfo)
        XCTAssertEqual(winnerScoreText,
                       score,
                       file: testInfo.file,
                       line: testInfo.line)
    }
    
    private func checkLoserName(name: String,
                                testInfo: TestInfo) {
        let loserText = self.labelText(forLabelWithAccessibilityIdentifier: AccessibilityString.losingTeamName,
                                       testInfo: testInfo)
        XCTAssertEqual(loserText,
                       name.uppercased(),
                       file: testInfo.file,
                       line: testInfo.line)
    }
    
    private func checkLoserScore(score: String,
                                 testInfo: TestInfo) {
        let loserScoreText = self.labelText(forLabelWithAccessibilityIdentifier: AccessibilityString.losingTeamScore,
                                            testInfo: testInfo)
        
        XCTAssertEqual(loserScoreText,
                       score,
                       file: testInfo.file,
                       line: testInfo.line)
    }
    
    private func recordText(_ testInfo: TestInfo) -> String? {
        return self.labelText(forLabelWithAccessibilityIdentifier: AccessibilityString.cubsRecord,
                              testInfo: testInfo)
    }

    //MARK: - Public robot methods
    
    func verifyOnGameDetails(testInfo: TestInfo) {
        NSLog("Verify on game details")
        //Can we see both winning and losing team names
        self.checkViewIsVisible(withAccessibilityIdentifier: AccessibilityString.winningTeamName,
                         testInfo: testInfo)
        self.checkViewIsVisible(withAccessibilityIdentifier: AccessibilityString.losingTeamName,
                         testInfo: testInfo)
    }
    
    func verifyWinner(team: Team,
                      runs: Int,
                      testInfo: TestInfo) {
        NSLog("Verify winner")
        self.checkWinnerName(name: team.rawValue,
                             testInfo: testInfo)
        self.checkWinnerScore(score: String(runs),
                              testInfo: testInfo)
    }
    
    func verifyLoser(team: Team,
                     runs: Int,
                     testInfo: TestInfo) {
        NSLog("Verify loser")
        self.checkLoserName(name: team.rawValue,
                            testInfo: testInfo)
        self.checkLoserScore(score: String(runs),
                             testInfo: testInfo)
    }
    
    func checkFlag(forResult result: ResultType,
                   testInfo: TestInfo) {
        NSLog("Check Flag")
        self.checkViewIsVisible(withAccessibilityLabel: result.accessibilityString,
                                testInfo: testInfo)
    }
    
    func verifyRainoutScoreAgainst(team: Team,
                                   testInfo: TestInfo) {
        NSLog("Verify rainout")
        self.checkWinnerName(name: Team.Cubs.rawValue,
                             testInfo: testInfo)
        self.checkWinnerScore(score: LocalizedString.noResult,
                              testInfo: testInfo)
        self.checkLoserName(name: team.rawValue,
                            testInfo: testInfo)
        self.checkLoserScore(score: LocalizedString.noResult,
                             testInfo: testInfo)
    }
    
    func verifyTieScoreAgainst(team: Team,
                               runs: Int,
                          testInfo: TestInfo) {
        NSLog("Verify Tie")
        self.checkWinnerName(name: Team.Cubs.rawValue,
                             testInfo: testInfo)
        self.checkWinnerScore(score: String(runs),
                              testInfo: testInfo)
        self.checkLoserName(name: team.rawValue,
                            testInfo: testInfo)
        self.checkLoserScore(score: String(runs),
                             testInfo: testInfo)
    }
    
    func verifyWinningAndLosingPitcherLabelsAreDisplayed(testInfo: TestInfo) {
        NSLog("Verify winning and losing pitcher labels displayed")
        self.checkViewIsVisible(withAccessibilityLabel: LocalizedString.winningPitcher.uppercased(),
                                testInfo: testInfo)
        self.checkViewIsVisible(withAccessibilityLabel: LocalizedString.losingPitcher.uppercased(),
                                testInfo: testInfo)
    }
    
    func verifyCubsAndOpponentPitcherLabelsAreDisplayed(opposingTeam: Team,
                                                        testInfo: TestInfo) {
        NSLog("Verify cubs and opponent pitchers displayed")
        let cubsPitcher = LocalizedString.pitcher(for: Team.Cubs.rawValue).uppercased()
        self.checkViewIsVisible(withAccessibilityLabel: cubsPitcher,
                                testInfo: testInfo)
        let opponentPitcher = LocalizedString.pitcher(for: opposingTeam.rawValue).uppercased()
        self.checkViewIsVisible(withAccessibilityLabel: opponentPitcher,
                                testInfo: testInfo)
    }
    
    func goBackToList(testInfo: TestInfo) {
        NSLog("Go Back To List")
        self.tapButton(withAccessibilityLabel: "Back",
                       testInfo: testInfo)
    }
    
    func verifyWasSeriesWin(_ wasWin: Bool,
                            testInfo: TestInfo) {
        NSLog("Verify was series win")
        guard let recordText = self.recordText(testInfo) else {
            XCTFail("Couldn't get record text",
                    file: testInfo.file,
                    line: testInfo.line)
            return
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
                          file: testInfo.file,
                          line: testInfo.line)
        } else {
            XCTAssertFalse(recordText.contains(winSeriesString),
                           file: testInfo.file,
                           line: testInfo.line)
        }
    }
    
    func verifyPortionOfYear(_ portion: PortionOfYear,
                            testInfo: TestInfo) {
        NSLog("Verify portion of year")
        guard let recordText = self.recordText(testInfo) else {
            XCTFail("Could not get record text!",
                    file: testInfo.file,
                    line: testInfo.line)
            return
        }
        
        XCTAssertTrue(recordText.contains(portion.localizedName),
                      file: testInfo.file,
                      line: testInfo.line)
    }
    
    func verifyCubsRecord(wins: Int,
                          losses: Int,
                          testInfo: TestInfo) {
        NSLog("Verify Cubs Record")
        guard let recordText = self.recordText(testInfo) else {
            XCTFail("Could not get record text!",
                    file: testInfo.file,
                    line: testInfo.line)
            return
        }
        
        let expectedRecord = LocalizedString.recordString(wins: wins, losses: losses)
        XCTAssertTrue(recordText.contains(expectedRecord),
                      file: testInfo.file,
                      line: testInfo.line)
    }
}

