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
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    
    init(gameString: String) {
        //Format: "Sun, 4/5",Cardinals,L 0-3,0-1,Wainwright(1-0),Lester(0-1)

        let components = gameString.componentsSeparatedByString(",")
        
        self.date = self.dateFormatter.dateFromString(components[0])!
        self.opponent = Opponent(name: components[1])
        self.result = Result(resultString: components[2])
        self.cubsRecord = CubsRecord(recordString: components[3])
        self.winningPitcher = Pitcher(pitcherString: components[4])
        self.losingPitcher = Pitcher(pitcherString: components[5])
    }
}
