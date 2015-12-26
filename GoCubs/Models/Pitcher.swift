//
//  Pitcher.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

struct Pitcher {
  let wins: Int
  let losses: Int
  let name: String
  
  init(pitcherString: String) {
    //Pitcher strings come in with format "Garcia(0-1)"
    let components = pitcherString.componentsSeparatedByString("(")
    guard components.count == 2 else {
      fatalError("Unable to parse pitcher string \(pitcherString)")
    }
    
    self.name = components[0]
    let recordStringWithParen = components[1]
    
    //Grab up to the )
    let recordString = recordStringWithParen
      .substringToIndex(recordStringWithParen.endIndex.predecessor())
    
    
    let record = recordString.cub_asInts()
    self.wins = record.firstValue
    self.losses = record.secondValue
  }
}