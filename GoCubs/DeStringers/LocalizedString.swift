//
//  LocalizedString.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

enum LocalizedString {
    
    static let cubs = NSLocalizedString("Cubs", comment: "Cubs team name")
    
    static let gamePostponed = NSLocalizedString("Game postponed", comment: "String indicating the game was postponed")
    
    static func versus(awayTeam: String, homeTeam: String) -> String {
        return NSString.localizedStringWithFormat("%1$@ vs. %2$@", awayTeam, homeTeam) as String
    }
}