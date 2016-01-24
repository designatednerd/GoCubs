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
    dateLabel.text = CubsGameCell.dateFormatter.stringFromDate(game.date)
    
    if game.opponent.isHomeTeam {
      vsLabel.text = LocalizedString.versus(LocalizedString.cubs, homeTeam: game.opponent.name)
    } else {
      vsLabel.text = LocalizedString.versus(game.opponent.name, homeTeam: LocalizedString.cubs)
    }
    
    if game.result.type == .Postponed {
      vsLabel.alpha = 0.5
    } else {
      vsLabel.alpha = 1
    }
    
    primaryColorView.backgroundColor = game.opponent.colors.primary()
    secondaryColorView.backgroundColor = game.opponent.colors.secondary()
    
  }
  
  //MARK: - Cell silliness
  //Override these methods to prevent cell selection from futzing with
  // the background color of the cell's color views.
  
  override func setSelected(selected: Bool, animated: Bool) {
    let primary = primaryColorView.backgroundColor
    let secondary = secondaryColorView.backgroundColor
    
    super.setSelected(selected, animated: animated)
    
    primaryColorView.backgroundColor = primary
    secondaryColorView.backgroundColor = secondary
  }
  
  override func setHighlighted(highlighted: Bool, animated: Bool) {
    let primary = primaryColorView.backgroundColor
    let secondary = secondaryColorView.backgroundColor
    
    super.setHighlighted(highlighted, animated: animated)
    
    primaryColorView.backgroundColor = primary
    secondaryColorView.backgroundColor = secondary
  }
}