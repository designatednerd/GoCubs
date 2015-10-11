//
//  String-IntsWithDash.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation

extension String {

    func cub_asInts() -> (Int, Int) {        
        let separatedByDash = self.componentsSeparatedByString("-")
        
        let firstInt = Int(separatedByDash[0])!
        let secondInt = Int(separatedByDash[1])!
        
        return (firstInt, secondInt)
    }
}