//
//  DateFormatter+Months.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import Foundation

extension DateFormatter {

    private static let cub_simpleFormatter = DateFormatter()
    
    static func cub_shortMonthName(for monthInt: Int) -> String {
        guard
            monthInt <= 12,
            monthInt >= 1 else {
                fatalError("This is not a month")
        }
        
        guard let shortMonths = self.cub_simpleFormatter.shortMonthSymbols else {
            fatalError("Could not access short month symbols")
        }

        return shortMonths[monthInt - 1]
    }    
}
