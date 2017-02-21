//
//  GameListRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import Foundation
import XCTest
@testable import GoCubs

protocol GameListRobot: BasicRobot {
    
    func tapCell(withDateText dateText: String,
                 gameText: String,
                 testInfo: TestInfo)
}

extension GameListRobot {
    
    func verifyOnGameList(testInfo: TestInfo) {
        NSLog("Verify on game list")
        self.waitForTableView(withAccessibilityIdentifier: AccessibilityString.gamesTableview,
                              testInfo: testInfo)
    }
    
    func selectRow(forMonth month: Int,
                   day: Int,
                   homeTeam: Team,
                   awayTeam: Team,
                   testInfo: TestInfo) {
        NSLog("Select row")
        let shortMonth = DateFormatter.cub_shortMonthName(for: month)
        let dateText = "\(shortMonth) \(day)"
        let gameText = LocalizedString.versus(awayTeam.rawValue,
                                              homeTeam: homeTeam.rawValue)
        self.tapCell(withDateText: dateText,
                     gameText: gameText,
                     testInfo: testInfo)
    }
}
