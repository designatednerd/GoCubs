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
    Win = "W",
    Loss = "L",
    Postponed //Automatically "Postponed"
        
    func flagString() -> String {
        switch self {
        case .Postponed:
            return "☔️"
        default:
            return self.rawValue
        }
    }
    
    func flagBackground() -> UIColor {
        switch self {
        case .Win:
            return .white
        case .Loss:
            return TeamColors.Cubs.primary()
        case .Postponed:
            return TeamColors.rainoutBlue
        }
    }
    
    func flagTextColor() -> UIColor {
        switch self {
        case .Win:
            return TeamColors.Cubs.primary()
        case .Loss:
            return .white
        case .Postponed:
            return .black
        }
    }
    
    func accessibilityString() -> String {
        switch self {
        case .Win:
            return AccessibilityString.cubsWin
        case .Loss:
            return AccessibilityString.cubsLose
        case .Postponed:
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
        if resultString == ResultType.Postponed.rawValue {
            //This game was postponed
            self.type = .Postponed
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
            case ResultType.Win.rawValue:
                self.type = .Win
            case ResultType.Loss.rawValue:
                self.type = .Loss
            default:
                assertionFailure("Postponed should have already been caught!")                
                //In production:
                self.type = .Postponed
            }
            
            let runsString = components[1]
            let runs = runsString.cub_asInts()
            
            //The first number in the runs is always what the Cubs scored, regardless of result.
            self.cubsRuns = runs.firstValue
            self.opponentRuns = runs.secondValue
        }
    }
}
