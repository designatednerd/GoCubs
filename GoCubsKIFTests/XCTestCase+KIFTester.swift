//
//  XCTestCase+KIFTester.swift
//  test23UITests
//
//  Created by Ellen Shapiro (Vokal) on 10/13/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import KIF

extension XCTestCase {
    func tester(_ file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(_ file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFUITestActor {
    
    func waitForViewWithAccessibilityIdentifier(_ accessibilityIdentifier: String) -> UIView? {
        return self.waitForViewWithAccessibilityIdentifier(accessibilityIdentifier, tappable: false)
    }
    
    func waitForViewWithAccessibilityIdentifier(_ accessibilityIdentifier: String, tappable: Bool) -> UIView? {
        var view: UIView? = nil

        self.wait(for: nil,
            view: &view,
            withIdentifier: accessibilityIdentifier,
            tappable: tappable)
        
        return view;
    }
}

