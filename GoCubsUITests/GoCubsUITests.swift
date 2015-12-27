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
    self.cub_launchAppForUITesting()
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
  
  //MARK: - Actual Tests
  
  func testKnownPostseasonWin() {
    let app = XCUIApplication()
    
    //Select october 10 game
    let tablesQuery = app.tables
    tablesQuery.cells
      .containingType(.StaticText, identifier:"Oct 10")
      .staticTexts["Cubs vs. Cardinals"]
      .tap()
    
    //Cubs beat the cardinals 6-3 in this game
    checkResult(app,
      expectedWinningTeamName: "CUBS",
      expectedWinningTeamScore: "6",
      expectedLosingTeamName: "CARDINALS",
      expectedLosingTeamScore: "3")
    
    //Verify posteason verbiage
    checkIsPostseason(app, isPostseason: true)
    
    //Is the W showing
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsWin].exists)
  }
  
  func testKnownPostseasonLoss() {
    let app = XCUIApplication()
    
    //Select October 9 game
    let cubsVsCardinalsStaticText = app
      .tables[AccessibilityIdentifier.GamesTableview.rawValue]
      .cells
      .containingType(.StaticText, identifier:"Oct 9")
      .staticTexts["Cubs vs. Cardinals"]
    
    cubsVsCardinalsStaticText.tap()
    
    //Cubs lost to the cardinals 4-0 in this game
    checkResult(app,
      expectedWinningTeamName: "CARDINALS",
      expectedWinningTeamScore: "4",
      expectedLosingTeamName: "CUBS",
      expectedLosingTeamScore: "0")
    
    checkIsPostseason(app, isPostseason: true)
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsLose].exists)
  }
  
  func testKnownRegularSeasonWin() {
    let app = XCUIApplication()
    
    //Select October 4 game
    app.tables[AccessibilityIdentifier.GamesTableview.rawValue]
      .cells
      .containingType(.StaticText, identifier:"Oct 4")
      .staticTexts["Cubs vs. Brewers"]
      .tap()
    
    //Cubs beat the brewers 3-1 in this game
    checkResult(app,
      expectedWinningTeamName: "CUBS",
      expectedWinningTeamScore: "3",
      expectedLosingTeamName: "BREWERS",
      expectedLosingTeamScore: "1")
    
    checkIsPostseason(app, isPostseason: false)
    
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsWin].exists)
  }
  
  func testKnownRegularSeasonLoss() {
    let app = XCUIApplication()
    let listOfCubsGamesTable = app.tables["List of cubs games"]
    
    //Select August 29 game
    listOfCubsGamesTable.cells.containingType(.StaticText, identifier:"Aug 29").staticTexts["Cubs vs. Dodgers"].tap()
    
    //Cubs lost to the Dodgers 4-0 in this game
    checkResult(app,
      expectedWinningTeamName: "DODGERS",
      expectedWinningTeamScore: "5",
      expectedLosingTeamName: "CUBS",
      expectedLosingTeamScore: "2")
    
    checkIsPostseason(app, isPostseason: false)
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.cubsLose].exists)
  }
  
  func testKnownRegularSeasonPostponement() {
    
    let app = XCUIApplication()
    let listOfCubsGamesTable = app.tables["List of cubs games"]
    
    //Go to September 10 game
    let cubsVsPhilliesStaticText = listOfCubsGamesTable.cells.containingType(.StaticText, identifier:"Sep 10").childrenMatchingType(.StaticText).matchingIdentifier("Cubs vs. Phillies").elementBoundByIndex(0)
    cubsVsPhilliesStaticText.tap()
    
    //This game was rained out.
    checkResult(app,
      expectedWinningTeamName: "CUBS", //Cubs "Win" by default when a game is cancelled.
      expectedWinningTeamScore: "-",
      expectedLosingTeamName: "PHILLIES",
      expectedLosingTeamScore: "-")
    
    self.checkIsPostseason(app, isPostseason: false)
    XCTAssertTrue(app.staticTexts[AccessibilityLabel.postponed].exists)
  }
}
