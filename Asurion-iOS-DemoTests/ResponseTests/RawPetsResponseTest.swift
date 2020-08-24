//
//  RawPetsResponseTest.swift
//  Asurion-iOS-DemoTests
//
//  Created by Tyler Wells on 8/24/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import XCTest
@testable import Asurion_iOS_Demo

class RawPetsResponseTest: XCTestCase {

    func testRawResponseParse() {
        let path = Bundle(for: RawPetsResponseTest.self).path(forResource: "pets", ofType: "json")
        XCTAssertNotNil(path)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        XCTAssertNotNil(data)
        XCTAssertNoThrow(try JSONDecoder().decode(PetsRawResponse.self, from: data!))
    }

}
