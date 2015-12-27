//
//  GameTodayUITests.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import XCTest

class GameTodayUITests: XCTestCase {
  
  //MARK: - Helper methods
  
  private func launchAppWithMonth(month: Int, day: Int, year: Int) {
    self.cub_launchAppForUITesting(withAdditionalInfo: [
      LaunchEnvironmentKey.MonthToTest.rawValue: String(month),
      LaunchEnvironmentKey.DayToTest.rawValue: String(day),
      LaunchEnvironmentKey.YearToTest.rawValue: String(year),
      ]
    )
  }
  
  private func dateStringForMonth(month: Int, day: Int, year: Int) -> String {
    //Use the same date formatter and calendar as the main app to create and make a string out of the date.
    let components = NSDateComponents()
    components.month = month
    components.day = day
    components.year = year
    guard let date = NSCalendar.cub_chicagoCalendar.dateFromComponents(components) else {
      XCTFail("Couldn't create date from components!")
      return ""
    }
    
    return NSDateFormatter.cub_longDateFormatter.stringFromDate(date)
  }
  
  func tapGameTodayBarButton(app: XCUIApplication) {
    app.navigationBars["Cubs 2015 Games"]
      .buttons[LocalizedString.gameTodayTitle]
      .tap()
  }
  
  func checkDataAsExpectedForMonth(month: Int, day: Int, year: Int,
    expectedYesOrNo: String,
    expectedDescription: String) {
      
      //Get the app and tap the game today bar.
      let app = XCUIApplication()
      self.tapGameTodayBarButton(app)
      
      //Does all the correct info display?
      XCTAssertTrue(app.staticTexts[LocalizedString.gameTodayTitle].exists)

      let dateString = self.dateStringForMonth(month, day: day, year: year)
      XCTAssertTrue(app.staticTexts[dateString].exists)
      
      XCTAssertTrue(app.staticTexts[expectedYesOrNo].exists)
      XCTAssertTrue(app.staticTexts[expectedDescription].exists)
      
      //Close out the Game Today view.
      app.buttons[AccessibilityLabel.closeButton].tap()
      
      //Is it gone?
      XCTAssertFalse(app.buttons[AccessibilityLabel.closeButton].exists)
  }
  
  //MARK: - Tests
  
  func testDisplayingEventAtWrigley() {
    //There was a game on April 5th, 2015.
    let month = 4
    let day = 5
    let year = 2015
    self.launchAppWithMonth(month, day: day, year: year)
    
    self.checkDataAsExpectedForMonth(month, day: day, year: year,
      expectedYesOrNo: LocalizedString.gameTodayPositive,
      expectedDescription: "FINAL: St. Louis Cardinals 3 - Chicago Cubs 0 Winning Pitcher: Wainwright, Adam Losing Pitcher: Lester, Jon")
  }
  
  func testDisplayingEventNotAtWrigley() {
    //As of the date the calendar on disk was added, there will be a game, 
    //but not at Wrigley, on June 30th 2016.
    let month = 6
    let day = 30
    let year = 2016
    self.launchAppWithMonth(month, day: day, year: year)
    
    self.checkDataAsExpectedForMonth(month, day: day, year: year,
      expectedYesOrNo: LocalizedString.gameTodayNegative,
      expectedDescription: "Chicago Cubs vs. New York Mets First pitch: 7:10:00 PM EDT Citi Field, Flushing")
  }
  
  func testDisplayingADayWithNoEvent() {
    //There was no game on xmas 2015.
    let month = 12
    let day = 25
    let year = 2015
    self.launchAppWithMonth(month, day: day, year: year)
    
    self.checkDataAsExpectedForMonth(month, day: day, year: year,
      expectedYesOrNo: LocalizedString.gameTodayNegative,
      expectedDescription: LocalizedString.noGameDetail)
  }
}
