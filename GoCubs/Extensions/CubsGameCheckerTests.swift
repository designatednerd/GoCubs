//
//  CubsGameCheckerTests.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation
import XCTest
@testable import GoCubs

class CubsGameCheckerTests: XCTestCase {
  
  func testLoadingFullCalendarFromInternets() {
    XCTAssertTrue(CubsGameChecker.ShouldUseLiveData)
    
    let expectation = self.expectationWithDescription("Schedule loaded from internets!")
    
    CubsGameChecker.loadCubsCalendar({
      error in
      //If we're here, something went wrong.
      XCTFail("Error loading from internets: \(error.localizedDescription)")
      
      //Tell the waiter that we're done.
      expectation.fulfill()
      }) {
    
        events in

        //Since this is live data and changes all the time, we can only 
        //reliably check that there's at least one event.
        XCTAssertGreaterThan(events.count, 0)
        
        //Tell the waiter that we're done.
        expectation.fulfill()
    }
    
    self.waitForExpectationsWithTimeout(10, handler: nil)
  }

  func testLoadingFullCalendarFromDisk() {
    //Since this is essentially async, use an expectation
    let expectation = self.expectationWithDescription("Schedule loaded from disk")
    
    //Load things up from disk
    CubsGameChecker.loadCubsCalendarFromDisk({
      error in
      //If we're here, something went wrong.
      XCTFail("Error loading from disk: \(error.localizedDescription)")
      
      //Tell the waiter that we're done.
      expectation.fulfill()
      }) {
        events in
        guard let
          firstEvent = events.first,
          lastEvent = events.last else {
            XCTFail("Couldn't get first or last event!")
            return
        }
        
        //Do we have the expected # of events?
        XCTAssertEqual(events.count, 323)
        
        //Is the first event what we expect?
        XCTAssertEqual(firstEvent.month, 3)
        XCTAssertEqual(firstEvent.day, 5)
        XCTAssertEqual(firstEvent.year, 2015)
        XCTAssertEqual(firstEvent.location, "Sloan Park, Mesa")
        XCTAssertFalse(firstEvent.isAtWrigley)
        XCTAssertEqual(firstEvent.summary, "FINAL Spring: Oakland Athletics 2 - Chicago Cubs 2")
        XCTAssertEqual(firstEvent.displayDescription, "FINAL Spring: Oakland Athletics 2 - Chicago Cubs 2\nSloan Park, Mesa\n")
        
        //Is the last event what we expect?
        XCTAssertEqual(lastEvent.month, 10)
        XCTAssertEqual(lastEvent.day, 2)
        XCTAssertEqual(lastEvent.year, 2016)
        XCTAssertEqual(lastEvent.location, "Great American Ball Park, Cincinnati")
        XCTAssertFalse(lastEvent.isAtWrigley)
        XCTAssertEqual(lastEvent.summary, "Chicago Cubs vs. Cincinnati Reds")
        XCTAssertEqual(lastEvent.displayDescription, "Chicago Cubs vs. Cincinnati Reds\nFirst pitch: 3:10:00 PM EDT\nGreat American Ball Park, Cincinnati")
        
        //Tell the waiter that we're done.
        expectation.fulfill()
    }
    
    //Start waiting for the expectation.
    self.waitForExpectationsWithTimeout(3, handler: nil)
  }

}
