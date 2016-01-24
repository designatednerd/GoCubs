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
  @IBOutlet var parkingLabel: UILabel!
  @IBOutlet var detailsLabel: UILabel!
  @IBOutlet var closeButton: UIButton!
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Clear the initial detail text
    detailsLabel.text = nil
    
    findOutIfTheresAGameToday()
//PART1
    setupAccessibilityAndLocalization()
  }
  
  private func setupAccessibilityAndLocalization() {
    titleLabel.text = LocalizedString.gameTodayTitle
    closeButton.accessibilityLabel = AccessibilityLabel.closeButton
//PART1
  }
  
  //MARK: - IBActions
  
  @IBAction private func close() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  //MARK: - Network
  
  private func findOutIfTheresAGameToday() {
//PART3
    var gameDate: NSDate
    if let
      month = LaunchEnvironmentKey.MonthToTest.processInfoValue(),
      monthInt = Int(month),
      day = LaunchEnvironmentKey.DayToTest.processInfoValue(),
      dayInt = Int(day),
      year = LaunchEnvironmentKey.YearToTest.processInfoValue(),
      yearInt = Int(year) {
        
        let dateComponents = NSDateComponents()
        dateComponents.month = monthInt
        dateComponents.day = dayInt
        dateComponents.year = yearInt
        if let date = NSCalendar.currentCalendar().dateFromComponents (dateComponents) {
          gameDate = date
        } else {
          assertionFailure()
          //In production: Just use today's date
          gameDate = NSDate()
        }
    } else {
      //Things weren't passed in, actualy use today's date.
      gameDate = NSDate()
    }
//PART3
//    let gameDate = NSDate()
    findOutIfTheresAGameForDate(gameDate)
  }
  
  func findOutIfTheresAGameForDate(date: NSDate) {
    //Show the date we're checking
    dateLabel.text = NSDateFormatter.longDateFormatter.stringFromDate(date)
    
    //Since we have to ask the interwebs, show some stuff to indicate loading.
    yesOrNoLabel.text = LocalizedString.gameTodayLoading
    parkingLabel.text = LocalizedString.parkingLoading
    
    //Actually find out if there's a game.
    CubsGameChecker.isThereAGameForDate(date, failure: {
      [weak self]
      error in
      self?.configureForError(error)
      }) {
        [weak self]
        isThereAGame, details in
        self?.configureForGame(isThereAGame, details: details)
    }
  }
  
  private func configureForGame(isThereAGame: Bool, details: String) {
    if isThereAGame {
      yesOrNoLabel.text = LocalizedString.gameTodayPositive
      yesOrNoLabel.textColor = .blueColor()
      parkingLabel.text = LocalizedString.parkingTerrible
    } else {
      yesOrNoLabel.text = LocalizedString.gameTodayNegative
      yesOrNoLabel.textColor = .redColor()
      parkingLabel.text = LocalizedString.parkingOK
    }
    
    detailsLabel.text = details
  }
  
  private func configureForError(error: NSError) {
    parkingLabel.text = nil
    yesOrNoLabel.text = LocalizedString.gameTodayError
    detailsLabel.text = error.localizedDescription
  }
}
