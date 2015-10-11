//
//  Result.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

enum ResultType: String {
    case
    Win = "W",
    Loss = "L",
    Postponed //Automatically "Postponed"
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
            let components = resultString.componentsSeparatedByString(" ")
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
            
            self.cubsRuns = runs.0
            self.opponentRuns = runs.1 
        }
    }
    
}