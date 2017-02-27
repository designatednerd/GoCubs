//
//  XCTestCase+KIFTester.swift
//  GoCubsKIFTests
//
//  Created by Ellen Shapiro on 10/13/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import KIF

/*
 Swift extensions for KIF recommended here: 
 https://github.com/kif-framework/KIF#use-with-swift
 */

extension XCTestCase {
    func tester(_ file: StaticString = #file, _ line: UInt = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: String(describing: file), atLine: Int(line), delegate: self)
    }
    
    func system(_ file: StaticString = #file, _ line: UInt = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: String(describing: file), atLine: Int(line), delegate: self)
    }
}

extension KIFTestActor {
    func tester(_ file: StaticString = #file, _ line: UInt = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: String(describing: file), atLine: Int(line), delegate: self)
    }
    
    func system(_ file: StaticString = #file, _ line: UInt = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: String(describing: file), atLine: Int(line), delegate: self)
    }
}

extension KIFUITestActor {
    
    @discardableResult
    func waitForView(withAccessibilityIdentifier accessibilityIdentifier: String, tappable: Bool = false) -> UIView? {
        var view: UIView? = nil
        self.wait(for: nil,
            view: &view,
            withIdentifier: accessibilityIdentifier,
            tappable: tappable)
        return view;
    }
}

