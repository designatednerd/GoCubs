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
            self.backgroundColor = .lightGrayColor()
        } else {
            self.backgroundColor = .whiteColor()
        }
        
        self.primaryColorView.backgroundColor = .blueColor()
        self.secondaryColorView.backgroundColor = .redColor()
        
    }
}