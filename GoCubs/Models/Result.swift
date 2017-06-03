//
//  Result.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import UIKit

enum ResultType: String {
    case
    win = "W",
    loss = "L",
    tie = "T", //Doesn't happen often, but: http://m.mlb.com/news/article/204121484/cubs-pirates-game-suspended-ends-in-tie/?game_pk=449244
    postponed = "Postponed"
        
    var flagString: String {
        switch self {
        case .postponed:
            return "☔️"
        case .tie:
            return "¯\\_(ツ)_/¯"
        default:
            return self.rawValue
        }
    }
    
    var flagBackground: UIColor {
        switch self {
        case .win,
             .tie:
            return .white
        case .loss:
            return Team.Cubs.primaryColor
        case .postponed:
            return ResultType.rainoutBlue
        }
    }
    
    var flagTextColor: UIColor {
        switch self {
        case .win:
            return Team.Cubs.primaryColor
        case .loss:
            return .white
        case .postponed,
             .tie:
            return .black
        }
    }
    
    var accessibilityString: String {
        switch self {
        case .win:
            return AccessibilityLabel.cubsWin
        case .loss:
            return AccessibilityLabel.cubsLose
        case .tie:
            return AccessibilityLabel.tieGame
        case .postponed:
            return AccessibilityLabel.postponed
        }
    }
    
    static let rainoutBlue: UIColor = .cub_RGB(158, 206, 208)
}

struct Result {
    let type: ResultType
    let cubsRuns: Int
    let opponentRuns: Int
    
    init(resultString: String) {
        //Of the format "W 5-3" OR "Postponed"
        let components = resultString.components(separatedBy: " ")
        let result = components[0]
        guard let resultType = ResultType(rawValue: result) else {
            fatalError("Not a real result type")
        }
        
        self.type = resultType
        switch self.type {
        case .postponed:
            self.cubsRuns = 0
            self.opponentRuns = 0
        default:
            guard components.count == 2 else {
                fatalError("There should be 2 elements for non-postponed games!")
            }
        
            let runsString = components[1]
            let runs = runsString.cub_asInts()
            
            //The first number in the runs is always what the Cubs scored, regardless of result.
            self.cubsRuns = runs.firstValue
            self.opponentRuns = runs.secondValue
        }
    }
}
