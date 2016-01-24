//
//  NSCalendar+Chicago.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

extension NSCalendar {

  //Since NSCalendar inherits from NSObject, you have to mark this
  //as @nonobjc or you'll get an error about how a declaration can't be
  //both final and dynamic.
  @nonobjc static let chicagoCalendar: NSCalendar = {
    let calendar = NSCalendar.currentCalendar()
    
    //We need to make sure everything is converted to Chicago time.
    guard let chicagoTime = NSTimeZone(name: "America/Chicago") else {
      assertionFailure("Can't create time zone!")
      return calendar
    }
    
    calendar.timeZone = chicagoTime
    
    return calendar
  }()
}
