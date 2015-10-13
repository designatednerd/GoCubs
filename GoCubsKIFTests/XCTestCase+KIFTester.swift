//
//  XCTestCase+KIFTester.swift
//  test23UITests
//
//  Created by Ellen Shapiro (Vokal) on 10/13/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import KIF

extension XCTestCase {
    func tester(file: String = __FILE__, _ line: Int = __LINE__) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file: String = __FILE__, _ line: Int = __LINE__) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file: String = __FILE__, _ line: Int = __LINE__) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file: String = __FILE__, _ line: Int = __LINE__) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFUITestActor {
    
    func waitForViewWithAccessibilityIdentifier(accessibilityIdentifier: String) -> UIView? {
        return self.waitForViewWithAccessibilityIdentifier(accessibilityIdentifier, tappable: false)
    }
    
    func waitForViewWithAccessibilityIdentifier(accessibilityIdentifier: String, tappable: Bool) -> UIView? {
        var view: UIView? = nil

        self.waitForAccessibilityElement(nil,
            view: &view,
            withIdentifier: accessibilityIdentifier,
            tappable: tappable)
        
        return view;
    }
}

