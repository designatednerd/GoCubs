//
//  CubsGameCell.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import UIKit

class CubsGameCell: UITableViewCell {
    
    static let identifier = "CubsGameCell"
    
    // Use a static let so this only gets instantiated once across all cells.
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var vsLabel: UILabel!
    @IBOutlet var primaryColorView: UIView!
    @IBOutlet var secondaryColorView: UIView!
    
    func configure(forGame game: CubsGame) {
        self.dateLabel.text = CubsGameCell.dateFormatter.string(from: game.date as Date)

        if game.opponent.isHomeTeam {
            self.vsLabel.text = LocalizedString.versus(Team.Cubs.rawValue, homeTeam: game.opponent.name)
        } else {
            self.vsLabel.text = LocalizedString.versus(game.opponent.name, homeTeam: Team.Cubs.rawValue)
        }
        
        if game.result.type == .postponed {
            self.vsLabel.alpha = 0.5
        } else {
            self.vsLabel.alpha = 1
        }
        
        self.primaryColorView.backgroundColor = game.opponent.team.primaryColor
        self.secondaryColorView.backgroundColor = game.opponent.team.secondaryColor
    }
    
    //MARK: - Cell silliness
    // Override these methods to prevent cell selection from futzing with
    // the background color of the cell's color views.
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let primary = self.primaryColorView.backgroundColor
        let secondary = self.secondaryColorView.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        self.primaryColorView.backgroundColor = primary
        self.secondaryColorView.backgroundColor = secondary
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let primary = self.primaryColorView.backgroundColor
        let secondary = self.secondaryColorView.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        self.primaryColorView.backgroundColor = primary
        self.secondaryColorView.backgroundColor = secondary
    }
}
