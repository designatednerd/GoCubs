//
//  AccessibilityIdentifier.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

/**
 A centralized place to store strings for accessibility identifiers so you 
 can refer to them in both the application and tests. These are strings which 
 won't be read out loud to the user, so they don't need to be localized.
 */
enum AccessibilityIdentifier: String {
  case
  WinningTeamScore = "Winning team's score",
  WinningTeamName = "Winning team's name",
  LosingTeamScore = "Losing team's score",
  LosingTeamName = "Losing team's name",
  CubsRecord = "Cubs record",
  GamesTableview = "List of cubs games"
}
