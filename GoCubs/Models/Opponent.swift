//
//  Opponent.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import Foundation
import UIKit

struct Opponent {
    let at = "at "
    let isHomeTeam: Bool
    let team: Team
    
    var name: String {
        return self.team.rawValue
    }
    
    init(name: String) {
        var nameToUse: String
        if name.hasPrefix(at) {
            self.isHomeTeam = true            
            nameToUse = name.substring(from: at.endIndex)
        } else {
            self.isHomeTeam = false
            nameToUse = name
        }
        
        guard let team = Team(rawValue: nameToUse) else {
            fatalError("Couldn't get team colors for team named \(nameToUse)")
        }
        
        self.team = team
    }
}
