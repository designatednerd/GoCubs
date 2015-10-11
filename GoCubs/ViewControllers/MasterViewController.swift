//
//  MasterViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Grab a reference to the detail from the split view controller.
        if let split = self.splitViewController,
         let detail = (split.viewControllers[split.viewControllers.count-1] as! UINavigationController).topViewController as? DetailViewController{
            self.detailViewController = detail
        }
    }

    override func viewWillAppear(animated: Bool) {
        //Clear selection on VWA if the SVC is collapsed.
        if let split = self.splitViewController {
            self.clearsSelectionOnViewWillAppear = split.collapsed
        }
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let navController = segue.destinationViewController as? UINavigationController,
                let controller = navController.topViewController as? DetailViewController {
                    controller.detailItem = "Something!"
                    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}

