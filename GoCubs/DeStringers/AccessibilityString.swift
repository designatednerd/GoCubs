//
//  AccessibilityString.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 10/12/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

/**
 A centralized place to store accessibility strings so you can refer to them in both
 the application and tests. Accessiblity strings which might potentially be read
 to the user should be localized so that blind users don't randomly hear the
 developer's language instead of their own.
 
 NOTE: This is an enum instead of a class or a struct so it can't be instantiated.
 */
enum AccessibilityString {
  
  //MARK: - Detail Accessibility
  
  static let winningTeamScore = NSLocalizedString("Winning team's score",
    comment: "Accessibility for winning team score")
  
  static let winningTeamName = NSLocalizedString("Winning team's name",
    comment: "Accessibility for winning team name")
  
  static let losingTeamScore = NSLocalizedString("Losing team's score",
    comment: "Accessibility for losing team's score")
  
  static let losingTeamName = NSLocalizedString("Losing team's name",
    comment: "Accessibility for losing team's name")
  
  static let cubsRecord = NSLocalizedString("Cubs record",
    comment: "Accessibility string for the cubs record.")
  
  //MARK: Flag
  
  static let cubsWin = NSLocalizedString("Cubs won!",
    comment: "Accessibility for win flag")
  
  static let cubsLose = NSLocalizedString("Cubs lost.",
    comment: "Accessibility for lose flag")
  
  static let postponed = NSLocalizedString("The game was postponed.",
    comment: "Accessibility for postponed flag")
  
  //MARK: - Table View accessibility
  
  static let gamesTableview = NSLocalizedString("List of cubs games",
    comment: "Accessibilty games tableview")
  
  //MARK: Game Today accessibility
  
  static let closeButton = NSLocalizedString("Close",
    comment: "Accessibility for close button")
}
    