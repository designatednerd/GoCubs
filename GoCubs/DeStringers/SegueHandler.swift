//
//  SeugueHandler.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/11/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import UIKit

/*
 Protocol and default implementation inspired by the WWDC 2015 video "Swift in Practice"
 https://developer.apple.com/videos/play/wwdc2015-411/
 Each VC implementing this should create its own enumeration of the segues it can handle
 so that we don't need a giant list of all the segue identifiers in the entire app.
 */
protocol SegueHandler {
    
    /*
    Each enum of segue identifiers must be a raw representable.
    */
    associatedtype SegueIdentifier: RawRepresentable
}

/**
 Default implementation of SegueHandler
 */
extension SegueHandler where //The default implementation of this protocol WHEN:
    Self: UIViewController, //The item implementing this must be a UIViewController or a subclass of it.
SegueIdentifier.RawValue == String { //The raw type of the SegueIdentifier must be a string.
    
    /**
     Performs a segue with the given identifier's raw value.
    
    - parameter identifier:    The SegueIdentifier corresponding with the segue you wish to perform.
    - parameter sender:        The object sending this request to perform a segue.
    */
    func performSegueWithSegueIdentifier(_ identifier: SegueIdentifier, sender: AnyObject?) {
        self.performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    /**
     Tries to find appropriate segue identifier for the given UIStoryboardSegue. Kills app with
     obvious error if not found.
     
     - parameter segue:  The segue which is about to be performed.
     - returns:          The SegueIdentifier which corresponds to the segue being performed.
     */
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifierString = segue.identifier,
            let identifier = SegueIdentifier(rawValue: identifierString) else {
                //Fatal error since this will certainly crash on prod anyway if we try it, so let's at least be clear about it.
                fatalError("No segue found for identifier \(segue.identifier) in view controller \(type(of: self))")
        }
        
        return identifier
    }
}
