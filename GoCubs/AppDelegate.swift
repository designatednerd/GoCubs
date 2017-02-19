//
//  AppDelegate.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 9/29/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    var window: UIWindow?

}

// MARK: - UIApplication Delegate

extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

            //Setup the Split VC
            guard let splitViewController = self.window?.rootViewController as? UISplitViewController,
                let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as? UINavigationController,
                let navigationItem = navigationController.topViewController?.navigationItem else {
                    assertionFailure("YOU CANNOT HAS SPLIT VC!")
                    return true
            }
            
            
            navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
            splitViewController.delegate = self
            return true
    }
}

// MARK: - Split view Delegate

extension AppDelegate: UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController:UIViewController,
        onto primaryViewController:UIViewController) -> Bool {
        
            guard let secondaryAsNavController = secondaryViewController as? UINavigationController,
                let topAsDetailController = secondaryAsNavController.topViewController as? GameDetailViewController
                else {
                assertionFailure("Trying to grab a detail VC that ain't there")
                return false
            }
            
            if topAsDetailController.game == nil {
                // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                return true
            }
            
            return false
    }
}
