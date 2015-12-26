//
//  Cubs2015TableViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class Cubs2015TableViewController: UITableViewController {
  
  var dataSource: CubsGameDataSource!
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Setup the data source
    self.dataSource = CubsGameDataSource(tableView: self.tableView)
    
    //Make things localized and accessibile.
    self.localizeAndAccessibilize()
  }
  
  override func viewWillAppear(animated: Bool) {
    //Clear selection on VWA if the SVC is collapsed.
    if let split = self.splitViewController {
      self.clearsSelectionOnViewWillAppear = split.collapsed
    }
    
    super.viewWillAppear(animated)
  }
  
  // MARK: - Localization and acessibility
  
  private func localizeAndAccessibilize() {
    self.title = LocalizedString.listTitle
    self.tableView.accessibilityIdentifier = AccessibilityString.gamesTableview
  }
  
  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //Make sure we're working with a known segue identifier.
    let identifier = self.segueIdentifierForSegue(segue)
    
    switch identifier {
    case .showDetail:
      if let
        navController = segue.destinationViewController as? UINavigationController,
        controller = navController.topViewController as? GameDetailViewController,
        cell = sender as? CubsGameCell {
          controller.game = self.dataSource.gameForCell(cell, inTableView: self.tableView)
          controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
          controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
}

//MARK: - SegueHandler

extension Cubs2015TableViewController: SegueHandler {
  enum SegueIdentifier: String {
    case
    showDetail
  }
}
