//
//  Result.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
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
      return rawValue
    }
  }
  
  func flagBackground() -> UIColor {
    switch self {
    case .Win:
      return .whiteColor()
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
      return .whiteColor()
    case .Postponed:
      return .blackColor()
    }
  }
  
  func accessibilityLabel() -> String {
    switch self {
    case .Win:
      return AccessibilityLabel.cubsWin
    case .Loss:
      return AccessibilityLabel.cubsLose
    case .Postponed:
      return AccessibilityLabel.postponed
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
      type = .Postponed
      cubsRuns = 0
      opponentRuns = 0
    } else {
      //Parse the win/loss and the score.
      let components = resultString.componentsSeparatedByString(" ")
      guard components.count == 2 else {
        fatalError("There should be 2 elements for non-postponed games!")
      }
      
      let winOrLoss = components[0]
      switch winOrLoss {
      case ResultType.Win.rawValue:
        type = .Win
      case ResultType.Loss.rawValue:
        type = .Loss
      default:
        assertionFailure("Postponed should have already been caught!")
        //In production:
        type = .Postponed
      }
      
      let runsString = components[1]
      let runs = runsString.asInts()
      
      //The first number in the runs is always what the Cubs scored, regardless of result.
      cubsRuns = runs.firstValue
      opponentRuns = runs.secondValue
    }
  }
}