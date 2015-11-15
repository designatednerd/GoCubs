//
//  TeamColors.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

//TODO: Figure out why string literals aren't working.

enum TeamColors: String {
    case
    Braves, //= "Braves",
    Brewers, // = "Brewers",
    Cardinals, // = "Cardinals",
    Cubs, // = "Cubs",
    Diamondbacks = "D-backs",
    Dodgers, // = "Dodgers",
    Giants, // = "Giants",
    Indians, // = "Indians",
    Marlins, // = "Marlins",
    Mets, // = "Mets",
    Nationals, // = "Nationals",
    Padres, // = "Padres",
    Phillies, // = "Phillies",
    Pirates, // = "Pirates",
    Reds, // = "Reds",
    Rockies, // = "Rockies",
    Royals, // = "Royals",
    Tigers, // = "Tigers",
    Twins, // = "Twins",
    WhiteSox = "White Sox"
    
    //http://teamcolors.arc90.com/
    
    func primary() -> UIColor {
        switch self {
        case .Braves:
            return .cub_RGB(0, 47, 95)
        case .Brewers:
            return .cub_RGB(24, 43, 73)
        case .Cardinals:
            return .cub_RGB(196, 30, 58)
        case .Cubs:
            return .cub_RGB(0, 50, 121)
        case .Diamondbacks:
            return .cub_RGB(167, 25, 48)
        case .Dodgers:
            return .cub_RGB(8, 60, 107)
        case .Giants:
            return .blackColor()
        case .Indians:
            return .cub_RGB(0, 51, 102)
        case .Marlins:
            return .blackColor()
        case .Mets:
            return .cub_RGB(0, 44, 119)
        case .Nationals:
            return .cub_RGB(186, 18, 43)
        case .Padres:
            return .cub_RGB(0, 33, 71)
        case .Pirates:
            return .blackColor()
        case .Phillies:
            return .cub_RGB(186, 12, 47)
        case .Reds:
            return .cub_RGB(198, 1, 31)
        case .Rockies:
            return .cub_RGB(51, 51, 102)
        case .Royals:
            return .cub_RGB(21, 49, 126)
        case .Tigers:
            return .cub_RGB(0, 23, 66)
        case .Twins:
            return .cub_RGB(7, 39, 84)
        case .WhiteSox:
            return .blackColor()
        }
    }
    
    func secondary() -> UIColor {
        switch self {
        case .Braves:
            return .cub_RGB(183, 18, 52)
        case .Brewers:
            return .cub_RGB(146, 117, 76)
        case .Cardinals:
            return .cub_RGB(10, 34, 82)
        case .Cubs:
            return .cub_RGB(204, 0, 51)
        case .Diamondbacks:
            return .blackColor()
        case .Dodgers:
            return .redColor()
        case .Giants:
            return .cub_RGB(242, 85, 44)
        case .Indians:
            return .cub_RGB(211, 3, 53)
        case .Marlins:
            return .cub_RGB(249, 66, 58)
        case .Mets:
            return .cub_RGB(251, 79, 20)
        case .Nationals:
            return .cub_RGB(17, 34, 91)
        case .Padres:
            return .cub_RGB(180, 167, 108)
        case .Phillies:
            return .cub_RGB(0, 48, 135)
        case .Pirates:
            return .cub_RGB(253, 184, 41)
        case .Reds:
            return .blackColor()
        case .Rockies:
            return .cub_RGB(192, 192, 192)
        case .Royals:
            return .cub_RGB(116, 180, 250)
        case .Tigers:
            return .cub_RGB(222, 68, 6)
        case .Twins:
            return .cub_RGB(197, 1, 31)
        case .WhiteSox:
            return .cub_RGB(192, 192, 192)
        }
    }
    
    static let rainoutBlue = UIColor.cub_RGB(158, 206, 208)
}

private extension UIColor {
    static func cub_RGB(r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0),
            green: CGFloat(g / 255.0),
            blue: CGFloat(b / 255.0),
            alpha: 1)
    }
}
