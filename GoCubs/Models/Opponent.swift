//
//  Opponent.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

struct Opponent {
    let at = "at "
    let name: String
    let isHomeTeam: Bool
    
    init(name: String) {
        
        if name.hasPrefix(at) {
            self.isHomeTeam = true            
            self.name = name.substringFromIndex(at.endIndex)
        } else {
            self.isHomeTeam = false
            self.name = name
        }
    }
}