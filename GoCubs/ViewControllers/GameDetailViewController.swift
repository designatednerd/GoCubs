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
    @IBOutlet weak var winningPitcherLabel: UILabel!
    @IBOutlet weak var losingPitcherLabel: UILabel!
    @IBOutlet weak var winningPitcherNameLabel: UILabel!
    @IBOutlet weak var losingPitcherNameLabel: UILabel!
        
    var game: CubsGame? {
        didSet {
            self.configureForGame()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
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
        guard
            let cubsGame = self.game,
            let _ = self.flagView else { //Make sure the view has loaded
                //Hasn't loaded yet
                return
        }
        self.title = self.dateFormatter.string(from: cubsGame.date as Date)
        
        let components = (Calendar.current as NSCalendar).components([.day, .month], from: cubsGame.date as Date)
        var isPostseason = false
        
        if (components.month! > 10 || //Is november OR
            (components.month! == 10 && components.day! >= 7)) { //Is October 7th or later
            isPostseason = true
        }
        
        switch cubsGame.result.type {
        case .win:
            self.winningTeamNameLabel.text = Team.Cubs.rawValue.uppercased()
            self.winningTeamNameLabel.backgroundColor = Team.Cubs.primaryColor
            self.winningTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
            self.losingTeamNameLabel.text = cubsGame.opponent.name.uppercased()
            self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.team.primaryColor
            self.losingTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
        case .loss:
            self.losingTeamNameLabel.text = Team.Cubs.rawValue.uppercased()
            self.losingTeamNameLabel.backgroundColor = Team.Cubs.primaryColor
            self.losingTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
            self.winningTeamNameLabel.text = cubsGame.opponent.name.uppercased()
            self.winningTeamNameLabel.backgroundColor = cubsGame.opponent.team.primaryColor
            self.winningTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
        case .postponed,
             .tie:
            self.winningTeamNameLabel.text = Team.Cubs.rawValue.uppercased()
            self.winningTeamNameLabel.backgroundColor = Team.Cubs.primaryColor
            self.losingTeamNameLabel.text = cubsGame.opponent.name.uppercased()
            self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.team.primaryColor
            
            
            switch cubsGame.result.type {
            case .postponed:
                self.winningTeamScoreLabel.text = LocalizedString.noResult
                self.losingTeamScoreLabel.text = LocalizedString.noResult
            case .tie:
                self.winningTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
                self.losingTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
            default:
                assertionFailure("This case should have been handled in the main switch!")
            }
        }
        
        self.cubsRecordLabel.text = cubsGame.resultString(isPostseason)
        self.winningPitcherNameLabel.text = cubsGame.winningPitcher.name
        self.losingPitcherNameLabel.text = cubsGame.losingPitcher.name
        
        self.configurePitcherLabel(forGame: cubsGame)
        self.configureFlag(forResult: cubsGame.result.type)
    }

    func configurePitcherLabel(forGame game: CubsGame) {
        switch game.result.type {
        case .win,
             .loss:
            self.winningPitcherLabel.text = LocalizedString.winningPitcher
            self.losingPitcherLabel.text = LocalizedString.losingPitcher
        case .postponed,
             .tie:
            self.winningPitcherLabel.text = LocalizedString.pitcher(for: Team.Cubs.rawValue).uppercased()
            self.losingPitcherLabel.text = LocalizedString.pitcher(for: game.opponent.name).uppercased()
        }
    }
    
    func configureFlag(forResult resultType: ResultType) {
        self.flagView.backgroundColor = resultType.flagBackground
        self.resultLabel.text = resultType.flagString
        self.resultLabel.textColor = resultType.flagTextColor
        self.resultLabel.accessibilityLabel = resultType.accessibilityString
    }
}
