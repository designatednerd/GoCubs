//
//  CubsGameCell.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class CubsGameCell: UITableViewCell {
    
    static let identifier = "CubsGameCell"
    static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var vsLabel: UILabel!
    @IBOutlet var primaryColorView: UIView!
    @IBOutlet var secondaryColorView: UIView!
    
    func configureForGame(game: CubsGame) {
        self.dateLabel.text = CubsGameCell.dateFormatter.stringFromDate(game.date)

        if game.opponent.isHomeTeam {
            self.vsLabel.text = LocalizedString.versus(LocalizedString.cubs, homeTeam: game.opponent.name)
        } else {
            self.vsLabel.text = LocalizedString.versus(game.opponent.name, homeTeam: LocalizedString.cubs)
        }
        
        if game.result.type == .Postponed {
            self.vsLabel.alpha = 0.5
        } else {
            self.vsLabel.alpha = 1
        }
        
        self.primaryColorView.backgroundColor = game.opponent.colors.primary()
        self.secondaryColorView.backgroundColor = game.opponent.colors.secondary()
        
    }
    
    //MARK: Cell silliness
    //Override these methods to prevent cell selection from futzing with 
    // the background color of the cell's color views.
    
    override func setSelected(selected: Bool, animated: Bool) {
        let primary = self.primaryColorView.backgroundColor
        let secondary = self.secondaryColorView.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        self.primaryColorView.backgroundColor = primary
        self.secondaryColorView.backgroundColor = secondary
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        let primary = self.primaryColorView.backgroundColor
        let secondary = self.secondaryColorView.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        self.primaryColorView.backgroundColor = primary
        self.secondaryColorView.backgroundColor = secondary
    }
}