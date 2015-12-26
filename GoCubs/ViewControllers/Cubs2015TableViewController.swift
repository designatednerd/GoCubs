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
    //Clear selection before VWA if the splitviewcontroller is collapsed.
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

    guard let identifierString = segue.identifier else {
      assertionFailure("Can't get segue identifier!")
      return
    }
    
    switch identifierString {
    case "showDetail":
      guard let
        navController = segue.destinationViewController as? UINavigationController,
        gameDetailVC = navController.topViewController as? GameDetailViewController,
        cell = sender as? CubsGameCell else {
          assertionFailure("Couldn't get either the nav, the detail, or the cell!")
          return
      }
      
      gameDetailVC.game = self.dataSource.gameForCell(cell, inTableView: self.tableView)
      gameDetailVC.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
      gameDetailVC.navigationItem.leftItemsSupplementBackButton = true
    default:
      assertionFailure("Unhandled segue identifier: \(identifierString)")
    }
  }
}