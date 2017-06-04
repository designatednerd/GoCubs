//
//  ParsingTests.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import Foundation
import XCTest
@testable import GoCubs

class ParsingTests: XCTestCase {

    func testParsingPitcher() {
        let testWinningPitcher = Pitcher(pitcherString: "Arrieta(22-6)")
        
        XCTAssertEqual(testWinningPitcher.name, "Arrieta")
        XCTAssertEqual(testWinningPitcher.wins, 22)
        XCTAssertEqual(testWinningPitcher.losses, 6)
        
        let testLosingPitcher = Pitcher(pitcherString: "Lester(10-12)")
        
        XCTAssertEqual(testLosingPitcher.name, "Lester")
        XCTAssertEqual(testLosingPitcher.wins, 10)
        XCTAssertEqual(testLosingPitcher.losses, 12)
    }
    
    func testParsingOpponent() {
        let testHomeOpponent = Opponent(name: "Cardinals")
        XCTAssertFalse(testHomeOpponent.isHomeTeam)
        XCTAssertEqual(testHomeOpponent.name, "Cardinals")
        XCTAssertEqual(testHomeOpponent.team, .Cardinals)
        
        let testAwayOpponent = Opponent(name: "at Pirates")
        XCTAssertEqual(testAwayOpponent.name, "Pirates")
        XCTAssertTrue(testAwayOpponent.isHomeTeam)
        XCTAssertEqual(testAwayOpponent.team, .Pirates)
    }
    
    func testParsingResult() {
        let testParsingRainout = Result(resultString: "Postponed")
        XCTAssertEqual(testParsingRainout.type, ResultType.postponed)

        let testParsingLoss = Result(resultString: "L 1-4")
        XCTAssertEqual(testParsingLoss.type, ResultType.loss)
        XCTAssertEqual(testParsingLoss.cubsRuns, 1)
        XCTAssertEqual(testParsingLoss.opponentRuns, 4)

        let testParsingWin = Result(resultString: "W 7-3")
        XCTAssertEqual(testParsingWin.type, ResultType.win)
        XCTAssertEqual(testParsingWin.cubsRuns, 7)
        XCTAssertEqual(testParsingWin.opponentRuns, 3)
    }
    
    func testParsingCubsRecord() {
        let cubs2011Record = CubsRecord(recordString: "61-101")
        XCTAssertEqual(cubs2011Record.wins, 61)
        XCTAssertEqual(cubs2011Record.losses, 101)
        
        let cubs2015Record = CubsRecord(recordString: "97-65")
        XCTAssertEqual(cubs2015Record.wins, 97)
        XCTAssertEqual(cubs2015Record.losses, 65)
    }
    
    func testParsingHomeWin() {
        let testHomeWin = CubsGame(gameString: "6/1,Dodgers,W 2-1,36-15,Lester(6-3),Bolsinger(1-2)")
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components( [.month, .day], from: testHomeWin.date)
        
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(testHomeWin.result.type, ResultType.win)
        XCTAssertEqual(testHomeWin.result.cubsRuns, 2)
        XCTAssertEqual(testHomeWin.result.opponentRuns, 1)
        XCTAssertEqual(testHomeWin.cubsRecord.wins, 36)
        XCTAssertEqual(testHomeWin.cubsRecord.losses, 15)
        XCTAssertEqual(testHomeWin.winningPitcher.name, "Lester")
        XCTAssertEqual(testHomeWin.winningPitcher.wins, 6)
        XCTAssertEqual(testHomeWin.winningPitcher.losses, 3)
        XCTAssertEqual(testHomeWin.losingPitcher.name, "Bolsinger")
        XCTAssertEqual(testHomeWin.losingPitcher.wins, 1)
        XCTAssertEqual(testHomeWin.losingPitcher.losses, 2)
    }

    func testParsingAwayWin() {
        let testAwayWin = CubsGame(gameString: "8/23,at Padres,W 5-3,80-45,Arrieta(16-5),Friedrich(4-10)")
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components( [.month, .day], from: testAwayWin.date)
        
        XCTAssertEqual(components.month, 8)
        XCTAssertEqual(components.day, 23)
        XCTAssertEqual(testAwayWin.result.type, ResultType.win)
        XCTAssertEqual(testAwayWin.result.cubsRuns, 5)
        XCTAssertEqual(testAwayWin.result.opponentRuns, 3)
        XCTAssertEqual(testAwayWin.cubsRecord.wins, 80)
        XCTAssertEqual(testAwayWin.cubsRecord.losses, 45)
        XCTAssertEqual(testAwayWin.winningPitcher.name, "Arrieta")
        XCTAssertEqual(testAwayWin.winningPitcher.wins, 16)
        XCTAssertEqual(testAwayWin.winningPitcher.losses, 5)
        XCTAssertEqual(testAwayWin.losingPitcher.name, "Friedrich")
        XCTAssertEqual(testAwayWin.losingPitcher.wins, 4)
        XCTAssertEqual(testAwayWin.losingPitcher.losses, 10)
    }
    
    func testParsingHomeLoss() {
        let testHomeLoss = CubsGame(gameString: "4/5,Cardinals,L 0-3,0-1,Wainwright(1-0),Lester(0-1)")
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components( [.month, .day], from: testHomeLoss.date)
        XCTAssertEqual(components.month, 4)
        XCTAssertEqual(components.day, 5)
        XCTAssertEqual(testHomeLoss.result.type, ResultType.loss)
        XCTAssertEqual(testHomeLoss.result.cubsRuns, 0)
        XCTAssertEqual(testHomeLoss.result.opponentRuns, 3)
        XCTAssertEqual(testHomeLoss.cubsRecord.wins, 0)
        XCTAssertEqual(testHomeLoss.cubsRecord.losses, 1)
        XCTAssertEqual(testHomeLoss.winningPitcher.name, "Wainwright")
        XCTAssertEqual(testHomeLoss.winningPitcher.wins, 1)
        XCTAssertEqual(testHomeLoss.winningPitcher.losses, 0)
        XCTAssertEqual(testHomeLoss.losingPitcher.name, "Lester")
        XCTAssertEqual(testHomeLoss.losingPitcher.wins, 0)
        XCTAssertEqual(testHomeLoss.losingPitcher.losses, 1)
    }
    
    func testParsingAwayLoss() {
        let testAwayLoss = CubsGame(gameString: "7/23,at Brewers,L 1-6,58-38,Davies(7-4),Lackey(7-6)")
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components( [.month, .day], from: testAwayLoss.date)
        XCTAssertEqual(components.month, 7)
        XCTAssertEqual(components.day, 23)
        XCTAssertEqual(testAwayLoss.result.type, ResultType.loss)
        XCTAssertEqual(testAwayLoss.result.cubsRuns, 1)
        XCTAssertEqual(testAwayLoss.result.opponentRuns, 6)
        XCTAssertEqual(testAwayLoss.cubsRecord.wins, 58)
        XCTAssertEqual(testAwayLoss.cubsRecord.losses, 38)
        XCTAssertEqual(testAwayLoss.winningPitcher.name, "Davies")
        XCTAssertEqual(testAwayLoss.winningPitcher.wins, 7)
        XCTAssertEqual(testAwayLoss.winningPitcher.losses, 4)
        XCTAssertEqual(testAwayLoss.losingPitcher.name, "Lackey")
        XCTAssertEqual(testAwayLoss.losingPitcher.wins, 7)
        XCTAssertEqual(testAwayLoss.losingPitcher.losses, 6)
    }
    
    func testParsingHomePostponement() {
        let testHomePostponement = CubsGame(gameString: "5/9,Padres,Postponed,24-6,Villanueva(0-0),Strop(1-0)")
        let calendar = Calendar.current
        let postponedComponents = (calendar as NSCalendar).components([.month, .day], from: testHomePostponement.date)
        
        XCTAssertEqual(postponedComponents.month, 5)
        XCTAssertEqual(postponedComponents.day, 9)
        XCTAssertEqual(testHomePostponement.opponent.team, .Padres)
        XCTAssertEqual(testHomePostponement.result.type, .postponed)
        
        //Cubs are the "winning" team when thre is no result
        XCTAssertEqual(testHomePostponement.winningPitcher.name, "Strop")
        XCTAssertEqual(testHomePostponement.losingPitcher.name, "Villanueva")
        
        XCTAssertEqual(testHomePostponement.cubsRecord.wins, 24)
        XCTAssertEqual(testHomePostponement.cubsRecord.losses, 6)
    }

    func testParsingAwayPostponement() {
        let testAwayPostponement = CubsGame(gameString: "9/10,at Phillies,Postponed,80-58,Hendricks(6-6),Asher(0-2)")
        
        let calendar = Calendar.current
        let postponedComponents = (calendar as NSCalendar).components([.month, .day], from: testAwayPostponement.date)
        
        XCTAssertEqual(postponedComponents.month, 9)
        XCTAssertEqual(postponedComponents.day, 10)
        XCTAssertEqual(testAwayPostponement.opponent.team, .Phillies)
        XCTAssertTrue(testAwayPostponement.opponent.isHomeTeam)
        
        XCTAssertEqual(testAwayPostponement.result.type, .postponed)
        
        //Cubs are the "winning" team when thre is no result
        XCTAssertEqual(testAwayPostponement.winningPitcher.name, "Hendricks")
        XCTAssertEqual(testAwayPostponement.losingPitcher.name, "Asher")
        
        XCTAssertEqual(testAwayPostponement.cubsRecord.wins, 80)
        XCTAssertEqual(testAwayPostponement.cubsRecord.losses, 58)
    }
}
