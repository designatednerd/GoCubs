//
//  DetailViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var winningTeamNameLabel: UILabel!
    @IBOutlet weak var winningTeamScoreLabel: UILabel!
    @IBOutlet weak var losingTeamNameLabel: UILabel!
    @IBOutlet weak var losingTeamScoreLabel: UILabel!
    @IBOutlet weak var cubsRecordLabel: UILabel!
    
    
    var game: CubsGame? {
        didSet {
            self.configureForGame()
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

        self.configureForGame()
    }

    //MARK: - Setup
    
    func configureForGame() {
        if let cubsGame = self.game,
         _ = self.flagView { //Make sure the view has loaded
            self.title = self.dateFormatter.stringFromDate(cubsGame.date)
            
            switch cubsGame.result.type {
            case .Win:
                self.winningTeamNameLabel.text = LocalizedString.cubs.uppercaseString
                self.winningTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
                self.winningTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
                self.losingTeamNameLabel.text = cubsGame.opponent.name.uppercaseString
                self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
                self.losingTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
                self.cubsRecordLabel.text = LocalizedString.improve(cubsGame.cubsRecord)
            case .Loss:
                self.losingTeamNameLabel.text = LocalizedString.cubs.uppercaseString
                self.losingTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
                self.losingTeamScoreLabel.text = "\(cubsGame.result.cubsRuns)"
                self.winningTeamNameLabel.text = cubsGame.opponent.name.uppercaseString
                self.winningTeamScoreLabel.text = "\(cubsGame.result.opponentRuns)"
                self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
                self.cubsRecordLabel.text = LocalizedString.fall(cubsGame.cubsRecord)
            case .Postponed:
                self.winningTeamNameLabel.text = LocalizedString.cubs.uppercaseString
                self.winningTeamNameLabel.backgroundColor = TeamColors.Cubs.primary()
                self.winningTeamScoreLabel.text = LocalizedString.noResult
                self.losingTeamNameLabel.text = cubsGame.opponent.name.uppercaseString
                self.losingTeamNameLabel.backgroundColor = cubsGame.opponent.colors.primary()
                self.losingTeamScoreLabel.text = LocalizedString.noResult
                self.cubsRecordLabel.text = LocalizedString.remain(cubsGame.cubsRecord)
            }

            self.configureFlagForResultType(cubsGame.result.type)
        }
    }
    
    
    func configureFlagForResultType(resultType: ResultType) {
        self.flagView.backgroundColor = resultType.flagBackground()
        self.resultLabel.text = resultType.flagString()
        self.resultLabel.textColor = resultType.flagTextColor()
    }
}
