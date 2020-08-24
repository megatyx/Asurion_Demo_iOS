//
//  OpenDayTest.swift
//  Asurion-iOS-DemoTests
//
//  Created by Tyler Wells on 8/25/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import XCTest
@testable import Asurion_iOS_Demo

class OpenDayTest: XCTestCase {

    func testBadDays() {
        XCTAssertNil(OpenDay(shortDay: ""))
        XCTAssertNil(OpenDay(shortDay: "M-T"))
    }
    
    func testGoodDays() {
        let tuesdayOpenDay = OpenDay(shortDay: "T")
        XCTAssertNotNil(tuesdayOpenDay)
        XCTAssertEqual(tuesdayOpenDay, OpenDay.tuesday)
        
        let fridayOpenDay = OpenDay(shortDay: "F", relativeToPrevious: tuesdayOpenDay)
        XCTAssertNotNil(fridayOpenDay)
        XCTAssertEqual(fridayOpenDay, OpenDay.friday)
        
        let trickyThursday = OpenDay(shortDay: "T", relativeToPrevious: tuesdayOpenDay)
        XCTAssertNotNil(trickyThursday)
        XCTAssertEqual(trickyThursday, OpenDay.thursday)
        
        let mixedSunday = OpenDay(shortDay: "S", relativeToPrevious: OpenDay(shortDay: "S"))
        XCTAssertNotNil(mixedSunday)
        XCTAssertEqual(mixedSunday, OpenDay.sunday)
    }
    
    func testLiesBetweenDays() {
        let tuesdayOpenDay = OpenDay(shortDay: "T")!
        let fridayOpenDay = OpenDay(shortDay: "F")!
        let saturdayOpenDay = OpenDay(shortDay: "S")!
        let wednesdayOpenDay = OpenDay(shortDay: "W")!
        
        XCTAssertTrue(OpenDay.weekdayIsBetweenTwo(startDay: tuesdayOpenDay, endDay: fridayOpenDay, comparisonDay: wednesdayOpenDay))
        XCTAssertFalse(OpenDay.weekdayIsBetweenTwo(startDay: tuesdayOpenDay, endDay: fridayOpenDay, comparisonDay: saturdayOpenDay))
    }

}
