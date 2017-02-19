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
    let name: String
    let isHomeTeam: Bool
    let colors: TeamColors
    
    init(name: String) {        
        if name.hasPrefix(at) {
            self.isHomeTeam = true            
            self.name = name.substring(from: at.endIndex)
        } else {
            self.isHomeTeam = false
            self.name = name
        }
        
        guard let colors = TeamColors(rawValue: self.name) else {
            fatalError("Couldn't get team colors for team named \(name)")
        }
        
        self.colors = colors
    }
}
