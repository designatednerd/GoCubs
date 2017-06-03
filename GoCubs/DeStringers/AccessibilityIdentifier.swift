//
//  AccessibilityIdentifier.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 6/3/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import Foundation

/**
 A centralized place to store accessibility identifiers so you can refer to them 
 in both the application and tests. 
 
 Accessibility Identifiers differ from Accessibility Labels in that they are only
 visible to tests and are not picked up by VoiceOver, so they do not need to be 
 localized, allowing us to use a simple enum. 
 */
enum AccessibilityIdentifier: String {
    case
    cubs_record,
    games_table_view,
    losing_pitcher_name,
    losing_score,
    losing_team_name,
    winning_pitcher_name,
    winning_score,
    winning_team_name
}
