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

//MARK: - Network access

struct CubsGameChecker {
  
  static let CubsCalendarURL = "http://mlb.am/tix/cubs_schedule_full"
  
  /**
   Checks to see if there is a game for a given date.
   
   @param date:     The date to check
   @param success:  The completion closure to execute on success.
   @param failure:  The completion closure to execute on failure.
   */
  static func isThereAGameForDate(date: NSDate,
    success: GameTodaySuccessCompletion,
    failure: GameTodayFailureCompletion) {
      
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

        //Could we parse it?
        let events = CalendarParser.parseCalendarString(dataString)
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
      
      task.resume()
  }
  
  
  static func errorWithDescription(description: String, code: Int) -> NSError {
    return NSError(domain: "com.designatednerd.gocubs",
      code: code,
      userInfo: [ NSLocalizedDescriptionKey: description ])
  }
}
