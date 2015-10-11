//
//  SeugueIdentifier.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation
import UIKit

enum SegueIdentifier: String {
    case
    showDetail
    
}

extension UIViewController {
    func cub_performSegueWithIdentifier(identifier: SegueIdentifier, sender: AnyObject?) {
        self.performSegueWithIdentifier(identifier.rawValue, sender: sender)
    }
}