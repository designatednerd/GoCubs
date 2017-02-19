//
//  GameDetailViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 9/29/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
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
            self.configureForGame()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureForGame()
        self.addAcessibility()
    }
    
    fileprivate func addAcessibility() {
        self.losingTeamNameLabel.accessibilityIdentifier = AccessibilityString.losingTeamName
        self.losingTeamScoreLabel.accessibilityIdentifier = AccessibilityString.losingTeamScore
        self.winningTeamNameLabel.accessibilityIdentifier = AccessibilityString.winningTeamName
        self.winningTeamScoreLabel.accessibilityIdentifier = AccessibilityString.winningTeamScore
        self.cubsRecordLabel.accessibilityIdentifier = AccessibilityString.cubsRecord
    }

    //MARK: - Setup
    
    func configureForGame() {
        if let
            cubsGame = self.game,
            let _ = self.flagView { //Make sure the view has loaded
                self.title = self.dateFormatter.string(from: cubsGame.date as Date)
                
                let components = (Calendar.current as NSCalendar).components([.day, .month], from: cubsGame.date as Date)
                var isPostseason = false
                
                if (components.month! > 10 || //Is november OR
                    (components.month! == 10 && components.day! >= 7)) { //Is October 7th or later
                        isPostseason = true
                }
                
                
                switch cubsGame.result.type {
                case .Win:
                    self.winningTeamNameLabel.text = LocalizedString.cubs.uppercased()
                    self.winningTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
                    self.winningTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
                    self.losingTeamNameLabel.text = cubsGame.opponent.name.uppercased()
                    self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
                    self.losingTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
                case .Loss:
                    self.losingTeamNameLabel.text = LocalizedString.cubs.uppercased()
                    self.losingTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
                    self.losingTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
                    self.winningTeamNameLabel.text = cubsGame.opponent.name.uppercased()
                    self.winningTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
                    self.winningTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
                case .Postponed:
                    self.winningTeamNameLabel.text = LocalizedString.cubs.uppercased()
                    self.winningTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
                    self.winningTeamScoreLabel.text = LocalizedString.noResult
                    self.losingTeamNameLabel.text = cubsGame.opponent.name.uppercased()
                    self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
                    self.losingTeamScoreLabel.text = LocalizedString.noResult
                }
                
                self.cubsRecordLabel.text = cubsGame.resultString(isPostseason)
                self.configureFlagForResultType(cubsGame.result.type)
                self.configurePitchersForGame(cubsGame)
        }
    }
    
    func configurePitchersForGame(_ game: CubsGame) {
        switch game.result.type {
        case .Postponed:
            self.winningPitcherNameLabel.text = LocalizedString.noResult
            self.losingPitcherNameLabel.text = LocalizedString.noResult
        default:
            self.winningPitcherNameLabel.text = game.winningPitcher.name
            self.losingPitcherNameLabel.text = game.losingPitcher.name
        }
    }
    
    func configureFlagForResultType(_ resultType: ResultType) {
        self.flagView.backgroundColor = resultType.flagBackground()
        self.resultLabel.text = resultType.flagString()
        self.resultLabel.textColor = resultType.flagTextColor()
        self.resultLabel.accessibilityLabel = resultType.accessibilityString()
    }
}
