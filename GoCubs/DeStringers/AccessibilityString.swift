//
//  AccessibilityString.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 10/12/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

enum AccessibilityString {
    static let cubsWin = NSLocalizedString("Cubs won!", comment: "Accessibility for win flag")
    static let cubsLose = NSLocalizedString("Cubs lost.", comment: "Accessibility for lose flag")
    static let postponed = NSLocalizedString("The game was postponed.", comment: "Accessibility for postponed flag")
    static let gamesTableview = NSLocalizedString("List of cubs games", comment: "Accessibilty games tableview")
    
    static let winningTeamScore = NSLocalizedString("Winning team's score", comment: "Accessibility for winning team score")
    static let winningTeamName = NSLocalizedString("Winning team's name", comment: "Accessibility for winning team name")
    
    static let losingTeamScore = NSLocalizedString("Losing team's score", comment: "Accessibility for losing team's score")
    static let losingTeamName = NSLocalizedString("Losing team's name", comment: "Accessibility for losing team's name")
    
    static let cubsRecord = NSLocalizedString("Cubs record", comment: "Accessibility string for the cubs record.")
}
    