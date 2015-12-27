//
//  CalendarParser.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/26/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

struct CalendarParser {
  static let EventStart = "BEGIN:VEVENT"
  static let EventEnd = "END:VEVENT"
  
  static let DescriptionPrefix = "DESCRIPTION:"
  static let StartTimePrefix = "DTSTART:"
  static let LocationPrefix = "LOCATION:"
  static let SummaryPrefix = "SUMMARY:"
  
  private static let DateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    //20160419T001500Z
    formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
    return formatter
  }()
  
  private static let Calendar: NSCalendar = {
    return NSCalendar.currentCalendar()
  }()
  
  static func parseCalendarString(calendarString: String) -> [CubsCalendarEvent] {
    let eventStrings = calendarString.componentsSeparatedByString(CalendarParser.EventStart)
    let events = eventStrings.flatMap(parseEvent)
    return events
  }
  
  static func parseEvent(eventString: String) -> CubsCalendarEvent? {
    let trimmed = eventString.stringByTrimmingCharactersInSet(.newlineCharacterSet())
    let lines = trimmed.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    
    var description: String?
    var summary: String?
    var location: String?
    var dateTime: NSDate?
    
    lines.forEach {
      line in
      
      if let desc = self.valueForPrefix(CalendarParser.DescriptionPrefix, forLine: line) {
        description = desc
      } else if let sum = self.valueForPrefix(CalendarParser.SummaryPrefix, forLine: line) {
        summary = sum
      } else if let loc = self.valueForPrefix(CalendarParser.LocationPrefix, forLine: line) {
        location = loc
      } else if let dt = self.valueForPrefix(CalendarParser.StartTimePrefix, forLine: line) {
        dateTime = CalendarParser.DateFormatter.dateFromString(dt)
      }
    }

   return CubsCalendarEvent.fromDescription(description,
    summary: summary,
    location: location,
    dateTime: dateTime)
  }
  
  private static func valueForPrefix(prefix: String, forLine line: String) -> String? {
    if line.hasPrefix(prefix) {
      if let
        prefixRange = line.rangeOfString(prefix),
        firstAfter = prefixRange.last?.successor() {
        return line.substringFromIndex(firstAfter)
      }
    }
    
    return nil
  }
}
