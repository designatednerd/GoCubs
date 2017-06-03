//
//  GameListRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import Foundation
import XCTest

//NOTE: @testable imports will no-op in XCUI bundles.
// Any file you use from the main app should also be added to the XCUI target.
@testable import GoCubs

//MARK: Game List Robot Protocol

protocol GameListRobot: BasicRobot {
    
    /// Protocol which must be implemented by individual test robot types for
    /// test-type specific handling since XCUI, KIF, and Earl Grey all deal with
    /// selecting cells in different ways
    ///
    /// - Parameters:
    ///   - dateText: The text of the date for the game which should be selected
    ///   - gameText: The text describing the game which should be selected.
    ///   - file: The file for the original caller.
    ///   - line: The line for the original caller
    /// - Returns: The GameListRobot making the call, to allow for DSL-style chaining
    @discardableResult
    func tapCell(withDateText dateText: String,
                 gameText: String,
                 file: StaticString,
                 line: UInt) -> GameListRobot
}

//MARK: - Game List Robot default implementation

extension GameListRobot {
    
    //MARK: - Actions

    @discardableResult
    func selectRow(forMonth month: Int,
                   day: Int,
                   homeTeam: Team,
                   awayTeam: Team,
                   file: StaticString = #file,
                   line: UInt = #line) -> GameListRobot {
        NSLog("Select row")
        let shortMonth = DateFormatter.cub_shortMonthName(for: month)
        let dateText = "\(shortMonth) \(day)"
        let gameText = LocalizedString.versus(awayTeam.rawValue,
                                              homeTeam: homeTeam.rawValue)
        self.tapCell(withDateText: dateText,
                     gameText: gameText,
                     file: file,
                     line: line)
        return self
    }
    
    //MARK: - Verifiers
    
    @discardableResult
    func verifyOnGameList(file: StaticString = #file,
                          line: UInt = #line) -> GameListRobot {
        NSLog("Verify on game list")
        self.checkTableViewIsVisible(withAccessibilityIdentifier: .games_table_view,
                                     file: file,
                                     line: line)
        return self
    }
    
}
