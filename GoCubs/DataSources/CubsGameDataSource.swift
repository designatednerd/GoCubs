//
//  CubsGameDataSource.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation
import UIKit

class CubsGameDataSource: NSObject {
  
  let games: [CubsGame]
  
  init(tableView: UITableView) {
    //Load in the string
    guard let path = NSBundle.mainBundle().pathForResource("cubs2015", ofType: "csv") else {
      fatalError("Could not create path for CSV!")
    }
    
    let csvString = try? NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
    let lines = (csvString ?? "").componentsSeparatedByCharactersInSet(.newlineCharacterSet())
    var gameBuilder: [CubsGame] = lines.flatMap { line in
    
      if (line.endIndex != line.startIndex) {
        //The line has content
        return CubsGame(gameString: line)
      } else {
        //The line does not have content.
        return nil
      }
    }
    
    //Sort in reverse date order
    gameBuilder.sortInPlace {
      $0.date.compare($1.date) == NSComparisonResult.OrderedDescending
    }
    
    games = gameBuilder
    
    super.init()
    
    tableView.dataSource = self
    tableView.reloadData()
  }
  
  //MARK: Confgiuration Helper
  
  func gameForCell(cell: CubsGameCell, inTableView tableView: UITableView) -> CubsGame {
    guard let indexPath = tableView.indexPathForCell(cell) else {
      fatalError("There is no index path for this cell!")
    }
    
    return games[indexPath.row]
  }
}

//MARK: - UITableViewDataSource

extension CubsGameDataSource: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(CubsGameCell.identifier) as? CubsGameCell else {
      fatalError("Wrong  cell type!")
    }
    
    let game = games[indexPath.row]
    cell.configureForGame(game)
    return cell
  }
}
