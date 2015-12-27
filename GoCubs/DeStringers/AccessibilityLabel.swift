//
//  AccessibilityLabel.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 10/12/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

/**
 A centralized place to store strings for accessibility labels so you can refer 
 to them in both the application and tests. 
 
 These are strings which might potentially be read out loud to the user, so they 
 must be localized so that blind users don't randomly hear the developer's language 
 instead of their own.
 
 NOTE: This is an enum instead of a class or a struct so it can't be instantiated, 
       but since enums must be created with a raw value, you can't make cases using
       NSLocalizedString. Therefore, each of the labels is a static let property.
 */
enum AccessibilityLabel {  
  
  //MARK: Flag
  
  static let cubsWin = NSLocalizedString("Cubs won!",
    comment: "Accessibility for win flag")
  
  static let cubsLose = NSLocalizedString("Cubs lost.",
    comment: "Accessibility for lose flag")
  
  static let postponed = NSLocalizedString("The game was postponed.",
    comment: "Accessibility for postponed flag")

  //MARK: Buttons
  
  static let closeButton = NSLocalizedString("Close",
    comment: "Accessibility for close button")
}
    