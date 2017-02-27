//
//  PortionOfYear.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/26/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import Foundation

enum PortionOfYear {
    case
    regularSeason,
    divisionSeries,
    leagueChampionshipSeries,
    worldSeries
    
    var localizedName: String {
        switch self {
        case .divisionSeries:
            return LocalizedString.NLDS
        case .leagueChampionshipSeries:
            return LocalizedString.NLCS
        case .worldSeries:
            return LocalizedString.worldSeries
        case .regularSeason:
            return LocalizedString.regularSeason
        }
    }
    
    var seasonStringSeparator: String {
        switch self {
        case .regularSeason:
            return LocalizedString.onThe
        default:
            return LocalizedString.inThe
        }
    }
    
    var beginMonth: Int {
        switch self {
        case .regularSeason:
            return 4 //April
        case .divisionSeries,
             .leagueChampionshipSeries,
             .worldSeries:
            return 10 //October
        }
    }
    
    var endMonth: Int {
        switch self {
        case .regularSeason,
             .divisionSeries,
             .leagueChampionshipSeries:
            return 10 // october
        case .worldSeries:
            return 11 // november
        }
    }
    
    var beginDay: Int {
        switch self {
        case .regularSeason:
            return 1
        case .divisionSeries:
            return 7
        case .leagueChampionshipSeries:
            return 15
        case .worldSeries:
            return 25
        }
    }
    
    var gamesRequiredToWinSeries: Int {
        switch self {
        case .divisionSeries:
            return 3
        case .leagueChampionshipSeries,
             .worldSeries:
            return 4
        case .regularSeason:
            return 162 
        }
    }
    
    static func forDate(_ date: Date) -> PortionOfYear {
        let components = (Calendar.current as NSCalendar).components([.day, .month], from: date)
        guard
            let month = components.month,
            let day = components.day else {
                fatalError("Could not get day and month for date!")
        }
        
        switch month {
        case self.regularSeason.beginMonth..<self.divisionSeries.beginMonth:
            return .regularSeason
        case self.regularSeason.endMonth:
            switch day {
            case 1..<self.divisionSeries.beginDay:
                return .regularSeason
            case self.divisionSeries.beginDay..<self.leagueChampionshipSeries.beginDay:
                return .divisionSeries
            case self.leagueChampionshipSeries.beginDay..<self.worldSeries.beginDay:
                return .leagueChampionshipSeries
            case self.worldSeries.beginDay...31:
                return .worldSeries
            default:
                fatalError("Unhandled day: \(day)")
            }
        case self.worldSeries.endMonth:
            return .worldSeries
        default:
            fatalError("Unhandled month: \(month)")
        }
    }
}
