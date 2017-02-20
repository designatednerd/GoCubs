//
//  TeamColors.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import UIKit

enum Team: String {
    case
    Angels,
    Astros,
    Athletics,
    BlueJays = "Blue Jays",
    Braves,
    Brewers,
    Cardinals,
    Cubs,
    Diamondbacks = "D-backs",
    Dodgers,
    Giants,
    Indians,
    Mariners,
    Marlins,
    Mets,
    Nationals,
    Orioles,
    Padres,
    Phillies,
    Pirates,
    Rangers,
    Rays,
    Reds,
    RedSox = "Red Sox",
    Rockies,
    Royals,
    Tigers,
    Twins,
    WhiteSox = "White Sox",
    Yankees
    
    //http://jim-nielsen.com/teamcolors/
    
    var primaryColor: UIColor {
        switch self {
        case .Angels:
            return .cub_RGB(186, 0, 33)
        case .Astros:
            return .cub_RGB(0, 45, 98)
        case .Athletics:
            return .cub_RGB(0, 56, 49)
        case .BlueJays:
            return .cub_RGB(19, 74, 142)
        case .Braves:
            return .cub_RGB(206, 17, 65)
        case .Brewers:
            return .cub_RGB(10, 35, 81)
        case .Cardinals:
            return .cub_RGB(196, 30, 58)
        case .Cubs:
            return .cub_RGB(14, 51, 134)
        case .Diamondbacks:
            return .cub_RGB(167, 25, 48)
        case .Dodgers:
            return .cub_RGB(0, 90, 156)
        case .Giants:
            return .black
        case .Indians:
            return .cub_RGB(227, 25, 55)
        case .Mariners:
            return .cub_RGB(12, 44, 86)
        case .Marlins:
            return .black
        case .Mets:
            return .cub_RGB(0, 45, 114)
        case .Nationals:
            return .cub_RGB(171, 0, 3)
        case .Orioles:
            return .cub_RGB(223, 70, 1)
        case .Padres:
            return .cub_RGB(0, 45, 98)
        case .Pirates:
            return .black
        case .Phillies:
            return .cub_RGB(40, 72, 152)
        case .Rangers:
            return .cub_RGB(192, 17, 31)
        case .Rays:
            return .cub_RGB(9, 44, 92)
        case .Reds:
            return .cub_RGB(198, 1, 31)
        case .RedSox:
            return .cub_RGB(189, 48, 57)
        case .Rockies:
            return .cub_RGB(51, 51, 102)
        case .Royals:
            return .cub_RGB(0, 70, 135)
        case .Tigers:
            return .cub_RGB(12, 44, 86)
        case .Twins:
            return .cub_RGB(0, 43, 92)
        case .WhiteSox:
            return .black
        case .Yankees:
            return .cub_RGB(228, 0, 43)
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .Angels:
            return .cub_RGB(0, 50, 99)
        case .Astros:
            return .cub_RGB(235, 110, 31)
        case .Athletics:
            return .cub_RGB(239, 178, 30)
        case .BlueJays:
            return .cub_RGB(232, 41, 28)
        case .Braves:
            return .cub_RGB(19, 39, 79)
        case .Brewers:
            return .cub_RGB(182, 146, 46)
        case .Cardinals:
            return .cub_RGB(0, 0, 102)
        case .Cubs:
            return .cub_RGB(204, 52, 51)
        case .Diamondbacks:
            return .black
        case .Dodgers:
            return .cub_RGB(239, 62, 66)
        case .Giants:
            return .cub_RGB(253, 90, 30)
        case .Indians:
            return .cub_RGB(0, 43, 92)
        case .Mariners:
            return .cub_RGB(0, 92, 92)
        case .Marlins:
            return .cub_RGB(255, 102, 0)
        case .Mets:
            return .cub_RGB(255, 89, 16)
        case .Nationals:
            return .cub_RGB(17, 34, 91)
        case .Orioles:
            return .black
        case .Padres:
            return .cub_RGB(127, 65, 28)
        case .Phillies:
            return .cub_RGB(232, 24, 40)
        case .Pirates:
            return .cub_RGB(253, 184, 39)
        case .Rangers:
            return .cub_RGB(0, 50, 120)
        case .Rays:
            return .cub_RGB(143, 188, 230)
        case .Reds:
            return .black
        case .RedSox:
            return .cub_RGB(13, 43, 86)
        case .Rockies:
            return .cub_RGB(35, 31, 32)
        case .Royals:
            return .cub_RGB(192, 154, 91)
        case .Tigers:
            return .white
        case .Twins:
            return .cub_RGB(211, 17, 69)
        case .WhiteSox:
            return .cub_RGB(196, 206, 212)
        case .Yankees:
            return .cub_RGB(0, 48, 135)
        }
    }
}

extension UIColor {
    static func cub_RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0),
            green: CGFloat(g / 255.0),
            blue: CGFloat(b / 255.0),
            alpha: 1)
    }
}
