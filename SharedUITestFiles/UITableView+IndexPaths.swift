//
//  File.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/25/17.
//  Copyright © 2017 Vokal. All rights reserved.
//

import UIKit

extension UITableView {

    var cub_allAvailableIndexPaths: [IndexPath]? {
        guard let dataSource = self.dataSource else {
            return nil
        }
        
        var paths = [IndexPath]()
        guard let sections = dataSource.numberOfSections?(in: self) else {
            return nil
        }
        for section in 0..<sections {
            let rows = dataSource.tableView(self, numberOfRowsInSection: section)
            for row in 0..<rows {
                paths.append(IndexPath(row: row, section: section))
            }
        }
        
        return paths
    }
}
