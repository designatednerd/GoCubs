//
//  KIFRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Vokal. All rights reserved.
//

import KIF
import XCTest
@testable import GoCubs

extension TestInfo {

    private var kifTest: KIFTestCase {
        guard let kif = self.testCase as? KIFTestCase else {
            fatalError("Trying to use a non-kif test case for KIF tests")
        }
        
        return kif
    }
    
    fileprivate var kifTester: KIFUITestActor {
        return self.kifTest.tester(self.file, self.line)
    }
}

struct KIFRobot: BasicRobot {
    
    func tapButton(withAccessibilityLabel label: String,
                   testInfo: TestInfo) {
        testInfo.kifTester.tapView(withAccessibilityLabel: label, traits: UIAccessibilityTraitButton)
    }
    
    func waitForLabel(withText text: String,
                      testInfo: TestInfo) {
        testInfo.kifTester.waitForView(withAccessibilityLabel: text)
    }
    
    func waitForView(withAccessibilityIdentifier identifier: String,
                     testInfo: TestInfo) {
        testInfo.kifTester.waitForView(withAccessibilityIdentifier: identifier)
    }
    
    func waitForTableView(withAccessibilityIdentifier identifier: String,
                          testInfo: TestInfo) {
        testInfo.kifTester.waitForView(withAccessibilityIdentifier: identifier)
    }
    
    func labelText(forLabelWithAccessibilityIdentifier identifier: String,
                   testInfo: TestInfo) -> String? {
    
        guard let label = testInfo.kifTester.waitForView(withAccessibilityIdentifier: identifier) as? UILabel else {
            return nil
        }
        
        return label.text
    }
}

extension KIFRobot: GameListRobot {

    func tapCell(withDateText dateText: String,
                 gameText: String,
                 testInfo: TestInfo) {
        guard
            let tableView = testInfo.kifTester.waitForView(withAccessibilityIdentifier: AccessibilityString.gamesTableview) as? UITableView,
            let dataSource = tableView.dataSource,
            let sections = dataSource.numberOfSections?(in: tableView) else {
                XCTFail("Could not determine how many sections are in table view",
                        file: testInfo.file,
                        line: testInfo.line)
            return
        }
        
        //Make index paths for all sections
        var indexPaths = [IndexPath]()
        for section in 0..<sections {
            let rows = dataSource.tableView(tableView, numberOfRowsInSection: section)
            for row in 0..<rows {
                indexPaths.append(IndexPath(row: row, section: section))
            }
        }
        
        //Figure out which one we need to tap.
        guard let indexPathToTap = indexPaths.first(where: {
            indexPath in
            
            guard
                let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as? CubsGameCell,
                let vsText = cell.vsLabel.text,
                let cellDateText = cell.dateLabel.text else {
                return false
            }
            
            // Are both sets of text the same?
            return vsText == gameText && cellDateText == dateText
        }) else {
            XCTFail("Could not find index path to tap for \(gameText) on \(dateText)",
                    file: testInfo.file,
                    line: testInfo.line)
            return
        }
        

        testInfo.kifTester.tapRow(at: indexPathToTap, in: tableView)
    }
}

extension KIFRobot: GameDetailRobot { }
