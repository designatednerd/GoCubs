//
//  LocalizedString.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import Foundation

/**
 A centralized place to store localized strings so you can refer to them in both the 
 application and tests.
 
 NOTE: This is an enum instead of a class or a struct so it can't be instantiated.
 */
enum LocalizedString {
    
    //MARK: - List of games strings
    
    static let listTitle = NSLocalizedString("Cubs 2016 Games",
                                             comment: "Title for the main list view")
    
    //MARK: - Game detail strings
    
    static let cubs = NSLocalizedString("Cubs",
                                        comment: "Cubs team name")
    
    static let gamePostponed = NSLocalizedString("Game postponed",
                                                 comment: "String indicating the game was postponed")
    
    static let noResult = NSLocalizedString("-",
                                            comment: "String for no result score")
    
    static let winningPitcher = NSLocalizedString("Winning Pitcher",
                                                  comment: "Title for winning pitcher label")
    
    static let losingPitcher = NSLocalizedString("Losing Pitcher",
                                                 comment: "Title for losing pitcher label")
    
    //MARK: - Formats
    
    private static let pitcherForTeamFormat = NSLocalizedString("%@ Pitcher",
                                                                comment: "Title for pitcher for a specific team when nobody won or lost")
    
    static func pitcher(for teamName: String) -> String {
        return NSString.localizedStringWithFormat(LocalizedString.pitcherForTeamFormat as NSString, teamName) as String
    }
    
    private static let recordFormat = NSLocalizedString("%1$d and %2$d",
                                                        comment: "Format with placeholders for wins and losses")
    
    static func recordString(wins: Int, losses: Int) -> String {
        return NSString.localizedStringWithFormat(LocalizedString.recordFormat as NSString, wins, losses) as String
    }
    
    static let improveFormat = NSLocalizedString("Cubs improve to %1$@ %2$@",
                                                 comment: "Format with placeholders for the record and whether it's the season or postseason when cubs win")
    
    static let fallFormat = NSLocalizedString("Cubs fall to %1$@ %2$@",
                                              comment: "Format with placeholders the record, and whether it's the season or postseason when the cubs lose")

    static let remainFormat = NSLocalizedString("Cubs remain at %1$@ %2$@",
                                                comment: "Format with placeholders for the record and whether it's the season or postseason when the game is postponed")
    
    private static let versusFormat = NSLocalizedString("%1$@ vs. %2$@",
                                                comment: "format for 'x vs. y' with placeholders for the away and home teams")
    
    //MARK: - Helper functions
    
    static func versus(_ awayTeam: String, homeTeam: String) -> String {
        return NSString.localizedStringWithFormat(versusFormat as NSString, awayTeam, homeTeam) as String
    }
    
    static let postseasonString = NSLocalizedString("in the postseason",
                                                    comment: "String to append when something has happened in the postseason")
    
    static let regularSeasonString = NSLocalizedString("on the season",
                                                       comment: "String to append when something has happened during the regular season")
    
    static func seasonStringForPostseason(_ isPostseason: Bool) -> String {
        if isPostseason {
            return self.postseasonString
        } else {
            return self.regularSeasonString
        }
    }
}
