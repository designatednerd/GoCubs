//
//  NSDateFormatter+Once.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

extension NSDateFormatter {

  //Since NSDateFormatter inherits from NSObject, you have to mark this
  //as @nonobjc or you'll get an error about how a declaration can't be 
  //both final and dynamic.
  @nonobjc static let cub_longDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .LongStyle
    return formatter
  }()
  
  @nonobjc static let cub_monthDayDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "M/d"
    return formatter
  }()
}
