//
//  KIFRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 DesignatedNerdSoftware. All rights reserved.
//

import KIF
import XCTest
@testable import GoCubs

//MARK: - Basic Robot Conformance

struct KIFRobot: BasicRobot {
    
    var currentTestCase: XCTestCase
    
    private var kifTest: KIFTestCase {
        guard let kif = self.currentTestCase as? KIFTestCase else {
            fatalError("Trying to use a non-kif test case for KIF tests")
        }
        
        return kif
    }
    
    fileprivate func kifTester(file: StaticString,
                               line: UInt) -> KIFUITestActor {
        return self.kifTest.tester(file, line)
    }
    
    init(testCase: XCTestCase) {
        self.currentTestCase = testCase
    }
    
    func tapButton(withAccessibilityLabel label: String,
                   file: StaticString,
                   line: UInt) {
        self.kifTester(file: file, line: line).tapView(withAccessibilityLabel: label, traits: UIAccessibilityTraitButton)
    }
    
    func checkViewIsVisible(withAccessibilityLabel label: String,
                            file: StaticString,
                            line: UInt) {
        self.kifTester(file: file, line: line).waitForView(withAccessibilityLabel: label)
    }
    
    func checkViewIsVisible(withAccessibilityIdentifier identifier: String,
                            file: StaticString,
                            line: UInt) {
        self.kifTester(file: file, line: line).waitForView(withAccessibilityIdentifier: identifier)
    }
    
    func checkTableViewIsVisible(withAccessibilityIdentifier identifier: String,
                                 file: StaticString,
                                 line: UInt) {
        self.kifTester(file: file, line: line).waitForView(withAccessibilityIdentifier: identifier)
    }
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   file: StaticString,
                   line: UInt) -> String? {
    
        guard let label = self.kifTester(file: file, line: line).waitForView(withAccessibilityIdentifier: identifier) as? UILabel else {
            return nil
        }
        
        return label.text
    }
}

//MARK: - Game List Robot conformance

extension KIFRobot: GameListRobot {

    func tapCell(withDateText dateText: String,
                 gameText: String,
                 file: StaticString,
                 line: UInt) {
        guard
            let tableView = self.kifTester(file: file, line: line).waitForView(withAccessibilityIdentifier: AccessibilityString.gamesTableview) as? UITableView,
            let indexPaths = tableView.cub_allAvailableIndexPaths else {
                XCTFail("Couldn't get all index paths!",
                        file: file,
                        line: line)
                return
        }
    
        //Figure out which one we need to tap.
        guard let indexPathToTap = indexPaths.first(where: {
            indexPath in
            
            guard
                let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? CubsGameCell,
                let vsText = cell.vsLabel.text,
                let cellDateText = cell.dateLabel.text else {
                    XCTFail("Couldn't find labels to compare",
                            file: file,
                            line: line)
                    return false
            }
            
            // Are both sets of text the same?
            return vsText == gameText && cellDateText == dateText
        }) else {
            XCTFail("Could not find index path to tap for \(gameText) on \(dateText)",
                    file: file,
                    line: line)
            return
        }

        self.kifTester(file: file, line: line).tapRow(at: indexPathToTap, in: tableView)
    }
}

//MARK: - Game Detail Robot Conformance

extension KIFRobot: GameDetailRobot { /* mix-in */ }
