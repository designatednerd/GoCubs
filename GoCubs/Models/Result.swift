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
    postponed = "Postponed"
        
    var flagString: String {
        switch self {
        case .postponed:
            return "☔️"
        default:
            return self.rawValue
        }
    }
    
    var flagBackground: UIColor {
        switch self {
        case .win:
            return .white
        case .loss:
            return Team.Cubs.primaryColor
        case .postponed:
            return Team.rainoutBlue
        }
    }
    
    var flagTextColor: UIColor {
        switch self {
        case .win:
            return Team.Cubs.primaryColor
        case .loss:
            return .white
        case .postponed:
            return .black
        }
    }
    
    var accessibilityString: String {
        switch self {
        case .win:
            return AccessibilityString.cubsWin
        case .loss:
            return AccessibilityString.cubsLose
        case .postponed:
            return AccessibilityString.postponed
        }
    }
}

struct Result {
    let type: ResultType
    let cubsRuns: Int
    let opponentRuns: Int
    
    init(resultString: String) {
        //Of the format "W 5-3" OR "Postponed"
        if resultString == ResultType.postponed.rawValue {
            //This game was postponed
            self.type = .postponed
            self.cubsRuns = 0
            self.opponentRuns = 0
        } else {
            //Parse the win/loss and the score.
            let components = resultString.components(separatedBy: " ")
            guard components.count == 2 else {
                fatalError("There should be 2 elements for non-postponed games!")
            }
            
            let winOrLoss = components[0]
            switch winOrLoss {
            case ResultType.win.rawValue:
                self.type = .win
            case ResultType.loss.rawValue:
                self.type = .loss
            default:
                assertionFailure("Postponed should have already been caught!")                
                //In production:
                self.type = .postponed
            }
            
            let runsString = components[1]
            let runs = runsString.cub_asInts()
            
            //The first number in the runs is always what the Cubs scored, regardless of result.
            self.cubsRuns = runs.firstValue
            self.opponentRuns = runs.secondValue
        }
    }
}
