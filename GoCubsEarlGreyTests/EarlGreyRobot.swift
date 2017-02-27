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

struct EarlGreyRobot {
    
    //MARK: - Earl grey helpers
    
    fileprivate func getLabelText(withBlock block: @escaping (String) -> Void) -> GREYActionBlock {
        return self.retriveElementOfClass(UILabel.self) {
            possibleLabel in
            guard
                let label = possibleLabel,
                let text = label.text else {
                    block("")
                    return
            }
            
            block(text)
        }
    }
    
    fileprivate func retriveElementOfClass<T>(_ clazz: T.Type, _ completion: @escaping (T?) -> Void) -> GREYActionBlock where T: AnyObject {
        return GREYActionBlock(name: "Get element of class \(T.self)",
            constraints: grey_kindOfClass(T.self),
            perform: {
                element, errorOrNil in
                
                guard let typedElement = element as? T else {
                    return false
                }
                
                completion(typedElement)
                return true
        })
    }
    
    fileprivate func earlWithInfo(_ testInfo: TestInfo) -> EarlGreyImpl {
        return EarlGreyImpl.invoked(fromFile: testInfo.file.description,
                                    lineNumber: testInfo.line)
    }
}

//MARK: - BasicRobot conformance

extension EarlGreyRobot: BasicRobot {
    
    func tapButton(withAccessibilityLabel label: String,
                   testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_allOfMatchers([
                    grey_accessibilityTrait(UIAccessibilityTraitButton),
                    grey_accessibilityLabel(label),
                ]))
            .perform(grey_tap())
    }

    func checkViewIsVisible(withAccessibilityLabel label: String,
                            testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_accessibilityLabel(label))
            .assert(grey_sufficientlyVisible())
    }
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: String,
                            testInfo: TestInfo) {
        earlWithInfo(testInfo)
            .selectElement(with: grey_accessibilityID(identifier))
            .assert(grey_sufficientlyVisible())
    }
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: String,
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
            .perform(self.getLabelText(withBlock: {
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

//MARK: - Game List Robot conformance

extension EarlGreyRobot: GameListRobot {

    func tapCell(withDateText dateText: String,
                 gameText: String,
                 testInfo: TestInfo) {
        
        earlWithInfo(testInfo)
            .selectElement(with: grey_kindOfClass(UITableView.self))
            .perform(self.retriveElementOfClass(UITableView.self) {
                tableView in
                guard
                    let table = tableView,
                    let indexPaths = table.cub_allAvailableIndexPaths else {
                        XCTFail("No table or index paths",
                                file: testInfo.file,
                                line: testInfo.line)
                        return
                }
                
                guard let indexPathToScrollTo = indexPaths.first(where: {
                    indexPath in
                    guard let cell = table.dataSource?.tableView(table, cellForRowAt: indexPath) as? CubsGameCell,
                        let cellGameText = cell.vsLabel.text,
                        let cellDateText = cell.dateLabel.text else {
                        return false
                    }
                    
                    return cellDateText == dateText
                           && cellGameText == gameText
                }) else {
                    XCTFail("No index path to scroll to!",
                            file: testInfo.file,
                            line: testInfo.line)
                    return
                }

                let cellRect = table.rectForRow(at: indexPathToScrollTo)
                table.scrollRectToVisible(cellRect, animated: true)
                
                // Now that the cell is visible, tap it.
                self.earlWithInfo(testInfo)
                    .selectElement(with: grey_allOfMatchers([
                        grey_descendant(grey_accessibilityLabel(dateText)),
                        grey_descendant(grey_accessibilityLabel(gameText)),
                        grey_kindOfClass(UITableViewCell.self),
                        grey_sufficientlyVisible()
                    ]))
                    .perform(grey_tap())
            })
    }
}

//MARK: - Game Detail Robot conformance

extension EarlGreyRobot: GameDetailRobot {

    func goBackToList(testInfo: TestInfo) {
        self.tapButton(withAccessibilityLabel: LocalizedString.listTitle,
                       testInfo: testInfo)
    }
}
