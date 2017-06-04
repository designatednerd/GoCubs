//
//  Game.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import Foundation

class CubsGame {
    
    let date: Date
    let opponent: Opponent
    let result: Result
    let cubsRecord: CubsRecord
    let winningPitcher: Pitcher
    let losingPitcher: Pitcher
    let portionOfYear: PortionOfYear
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    init(gameString: String) {
        //Format: "Sun, 4/5",Cardinals,L 0-3,0-1,Wainwright(1-0),Lester(0-1)
        let components = gameString.components(separatedBy: ",")
        guard components.count == 6 else {
            fatalError("Malformatted game string: \(gameString)")
        }
        
        let dateString = components[0]
        guard let gameDate = self.dateFormatter.date(from: dateString) else {
            fatalError("Could not parse date string \(dateString)")
        }
        
        self.date = gameDate
        self.portionOfYear = PortionOfYear.forDate(gameDate)
        self.opponent = Opponent(name: components[1])
        self.result = Result(resultString: components[2])
        self.cubsRecord = CubsRecord(recordString: components[3])
        
        switch self.result.type {
        case .win,
             .loss:
            // Winning pitcher is first when there is an actual winner
            self.winningPitcher = Pitcher(pitcherString: components[4])
            self.losingPitcher = Pitcher(pitcherString: components[5])
        case .postponed,
             .tie:
            if self.opponent.isHomeTeam {
                self.winningPitcher = Pitcher(pitcherString: components[4])
                self.losingPitcher = Pitcher(pitcherString: components[5])
            } else {
                self.winningPitcher = Pitcher(pitcherString: components[5])
                self.losingPitcher = Pitcher(pitcherString: components[4])
            }
        }
    }
    
    var resultString: String {
        switch self.result.type {
        case .win:
            return self.improve(self.cubsRecord)
        case .loss:
            return self.fall(self.cubsRecord)
        case .postponed,
             .tie:
            return self.remain(self.cubsRecord)
        }
    }
    
    private func recordString(for record: CubsRecord) -> String {
        return LocalizedString.recordString(wins: record.wins, losses: record.losses)
    }
    
    func improve(_ record: CubsRecord) -> String {
        let recordString = self.recordString(for: record)        
        guard record.wins == self.portionOfYear.gamesRequiredToWinSeries else {
            return NSString.localizedStringWithFormat(LocalizedString.improveFormat as NSString,
                                                      recordString,
                                                      self.portionOfYear.seasonStringSeparator,
                                                      self.portionOfYear.localizedName) as String
        }
        
        return NSString.localizedStringWithFormat(LocalizedString.winSeriesFormat as NSString,
                                                  self.portionOfYear.localizedName,
                                                  recordString) as String

    }
    
    func remain(_ record: CubsRecord) -> String {
        let recordString = self.recordString(for: record)
        return NSString.localizedStringWithFormat(LocalizedString.remainFormat as NSString,
                                                  recordString,
                                                  self.portionOfYear.seasonStringSeparator,
                                                  self.portionOfYear.localizedName) as String
    }
    
    func fall(_ record: CubsRecord) -> String {
        let recordString = self.recordString(for: record)
        
        guard record.losses == self.portionOfYear.gamesRequiredToWinSeries else {
            return NSString.localizedStringWithFormat(LocalizedString.fallFormat as NSString,
                                                      recordString,
                                                      self.portionOfYear.seasonStringSeparator,
                                                      self.portionOfYear.localizedName) as String
        }
        
        return NSString.localizedStringWithFormat(LocalizedString.loseSeriesFormat as NSString,
                                                  self.portionOfYear.localizedName,
                                                  recordString) as String
    }
}
