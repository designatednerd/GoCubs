//
//  GoCubsKIFTests.swift
//  GoCubsKIFTests
//
//  Created by Ellen Shapiro (Vokal) on 10/13/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import XCTest
import KIF

//Hey, would you look at that!
@testable import GoCubs

class GoCubsKIFTests: KIFTestCase {
    
    //MARK: Test Lifecycle
    
    override func afterEach() {
        //Back out of the list
        tester().tapViewWithAccessibilityLabel(LocalizedString.listTitle)

        super.afterEach()
    }
    
    //MARK: Helper methods
    
    private func checkResult(expectedWinningTeamName: String,
        expectedWinningTeamScore: String,
        expectedLosingTeamName: String,
        expectedLosingTeamScore: String) {
            
            //Find, unwrap, and cast all the labels
            if let winningTeamLabel = tester().waitForViewWithAccessibilityIdentifier(AccessibilityString.winningTeamName) as? UILabel,
                losingTeamNameLabel = tester().waitForViewWithAccessibilityIdentifier(AccessibilityString.losingTeamName) as? UILabel,
                winningTeamScoreLabel = tester().waitForViewWithAccessibilityIdentifier(AccessibilityString.winningTeamScore) as? UILabel,
                losingTeamScoreLabel = tester().waitForViewWithAccessibilityIdentifier(AccessibilityString.losingTeamScore) as? UILabel {
                    
                    //Check that the labels have the proper text.
                    XCTAssertEqual(winningTeamLabel.text, expectedWinningTeamName)
                    XCTAssertEqual(losingTeamNameLabel.text, expectedLosingTeamName)
                    XCTAssertEqual(winningTeamScoreLabel.text, expectedWinningTeamScore)
                    XCTAssertEqual(losingTeamScoreLabel.text, expectedLosingTeamScore)
            } else {
                XCTFail("One of the labels was not found!")
            }
    }
    
    private func checkIsPostseason(isPostseason: Bool) {
        if let recordLabel = tester().waitForViewWithAccessibilityIdentifier(AccessibilityString.cubsRecord) as? UILabel,
        recordString = recordLabel.text {
            if isPostseason {
                let inThePostseason = LocalizedString.seasonStringForPostseason(true)
                XCTAssertTrue(recordString.containsString(inThePostseason))
            } else {
                let onTheSeason = LocalizedString.seasonStringForPostseason(false)
                XCTAssertTrue(recordString.containsString(onTheSeason))
            }
        } else {
            XCTFail("Record label was not found or had no text!")
        }
    }
    
    //MARK: Actual Tests
    
    func testKnownPostseasonWin() {
        //Select october 10 game
        tester().tapRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0),
            inTableViewWithAccessibilityIdentifier: AccessibilityString.gamesTableview)
        
        //Is the W flag showing? 
        tester().waitForViewWithAccessibilityLabel(AccessibilityString.cubsWin)
        
        //Cubs beat the cardinals 6-3 in this game
        checkResult("CUBS",
            expectedWinningTeamScore: "6",
            expectedLosingTeamName: "CARDINALS",
            expectedLosingTeamScore: "3")
        
        //Verify posteason verbiage
        checkIsPostseason(true)
    }

    func testKnownPostseasonLoss() {
        
        //Select october 9 game
        tester().tapRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0),
            inTableViewWithAccessibilityIdentifier: AccessibilityString.gamesTableview)
        
        //Is the L flag showing? 
        tester().waitForViewWithAccessibilityLabel(AccessibilityString.cubsLose)
        
        //Cubs lost to the cardinals 4-0 in this game
        checkResult("CARDINALS",
            expectedWinningTeamScore: "4",
            expectedLosingTeamName: "CUBS",
            expectedLosingTeamScore: "0")
        
        //verify posteason verbiage
        checkIsPostseason(true)
    }
    
    
    func testKnownRegularSeasonPostponement() {
    
        //Select September 10 game
        tester().tapRowAtIndexPath(NSIndexPath(forRow: 29, inSection: 0),
            inTableViewWithAccessibilityIdentifier: AccessibilityString.gamesTableview)
        
        //Is the rain flag showing? 
        tester().waitForViewWithAccessibilityLabel(AccessibilityString.postponed)
        
        //Cubs and Phillies were postponed
        checkResult("CUBS",
            expectedWinningTeamScore: LocalizedString.noResult,
            expectedLosingTeamName: "PHILLIES",
            expectedLosingTeamScore: LocalizedString.noResult)
        
        //Verify regular season verbiage
        checkIsPostseason(false)
    }
}
