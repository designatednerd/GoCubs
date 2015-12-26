//
//  CubsRecord.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

struct CubsRecord {
  
  let wins: Int
  let losses: Int
  
  init(recordString: String) {
    let record = recordString.cub_asInts()
    
    self.wins = record.firstValue
    self.losses = record.secondValue
  }
}
