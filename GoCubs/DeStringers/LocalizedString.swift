//
//  LocalizedString.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

enum LocalizedString {
    
    static let listTitle = NSLocalizedString("Cubs 2015 Games", comment: "Title for the main list view")
    
    static let cubs = NSLocalizedString("Cubs", comment: "Cubs team name")
    
    static let gamePostponed = NSLocalizedString("Game postponed", comment: "String indicating the game was postponed")
    
    static let noResult = NSLocalizedString("-", comment: "String for no result score")
    
    static func seasonStringForPostseason(isPostseason: Bool) -> String {
        if isPostseason {
            return NSLocalizedString("in the postseason", comment: "String to append when something has happened in the ")
        } else {
            return NSLocalizedString("on the season", comment: "String to append when something has happened during the regular season")
        }
    }
    
    static let improveFormat = NSLocalizedString("Cubs improve to %1$d and %2$d %3$@", comment: "Format with placeholders with wins, losses, and whether it's the season or postseason when cubs win")
    
   
    static let fallFormat = NSLocalizedString("Cubs fall to %1$d and %2$d %3$@", comment: "Format with placeholders for wins, losses, and whether it's the season or postseason when the cubs lose")
    

    
    static let remainFormat = NSLocalizedString("Cubs remain at %1$d and %2$d %3$@", comment: "Format with placeholders for wins, losses, and whether it's the season or postseason when the game is postponed")
    

    
    static let versusFormat = NSLocalizedString("%1$@ vs. %2$@", comment: "format for 'x vs. y' with placeholders for the away and home teams")
    
    static func versus(awayTeam: String, homeTeam: String) -> String {
        return NSString.localizedStringWithFormat(versusFormat, awayTeam, homeTeam) as String
    }
    
}