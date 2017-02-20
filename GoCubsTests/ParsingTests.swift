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
    
    func testParsingAFullGame() {
        let testLoss = CubsGame(gameString: "4/5,Cardinals,L 0-3,0-1,Wainwright(1-0),Lester(0-1)")
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components( [.month, .day], from: testLoss.date)
        XCTAssertEqual(components.month, 4)
        XCTAssertEqual(components.day, 5)
        XCTAssertEqual(testLoss.result.type, ResultType.loss)
        XCTAssertEqual(testLoss.result.cubsRuns, 0)
        XCTAssertEqual(testLoss.result.opponentRuns, 3)
        XCTAssertEqual(testLoss.cubsRecord.wins, 0)
        XCTAssertEqual(testLoss.cubsRecord.losses, 1)
        XCTAssertEqual(testLoss.winningPitcher.name, "Wainwright")
        XCTAssertEqual(testLoss.winningPitcher.wins, 1)
        XCTAssertEqual(testLoss.winningPitcher.losses, 0)
        XCTAssertEqual(testLoss.losingPitcher.name, "Lester")
        XCTAssertEqual(testLoss.losingPitcher.wins, 0)
        XCTAssertEqual(testLoss.losingPitcher.losses, 1)
        
        let testPostponement = CubsGame(gameString: "5/30,Royals,Postponed,25-22,Rodney(0-0),Almonte(0-0)")
        let postponedComponents = (calendar as NSCalendar).components([.month, .day], from: testPostponement.date)
        
        XCTAssertEqual(postponedComponents.month, 5)
        XCTAssertEqual(postponedComponents.day, 30)
        XCTAssertEqual(testPostponement.opponent.team, .Royals)
        XCTAssertEqual(testPostponement.result.type, .postponed)
        XCTAssertEqual(testPostponement.cubsRecord.wins, 25)
        XCTAssertEqual(testPostponement.cubsRecord.losses, 22)
    }
}
