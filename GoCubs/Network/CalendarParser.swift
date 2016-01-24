//
//  CalendarParser.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/26/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

/**
 *  Parses iCal-formatted calendar events.
 */
struct CalendarParser {
  static let EventStart = "BEGIN:VEVENT"
  static let EventEnd = "END:VEVENT"
  
  static let DescriptionPrefix = "DESCRIPTION:"
  static let StartTimePrefix = "DTSTART:"
  static let LocationPrefix = "LOCATION:"
  static let SummaryPrefix = "SUMMARY:"
  
  private static let DateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    //Event dates are sent in the format 20160419T001500Z, with the Z indicating UTC.
    formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
    formatter.timeZone = NSTimeZone(name: "UTC")
    return formatter
  }()
  
  /**
   Parse the contents of an entire ics calendar.
   
   - parameter calendarString: The string representation of the calendar.
   
   - returns: An array of CubsCalendarEvents from the calendar.
   */
  static func parseCalendarString(calendarString: String) -> [CubsCalendarEvent] {
    let eventStrings = calendarString.componentsSeparatedByString(CalendarParser.EventStart)
    let events = eventStrings.flatMap(parseEvent)
    return events
  }

  /**
   Parse a single event's string into a CubsCalendarEvent.
   
   - parameter eventString: The string representing a single event.
   
   - returns: The parsed event, or nil if not all required items are there.
   */
  static func parseEvent(eventString: String) -> CubsCalendarEvent? {
    let trimmed = eventString.stringByTrimmingCharactersInSet(.newlineCharacterSet())
    let lines = trimmed.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    
    var description: String?
    var summary: String?
    var location: String?
    var dateTime: NSDate?
    
    lines.forEach {
      line in
      
      if let desc = valueForPrefix(CalendarParser.DescriptionPrefix, forLine: line) {
        description = desc
      } else if let sum = valueForPrefix(CalendarParser.SummaryPrefix, forLine: line) {
        summary = sum
      } else if let loc = valueForPrefix(CalendarParser.LocationPrefix, forLine: line) {
        location = loc
      } else if let dt = valueForPrefix(CalendarParser.StartTimePrefix, forLine: line) {
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
