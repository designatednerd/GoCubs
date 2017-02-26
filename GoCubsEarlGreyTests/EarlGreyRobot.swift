//
//  EarlGreyRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/25/17.
//  Copyright © 2017 Vokal. All rights reserved.
//

import EarlGrey
import XCTest
@testable import GoCubs

struct EarlGreyRobot: BasicRobot {
    
    fileprivate func grey_getLabelText(withBlock block: @escaping (String) -> Void) -> GREYActionBlock {
        return GREYActionBlock(name: "get Label text",
                               constraints: grey_kindOfClass(UILabel.self),
                               perform: {
                                    element, errorOrNil in
                                    guard let label = element as? UILabel else {
                                        return false
                                    }
                                
                                    block(label.text ?? "")
                                    return true
                               })
    }
    
    fileprivate func earlWithInfo(_ testInfo: TestInfo) -> EarlGreyImpl {
        return EarlGreyImpl.invoked(fromFile: testInfo.file.description,
                                    lineNumber: testInfo.line)
    }
    
    func tapButton(withAccessibilityLabel label: String,
                   testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_allOfMatchers([
                    grey_accessibilityTrait(UIAccessibilityTraitButton),
                    grey_accessibilityLabel(label),
                ]))
            .perform(grey_tap())
    }
    
    func waitForLabel(withText text: String,
                      testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_accessibilityLabel(text))
            .assert(grey_sufficientlyVisible())
    }
    
    func waitForView(withAccessibilityIdentifier identifier: String,
                     testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_accessibilityID(identifier))
            .assert(grey_sufficientlyVisible())
    }
    
    func waitForTableView(withAccessibilityIdentifier identifier: String,
                          testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_allOfMatchers([
                    grey_kindOfClass(UITableView.self),
                    grey_sufficientlyVisible(),
                ]))
            .assert(grey_sufficientlyVisible())
    }
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   testInfo: TestInfo) -> String? {
        var retrievedText = ""
        
        earlWithInfo(testInfo)
            .selectElement(with: grey_allOfMatchers([
                    grey_kindOfClass(UILabel.self),
                    grey_accessibilityID(identifier)
                ]))
            .perform(grey_getLabelText(withBlock: {
                text in
                retrievedText = text
            }))
        
        GREYCondition.init(name: "Text not empty") {
                return !retrievedText.isEmpty
            }
            .wait(withTimeout: 10)
        return retrievedText
    }
}

extension EarlGreyRobot: GameListRobot {

    func tapCell(withDateText dateText: String,
                 gameText: String,
                 testInfo: TestInfo) {
        
        earlWithInfo(testInfo)
            .selectElement(with: grey_allOfMatchers([
                    grey_kindOfClass(UITableViewCell.self),
                    grey_descendant(grey_accessibilityLabel(dateText)),
                    grey_descendant(grey_accessibilityLabel(gameText)),
                    grey_sufficientlyVisible()
                ]))
            .using(searchAction: grey_scrollInDirection(.down,
                                                        1000),
                   onElementWithMatcher: grey_kindOfClass(UITableView.self))
            .perform(grey_tap())
    }
}

extension EarlGreyRobot: GameDetailRobot {

    func goBackToList(testInfo: TestInfo) {
        self.tapButton(withAccessibilityLabel: LocalizedString.listTitle,
                       testInfo: testInfo)
    }
}
