//
//  UIApplication+Testing.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

//PART3

extension UIApplication {
  
  /**
   - returns: true if the app is doing non-UI testing, false if not
   */
  static func isNonUITesting() -> Bool {
    return NSClassFromString("XCTestCase") != nil
  }
  
  /**
   - returns: true if the app is UI testing, false if not. 
   */
  static func isUITesting() -> Bool {    
    return LaunchEnvironmentKey.IsUITesting.processInfoValue() != nil
  }
}

//PART3
