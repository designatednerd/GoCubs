//
//  CubsCalendarEvent.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/26/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

struct CubsCalendarEvent {

  let month: Int
  let day: Int
  let year: Int
  let description: String
  let location: String
  let summary: String 
  
  var displayDescription: String {
    let replacedNewlines = self.description.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
    let lines = replacedNewlines.componentsSeparatedByCharactersInSet(.newlineCharacterSet())
    
    let first3Lines = Array(lines[0...2])
    
    return first3Lines.joinWithSeparator("\n")
  }
  
  var isAtWrigley: Bool {
    return self.location == "Wrigley Field, Chicago"
  }
  
  func matchesDate(date: NSDate) -> Bool {
    let components = NSCalendar.currentCalendar().components([
      .Month,
      .Day,
      .Year,
      ], fromDate: date)
    
    return self.month == components.month
      && self.day == components.day
      && self.year == components.year
  }
  
  //MARK: - Creating from iCal data

  static func fromDescription(description: String?,
    summary: String?,
    location: String?,
    dateTime: NSDate?) -> CubsCalendarEvent? {
      guard let
        description = description,
        summary = summary,
        location = location,
        dateTime = dateTime else {
          
          //Gotta have 'em all.
          return nil
      }
      
      //Location comes in with escaped commas, which then get re-escaped and look silly. 
      let locationToUse = location.stringByReplacingOccurrencesOfString("\\", withString: "")
      
      let components = NSCalendar.chicagoCalendar.components([
        .Month,
        .Day,
        .Year
        ], fromDate: dateTime)
      
      let month = components.month
      let day = components.day
      let year = components.year
      
      return CubsCalendarEvent(month: month,
        day: day,
        year: year,
        description: description,
        location: locationToUse,
        summary: summary)
  }
}