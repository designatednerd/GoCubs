//
//  LaunchEnvironmentKey.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

//PART3

enum LaunchEnvironmentKey: String {
  case
  IsUITesting = "IS_UI_TESTING",
  MonthToTest = "CUBS_MONTH",
  DayToTest = "CUBS_DAY",
  YearToTest = "CUBS_YEAR"
  
  func isInLaunchArguments() -> Bool {
    return NSProcessInfo.processInfo().arguments.contains(rawValue)
  }
  
  func processInfoValue() -> String? {
    return NSProcessInfo.processInfo().environment[rawValue]
  }  
}

//PART3
