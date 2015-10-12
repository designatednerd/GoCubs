//
//  UIColor+RGB.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

extension UIColor {
    static func cub_RGB(r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: 1)
    }
}
