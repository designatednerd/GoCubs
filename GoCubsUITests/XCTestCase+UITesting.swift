//
//  XCTestCase+UITesting.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import XCTest

extension XCTestCase {

  /**
   Fires up the app to test with a UI testing key and optionally other info for mocking.
   
   - parameter additionalInfo: Any additional info for mocking. Defaults to nil.
   */
  func launchAppForUITesting(withAdditionalInfo additionalInfo: [String : String]? = nil) {
    // Stop immediately when a failure occurs.
    continueAfterFailure = false
    
    //Grab a reference to the app
    let app = XCUIApplication()
    
    //Set up the launch environment so the app knows it's testing and has
    //whatever other info it needs.
    var launchEnvironment = [ LaunchEnvironmentKey.IsUITesting.rawValue : "yep"]
  
    if let additionalInfo = additionalInfo {
      for (key, value) in additionalInfo {
        launchEnvironment[key] = value
      }
    }
    
    app.launchEnvironment = launchEnvironment
    
    // Launch the application to be tested.
    app.launch()
    
    // Set the initial state - such as interface orientation - required for tests before they run.
    XCUIDevice.sharedDevice().orientation = .Portrait
  }
}
