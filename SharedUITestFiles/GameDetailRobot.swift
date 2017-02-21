//
//  GameDetailRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import UIKit
import XCTest
@testable import GoCubs

protocol GameDetailRobot: GameListRobot {
    
}

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
        let loserScoreText = self.labelText(forLabelWithAccessibilityIdentifier:  AccessibilityString.losingTeamScore,
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
        self.waitForView(withAccessibilityIdentifier: AccessibilityString.winningTeamName,
                         testInfo: testInfo)
        self.waitForView(withAccessibilityIdentifier: AccessibilityString.losingTeamName,
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
        self.waitForLabel(withText: result.accessibilityString,
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
    
    func goBackToList(testInfo: TestInfo) {
        NSLog("Go back to list")
        self.tapButton(withAccessibilityLabel: "Back",
                       testInfo: testInfo)
    }
    
    func verifyIsPostseason(_ isPostseason: Bool,
                            testInfo: TestInfo) {
        NSLog("Verify is postseason")
        guard let recordText = self.recordText(testInfo) else {
            XCTFail("Could not get record text!",
                    file: testInfo.file,
                    line: testInfo.line)
            return
        }
        
        let expectedToContain: String
        if isPostseason {
            expectedToContain = LocalizedString.postseasonString
        } else {
            expectedToContain = LocalizedString.regularSeasonString
        }
        
        XCTAssertTrue(recordText.contains(expectedToContain),
                      file: testInfo.file,
                      line: testInfo.line)
    }
    
    func verifyCubsRecord(wins: Int,
                          losses: Int,
                          testInfo: TestInfo) {
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

