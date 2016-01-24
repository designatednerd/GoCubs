//
//  GoCubsUITests.swift
//  GoCubsUITests
//
//  Created by Ellen Shapiro (Vokal) on 10/12/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import XCTest

class GoCubsUITests: XCTestCase {
  
  //MARK: - Test Lifecycle
  
  override func setUp() {
    super.setUp()    
    self.launchAppForUITesting()
  }
  
  //MARK: - Helper methods
  
  private func checkResult(app: XCUIApplication,
    expectedWinningTeamName: String,
    expectedWinningTeamScore: String,
    expectedLosingTeamName: String,
    expectedLosingTeamScore: String) {
      
      //Is the correct winning team name showing?
      XCTAssertEqual(app.staticTexts[AccessibilityIdentifier.WinningTeamName.rawValue].label, expectedWinningTeamName)
      
      //Is the correct losing team name showing?
      XCTAssertEqual(app.staticTexts[AccessibilityIdentifier.LosingTeamName.rawValue].label, expectedLosingTeamName)
      
      //Is the correct winning team score showing?
      XCTAssertEqual(app.staticTexts[AccessibilityIdentifier.WinningTeamScore.rawValue].label, expectedWinningTeamScore)
      
      //Is the corect losing team score showing?
      XCTAssertEqual(app.staticTexts[AccessibilityIdentifier.LosingTeamScore.rawValue].label, expectedLosingTeamScore)
  }
  
  func checkIsPostseason(app: XCUIApplication, isPostseason: Bool) {
    let recordString = app.staticTexts[AccessibilityIdentifier.CubsRecord.rawValue].label
    if isPostseason {
      let inThePostseason = LocalizedString.seasonStringForPostseason(true)
      XCTAssertTrue(recordString.containsString(inThePostseason))
    } else {
      let onTheSeason = LocalizedString.seasonStringForPostseason(false)
      XCTAssertTrue(recordString.containsString(onTheSeason))
    }
  }
  
  func selectGameOnDate(app: XCUIApplication,
    date: String,
    withVersusString versus: String) {
      app.tables[AccessibilityIdentifier.GamesTableview.rawValue]
        .cells
        .containingType(.StaticText, identifier:date)
        .staticTexts[versus]
        .tap()
  }
  
  //MARK: - Actual Tests
  
  func testKnownPostseasonWin() {
    let app = XCUIApplication()
    
    //Select october 10 game
    self.selectGameOnDate(app,
      date: "Oct 10",
      withVersusString: "Cubs vs. Cardinals")
    
    //Cubs beat the cardinals 6-3 in this game
    self.checkResult(app,
      expectedWinningTeamName: "CUBS",
      expectedWinningTeamScore: "6",
      expectedLosingTeamName: "CARDINALS",
      expectedLosingTeamScore: "3")
    
    //Verify posteason verbiage
    self.checkIsPostseason(app, isPostseason: true)
    
    //Is the W showing
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsWin].exists)
  }
  
  func testKnownPostseasonLoss() {
    let app = XCUIApplication()
    
    //Select October 9 game
    self.selectGameOnDate(app,
      date: "Oct 9",
      withVersusString: "Cubs vs. Cardinals")
    
    //Cubs lost to the cardinals 4-0 in this game
    self.checkResult(app,
      expectedWinningTeamName: "CARDINALS",
      expectedWinningTeamScore: "4",
      expectedLosingTeamName: "CUBS",
      expectedLosingTeamScore: "0")
    
    self.checkIsPostseason(app, isPostseason: true)
    
    //Is the L showing?
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsLose].exists)
  }
  
  func testKnownRegularSeasonWin() {
    let app = XCUIApplication()
    
    //Select October 4 game
    self.selectGameOnDate(app,
      date: "Oct 4",
      withVersusString: "Cubs vs. Brewers")
    
    //Cubs beat the brewers 3-1 in this game
    self.checkResult(app,
      expectedWinningTeamName: "CUBS",
      expectedWinningTeamScore: "3",
      expectedLosingTeamName: "BREWERS",
      expectedLosingTeamScore: "1")
    
    self.checkIsPostseason(app, isPostseason: false)
    
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsWin].exists)
  }
  
  func testKnownRegularSeasonLoss() {
    let app = XCUIApplication()

    //Select August 29 game
    self.selectGameOnDate(app,
      date: "Aug 29",
      withVersusString: "Cubs vs. Dodgers")
    
    //Cubs lost to the Dodgers 5-2 in this game
    self.checkResult(app,
      expectedWinningTeamName: "DODGERS",
      expectedWinningTeamScore: "5",
      expectedLosingTeamName: "CUBS",
      expectedLosingTeamScore: "2")
    
    self.checkIsPostseason(app, isPostseason: false)
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsLose].exists)
  }
  
  func testKnownRegularSeasonPostponement() {
    let app = XCUIApplication()
    
    //Select to September 10 game
    self.selectGameOnDate(app,
      date: "Sep 10",
      withVersusString: "Cubs vs. Phillies")
    
    //This game was rained out.
    self.checkResult(app,
      expectedWinningTeamName: "CUBS", //Cubs "Win" by default when a game is cancelled.
      expectedWinningTeamScore: "-",
      expectedLosingTeamName: "PHILLIES",
      expectedLosingTeamScore: "-")
    
    self.checkIsPostseason(app, isPostseason: false)
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.postponed].exists)
  }
}
