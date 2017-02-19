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
        guard let path = Bundle.main.path(forResource: "cubs2015", ofType: "csv") else {
            fatalError("Could not create path for CSV!")
        }
        
        var csvString: String
        
        do {
            csvString = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
        } catch {
            csvString = ""
        }
        
        let lines = csvString.components(separatedBy: .newlines)
        
        var gameBuilder = [CubsGame]()
        for line in lines {
            if line.endIndex != line.startIndex {
                let game = CubsGame(gameString: line)
                gameBuilder.append(game)
            }
        }

        //Sort in reverse date order
        gameBuilder.sort {
            $0.date.compare($1.date as Date) == ComparisonResult.orderedDescending
        }
        
        self.games = gameBuilder
        
        super.init()
        
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    //MARK: Confgiuration Helper
    
    func gameForCell(_ cell: CubsGameCell, inTableView tableView: UITableView) -> CubsGame {
        guard let indexPath = tableView.indexPath(for: cell) else {
            fatalError("There is no index path for this cell!")
        }
        
        return self.games[indexPath.row]
    }
}

//MARK: - UITableViewDataSource

extension CubsGameDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CubsGameCell.identifier) as? CubsGameCell else {
            fatalError("Wrong  cell type!")
        }

        let game = self.games[indexPath.row]
        cell.configureForGame(game)
        return cell
    }
}
