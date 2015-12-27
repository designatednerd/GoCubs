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
    return false
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
}