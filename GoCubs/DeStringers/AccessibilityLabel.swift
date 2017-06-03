//
//  AccessibilityLabel.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 10/12/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import Foundation

/**
 A centralized place to store accessibility labels so you can refer to them in both
 the application and tests. 
 
 Accessiblity labels will be read out loud to VoiceOver users. They should be localized 
 so that such users don't randomly hear the developer's language instead of their own.
 
 NOTE: This is an enum instead of a class or a struct so it can't be instantiated, but we 
 can't use normal enum cases since those require a value which is set at compile time.
 */
enum AccessibilityLabel {
    
    //MARK: Flag
    
    static let cubsWin = NSLocalizedString("Cubs won!",
                                           comment: "Accessibility for win flag")
    
    static let cubsLose = NSLocalizedString("Cubs lost.",
                                            comment: "Accessibility for lose flag")
    
    static let tieGame = NSLocalizedString("Tie game! That's unusual.",
                                           comment: "Accessibility for tie flag")
    
    static let postponed = NSLocalizedString("The game was postponed.",
                                             comment: "Accessibility for postponed flag")
}
    
