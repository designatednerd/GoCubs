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
    
    static let improveFormat = NSLocalizedString("Cubs improve to %1$d and %2$d on the season", comment: "Format with placeholders with wins and losses when cubs win")
    
    static func improve(record: CubsRecord) -> String {
        return NSString.localizedStringWithFormat(improveFormat, record.wins, record.losses) as String
    }
   
    static let fallFormat = NSLocalizedString("Cubs fall to %1$d and %2$d on the season", comment: "Format with placeholders for wins and losses when the cubs lose")
    
    static func fall(record: CubsRecord) -> String {
        return NSString.localizedStringWithFormat(fallFormat, record.wins, record.losses) as String
    }
    
    static func remain(record: CubsRecord) -> String {
        return NSString.localizedStringWithFormat("Cubs fall to %1$d and %2$d on the season", record.wins, record.losses) as String
    }
    
    static func versus(awayTeam: String, homeTeam: String) -> String {
        return NSString.localizedStringWithFormat("%1$@ vs. %2$@", awayTeam, homeTeam) as String
    }
    
}