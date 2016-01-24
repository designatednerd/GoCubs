//
//  Opponent.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation
import UIKit

struct Opponent {
  let at = "at "
  let name: String
  let isHomeTeam: Bool
  let colors: TeamColors
  
  init(teamName: String) {
    if teamName.hasPrefix(at) {
      isHomeTeam = true
      name = teamName.substringFromIndex(at.endIndex)
    } else {
      isHomeTeam = false
      name = teamName
    }
    
    guard let teamColors = TeamColors(rawValue: name) else {
      fatalError("Couldn't get team colors for team named \(teamName)")
    }
    
    self.colors = teamColors
  }
}