//
//  GameDetailViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
  
  //MARK: - Properties
  
  @IBOutlet weak var flagView: UIView!
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var winningTeamNameLabel: UILabel!
  @IBOutlet weak var winningTeamScoreLabel: UILabel!
  @IBOutlet weak var losingTeamNameLabel: UILabel!
  @IBOutlet weak var losingTeamScoreLabel: UILabel!
  @IBOutlet weak var cubsRecordLabel: UILabel!
  @IBOutlet weak var winningPitcherNameLabel: UILabel!
  @IBOutlet weak var losingPitcherNameLabel: UILabel!
  
  
  var game: CubsGame? {
    didSet {
      configureForGame()
    }
  }
  
  let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MMMM d"
    return formatter
  }()
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureForGame()
//PART1
    setupAccessibilityAndLocalization()
  }
 
  private func setupAccessibilityAndLocalization() {
    losingTeamNameLabel.accessibilityIdentifier = AccessibilityIdentifier.LosingTeamName.rawValue
    losingTeamScoreLabel.accessibilityIdentifier = AccessibilityIdentifier.LosingTeamScore.rawValue
    winningTeamNameLabel.accessibilityIdentifier = AccessibilityIdentifier.WinningTeamName.rawValue
    winningTeamScoreLabel.accessibilityIdentifier = AccessibilityIdentifier.WinningTeamScore.rawValue
    cubsRecordLabel.accessibilityIdentifier = AccessibilityIdentifier.CubsRecord.rawValue
//PART1
  }
  
  //MARK: - Setup
  
  func configureForGame() {
    if let
      cubsGame = game,
      _ = flagView { //Make sure the view has loaded
        title = dateFormatter.stringFromDate(cubsGame.date)
        
        let components = NSCalendar.currentCalendar().components([.Day, .Month], fromDate: cubsGame.date)
        var isPostseason = false
        
        if (components.month > 10 || //Is november OR
          (components.month == 10 && components.day >= 7)) { //Is October 7th or later
            isPostseason = true
        }
        
        
        switch cubsGame.result.type {
        case .Win:
          winningTeamNameLabel.text = LocalizedString.cubs.uppercaseString
          winningTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
          winningTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
          losingTeamNameLabel.text = cubsGame.opponent.name.uppercaseString
          losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
          losingTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
        case .Loss:
          losingTeamNameLabel.text = LocalizedString.cubs.uppercaseString
          losingTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
          losingTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
          winningTeamNameLabel.text = cubsGame.opponent.name.uppercaseString
          winningTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
          winningTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
        case .Postponed:
          winningTeamNameLabel.text = LocalizedString.cubs.uppercaseString
          winningTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
          winningTeamScoreLabel.text = LocalizedString.noResult
          losingTeamNameLabel.text = cubsGame.opponent.name.uppercaseString
          losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
          losingTeamScoreLabel.text = LocalizedString.noResult
        }
        
        cubsRecordLabel.text = cubsGame.resultString(isPostseason)
        configureFlagForResultType(cubsGame.result.type)
        configurePitchersForGame(cubsGame)
    }
  }
  
  func configurePitchersForGame(game: CubsGame) {
    switch game.result.type {
    case .Postponed:
      winningPitcherNameLabel.text = LocalizedString.noResult
      losingPitcherNameLabel.text = LocalizedString.noResult
    default:
      winningPitcherNameLabel.text = game.winningPitcher.name
      losingPitcherNameLabel.text = game.losingPitcher.name
    }
  }
  
  func configureFlagForResultType(resultType: ResultType) {
    flagView.backgroundColor = resultType.flagBackground()
    resultLabel.text = resultType.flagString()
    resultLabel.textColor = resultType.flagTextColor()
    resultLabel.accessibilityLabel = resultType.accessibilityLabel()
  }
}
