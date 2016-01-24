//
//  AppDelegate.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
  
  var window: UIWindow?
  
}

// MARK: - UIApplication Delegate

extension AppDelegate: UIApplicationDelegate {
  
  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
      //Setup the Split VC
      guard let splitViewController = self.window?.rootViewController as? UISplitViewController,
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as? UINavigationController,
        let navigationItem = navigationController.topViewController?.navigationItem else {
          assertionFailure("YOU CANNOT HAS SPLIT VC!")
          return true
      }
      
      
      navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
      splitViewController.delegate = self
      
//PART3
      if UIApplication.isUITesting() {
        CubsGameChecker.ShouldUseLiveData = false
      }
//PART3
      
      return true
  }
}

// MARK: - Split view Delegate

extension AppDelegate: UISplitViewControllerDelegate {
  
  func splitViewController(splitViewController: UISplitViewController,
    collapseSecondaryViewController secondaryViewController:UIViewController,
    ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
      
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
