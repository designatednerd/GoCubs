//
//  LaunchEnvironmentKey.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

enum LaunchEnvironmentKey: String {
  case
  IsUITesting = "IS_UI_TESTING",
  MonthToTest = "CUBS_MONTH",
  DayToTest = "CUBS_DAY",
  YearToTest = "CUBS_YEAR"
  
  func processInfoValue() -> String? {
    return NSProcessInfo.processInfo().environment[self.rawValue]
  }  
}
