//
//  GameTodayViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/26/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class GameTodayViewController: UIViewController {
  
  //MARK: - Properties
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var yesOrNoLabel: UILabel!
  @IBOutlet var detailsLabel: UILabel!
  @IBOutlet var closeButton: UIButton!
  
  private let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .LongStyle
    return formatter
  }()
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.localizeAndAccessibilize()
    self.findOutIfTheresAGameToday()
  }
  
  private func localizeAndAccessibilize() {
    self.title = LocalizedString.gameTodayTitle
    self.closeButton.accessibilityLabel = AccessibilityString.closeButton
  }
  
  //MARK: - IBActions
  
  @IBAction private func close() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  //MARK: - Network
  
  private func findOutIfTheresAGameToday() {
    if false {
      let today = NSDate()
      self.findOutIfTheresAGameForDate(today)
    } else {
      let dateComponents = NSDateComponents()
      dateComponents.month = 4
      dateComponents.day = 19
      dateComponents.year = 2016
      if let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents) {
        self.findOutIfTheresAGameForDate(date)
      }
    }
  }
  
  func findOutIfTheresAGameForDate(date: NSDate) {
    self.dateLabel.text = self.dateFormatter.stringFromDate(date)

    //Since we have to ask the interwebs, show something that loads.
    self.yesOrNoLabel.text = LocalizedString.gameTodayLoading
    CubsGameChecker.isThereAGameForDate(date,
      success: {
        [weak self]
        isThereAGame, details in
        self?.configureForGame(isThereAGame, details: details)
      },
      failure: {
        [weak self]
        error in
        self?.configureForError(error)        
      }
    )
  }
  
  private func configureForGame(isThereAGame: Bool, details: String) {
    if isThereAGame {
      self.yesOrNoLabel.text = LocalizedString.gameTodayPositive
    } else {
      self.yesOrNoLabel.text = LocalizedString.gameTodayNegative
    }
    
    self.detailsLabel.text = details
  }
  
  private func configureForError(error: NSError) {
    self.yesOrNoLabel.text = LocalizedString.gameTodayError
    self.detailsLabel.text = error.localizedDescription
  }
}
