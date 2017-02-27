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
    
    static let gamePostponed = NSLocalizedString("Game postponed",
                                                 comment: "String indicating the game was postponed")
    
    static let noResult = NSLocalizedString("-",
                                            comment: "String for no result score")
    
    static let winningPitcher = NSLocalizedString("Winning Pitcher",
                                                  comment: "Title for winning pitcher label")
    
    static let losingPitcher = NSLocalizedString("Losing Pitcher",
                                                 comment: "Title for losing pitcher label")
    
    static let regularSeason = NSLocalizedString("season",
                                                 comment: "Display name of the regular season")
    
    static let NLDS = NSLocalizedString("National League Division Series",
                                        comment: "Full name of the division series the Cubs would play in")
    
    static let NLCS = NSLocalizedString("National League Championship Series",
                                        comment: "Full name of the league championship series the Cubs would play in")
    
    static let worldSeries = NSLocalizedString("World Series",
                                                comment: "YOU GUYS THE WORLD SERIES!!!!")
    static let inThe = NSLocalizedString("in the",
                                         comment: "String to add when a game should be referred to as within someting")
    
    static let onThe = NSLocalizedString("on the",
                                         comment: "String to add when a game should be referred to as on something")
    
    //MARK: - Formats
    
    private static let pitcherForTeamFormat = NSLocalizedString("%@ Pitcher",
                                                                comment: "Title for pitcher for a specific team when nobody won or lost")

    private static let recordFormat = NSLocalizedString("%1$d-%2$d",
                                                        comment: "Format with placeholders for wins and losses")
    
    static let winSeriesFormat = NSLocalizedString("Cubs win the %1$@ %2$@",
                                                   comment: "Format with placeholders for the portion of the year and the record when the cubs win a series")
    
    static let loseSeriesFormat = NSLocalizedString("Cubs lose the %1$@ %2$@",
                                                    comment: "Format with placeholders for the portion of the year and the record when the cubs lose a series")
    
    static let improveFormat = NSLocalizedString("Cubs improve to %1$@ %2$@ %3$@",
                                                 comment: "Format with placeholders for the record, in the/on the, and the portion of the year when the cubs win")
    
    static let fallFormat = NSLocalizedString("Cubs fall to %1$@ %2$@ %3$@",
                                              comment: "Format with placeholders the record, in the/on the, and the portion of the year when the cubs lose")

    static let remainFormat = NSLocalizedString("Cubs remain at %1$@ %2$@ %3$@",
                                                comment: "Format with placeholders for the record, in the/on the, and the portion of the year when the game is postponed or tied")
    
    private static let versusFormat = NSLocalizedString("%1$@ vs. %2$@",
                                                comment: "format for 'x vs. y' with placeholders for the away and home teams")
    
    //MARK: - Helper functions
    
    static func versus(_ awayTeam: String, homeTeam: String) -> String {
        return NSString.localizedStringWithFormat(versusFormat as NSString, awayTeam, homeTeam) as String
    }
    
    static func pitcher(for teamName: String) -> String {
        return NSString.localizedStringWithFormat(pitcherForTeamFormat as NSString, teamName) as String
    }
    
    static func recordString(wins: Int, losses: Int) -> String {
        return NSString.localizedStringWithFormat(recordFormat as NSString, wins, losses) as String
    }
}
