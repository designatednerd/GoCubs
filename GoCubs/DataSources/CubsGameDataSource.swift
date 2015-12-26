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
    
    var csvString: String
    
    do {
      csvString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
    } catch {
      csvString = ""
    }
    
    let lines = csvString.componentsSeparatedByCharactersInSet(.newlineCharacterSet())
    
    var gameBuilder = [CubsGame]()
    for line in lines {
      if line.endIndex != line.startIndex {
        let game = CubsGame(gameString: line)
        gameBuilder.append(game)
      }
    }
    
    //Sort in reverse date order
    gameBuilder.sortInPlace {
      $0.date.compare($1.date) == NSComparisonResult.OrderedDescending
    }
    
    self.games = gameBuilder
    
    super.init()
    
    tableView.dataSource = self
    tableView.reloadData()
  }
  
  //MARK: Confgiuration Helper
  
  func gameForCell(cell: CubsGameCell, inTableView tableView: UITableView) -> CubsGame {
    guard let indexPath = tableView.indexPathForCell(cell) else {
      fatalError("There is no index path for this cell!")
    }
    
    return self.games[indexPath.row]
  }
}

//MARK: - UITableViewDataSource

extension CubsGameDataSource: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.games.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(CubsGameCell.identifier) as? CubsGameCell else {
      fatalError("Wrong  cell type!")
    }
    
    let game = self.games[indexPath.row]
    cell.configureForGame(game)
    return cell
  }
}
