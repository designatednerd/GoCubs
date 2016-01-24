//
//  Game.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

class CubsGame {
  
  let date: NSDate
  let opponent: Opponent
  let result: Result
  let cubsRecord: CubsRecord
  let winningPitcher: Pitcher
  let losingPitcher: Pitcher
  
  init(gameString: String) {
    //Format: "Sun, 4/5",Cardinals,L 0-3,0-1,Wainwright(1-0),Lester(0-1)    
    let components = gameString.componentsSeparatedByString(",")
    guard components.count == 6 else {
      fatalError("Malformatted game string: \(gameString)")
    }
    
    let dateString = components[0]
    guard let gameDate = NSDateFormatter.monthDayDateFormatter.dateFromString(dateString) else {
      fatalError("Could not parse date string \(dateString)")
    }
    
    self.date = gameDate
    self.opponent = Opponent(name: components[1])
    self.result = Result(resultString: components[2])
    self.cubsRecord = CubsRecord(recordString: components[3])
    self.winningPitcher = Pitcher(pitcherString: components[4])
    self.losingPitcher = Pitcher(pitcherString: components[5])
  }
  
  func resultString(isPostseason: Bool) -> String {
    switch self.result.type {
    case .Win:
      return improve(self.cubsRecord, isPostseason: isPostseason)
    case .Loss:
      return self.fall(self.cubsRecord, isPostseason: isPostseason)
    case .Postponed:
      return self.remain(self.cubsRecord, isPostseason: isPostseason)
    }
  }
  
  func improve(record: CubsRecord, isPostseason: Bool) -> String {
    return NSString.localizedStringWithFormat(LocalizedString.improveFormat, record.wins, record.losses, LocalizedString.seasonStringForPostseason(isPostseason)) as String
  }
  
  func remain(record: CubsRecord, isPostseason: Bool) -> String {
    return NSString.localizedStringWithFormat(LocalizedString.remainFormat, record.wins, record.losses, LocalizedString.seasonStringForPostseason(isPostseason)) as String
  }
  
  func fall(record: CubsRecord, isPostseason: Bool) -> String {
    return NSString.localizedStringWithFormat(LocalizedString.fallFormat, record.wins, record.losses, LocalizedString.seasonStringForPostseason(isPostseason)) as String
  }
}
