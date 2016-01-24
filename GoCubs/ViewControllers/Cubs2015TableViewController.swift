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
  
  @IBOutlet var gameTodayButton: UIBarButtonItem!
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Setup the data source
    dataSource = CubsGameDataSource(tableView: tableView)
    
//PART1
    //Make things localized and accessibile.
    setupAccessibilityAndLocalization()
//PART1
  }
  
  override func viewWillAppear(animated: Bool) {
    //Clear selection before VWA if the splitviewcontroller is collapsed.
    if let split = splitViewController {
      clearsSelectionOnViewWillAppear = split.collapsed
    }
    
    super.viewWillAppear(animated)
  }
//PART1
  
  // MARK: - Localization and acessibility
  
  private func setupAccessibilityAndLocalization() {
    title = LocalizedString.listTitle
    tableView.accessibilityIdentifier = AccessibilityIdentifier.GamesTableview.rawValue
    gameTodayButton.accessibilityLabel = LocalizedString.gameTodayTitle
  }
//PART1
  
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
      
      gameDetailVC.game = dataSource.gameForCell(cell, inTableView: tableView)
      gameDetailVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
      gameDetailVC.navigationItem.leftItemsSupplementBackButton = true
      
    case "showGameToday":
      //Nothing to do here, but we want to acknowledge this was handled so:
      break
    default:
      assertionFailure("Unhandled segue identifier: \(identifierString)")
    }
  }
}
