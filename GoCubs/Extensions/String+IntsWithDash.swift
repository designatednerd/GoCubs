//
//  String-IntsWithDash.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

extension String {

    /**
     Splits a string with a "x-y" format for things like game scores, team records, 
     and pitcher records.
     
     - return: A tuple with the first value and second value available.
     */
    func cub_asInts() -> (firstValue: Int, secondValue: Int) {
        let separatedByDash = self.components(separatedBy: "-")
        
        guard separatedByDash.count == 2 else {
            fatalError("Incorrect object count for \(self)")
        }
        
        guard let
            firstInt = Int(separatedByDash[0]),
            let secondInt = Int(separatedByDash[1]) else {
                fatalError("Couldn't unwrap one of the ints!")
        }
        
        return (firstInt, secondInt)
    }
}
