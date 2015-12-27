//
//  GameTodayChecker.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/26/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

//MARK: Completion typealiases
typealias GameTodaySuccessCompletion = (isThereAGame: Bool, details: String) -> Void
typealias GameTodayFailureCompletion = (error: NSError) -> Void
typealias ScheduleLoadedSuccessCompletion = (schedule: [CubsCalendarEvent]) -> Void

//MARK: - Network access

struct CubsGameChecker {
  
  static let CubsCalendarURL = "http://mlb.am/tix/cubs_schedule_full"
  static var ShouldUseLiveData = true
  
  /**
   Checks to see if there is a game for a given date.
   
   @param date:     The date to check
   @param failure:  The completion closure to execute on failure.
   @param success:  The completion closure to execute on success.
   */
  static func isThereAGameForDate(date: NSDate,
    failure: GameTodayFailureCompletion,
    success: GameTodaySuccessCompletion) {
      
      //First, load up the calendar.
      self.loadCubsCalendar(failure) {
        events in
        
        //Did we actually get any events parsed out?
        guard events.count > 0 else {
          dispatch_async(dispatch_get_main_queue()) {
            failure(error: self.errorWithDescription("Parsing Error!", code: 668))
          }
          
          return
        }
        
        //What's happening on that day?
        let eventsForDate = events.filter { $0.matchesDate(date) }
        if eventsForDate.count == 0 {
          //There is definitely not a game on that day.
          dispatch_async(dispatch_get_main_queue()) {
            success(isThereAGame: false, details: LocalizedString.noGameDetail)
          }
          return
        }
        
        //Are any of the events happening today at Wrigley?
        let isAtWrigley = eventsForDate.reduce(false) {
          startAtWrigley, event in
          if startAtWrigley {
            //There's definitely an event at wrigley.
            return true
          }
          
          return event.isAtWrigley
        }
        
        let description = eventsForDate.map { $0.displayDescription }.joinWithSeparator("\n\n")
        
        dispatch_async(dispatch_get_main_queue()) {
          success(isThereAGame: isAtWrigley, details: description)
        }
      }
  }
  
  /**
   Loads the full Cubs calendar from Major League Baseball.
   
   - parameter failure: The completion closure to execute on failure.
   - parameter success: The completion closure to execute on success.
   */
  static func loadCubsCalendar(failure: GameTodayFailureCompletion,
    success: ScheduleLoadedSuccessCompletion) {
      
      guard self.ShouldUseLiveData else {
        //Load from disk and bail.
        self.loadCubsCalendarFromDisk(failure, success: success)
        return
      }
      
      //Keep going with the interwebs.
      guard let url = NSURL(string: CubsGameChecker.CubsCalendarURL) else {
        dispatch_async(dispatch_get_main_queue()) {
          failure(error: self.errorWithDescription("Couldn't create URL!", code: 666))
        }
        return
      }
      
      let request = NSMutableURLRequest(URL: url)
      
      let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        data, response, error in
        
        //Did something definitely fail?
        if let error = error {
          dispatch_async(dispatch_get_main_queue()) {
            failure(error: error)
          }
          return
        }
        
        //Did we get usable data?
        guard let
          data = data,
          dataString = String(data: data, encoding: NSUTF8StringEncoding) else {
            dispatch_async(dispatch_get_main_queue()) {
              failure(error: self.errorWithDescription("No data returned!", code: 667))
            }
            return
        }
        
        //We got it!
        success(schedule: CalendarParser.parseCalendarString(dataString))
      }
      
      //The thing I forget to do 99.9999% of the time.
      task.resume()
  }
  
  /**
   Loads the calendar data from a file which was saved to disk on 12/27/15.
   
   - parameter failure: The completion closure to execute on failure.
   - parameter success: The completion closure to execute on success.
   */
  static func loadCubsCalendarFromDisk(failure: GameTodayFailureCompletion, success: ScheduleLoadedSuccessCompletion) {
    
    guard let filePath = NSBundle.mainBundle().pathForResource("cubs_schedule_full", ofType: "ics") else {
      failure(error: self.errorWithDescription("Couldn't create file path!", code: 701))
      return
    }
    
    guard let calendarData = NSData(contentsOfFile: filePath) else {
      failure(error: self.errorWithDescription("Couldn't load calendar data!", code: 702))
      return
    }
    
    guard let calendarString = String(data: calendarData, encoding: NSUTF8StringEncoding) else {
      failure (error: self.errorWithDescription("Couldn't turn calendar data into a string!", code: 703))
      return
    }
    
    success(schedule: CalendarParser.parseCalendarString(calendarString))
  }
  
  //MARK: - Private helpers
  
  private static func errorWithDescription(description: String, code: Int) -> NSError {
    return NSError(domain: "com.rwdevcon.gocubs",
      code: code,
      userInfo: [ NSLocalizedDescriptionKey: description ])
  }
}
