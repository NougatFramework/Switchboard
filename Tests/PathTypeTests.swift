//
//  PathTypeTests.swift
//  Switchboard
//
//  Created by Grant Butler on 5/23/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import XCTest
@testable import Switchboard

class PathTypeTests: XCTestCase {
    
    var allTests: [(String, () -> Void)] {
		return [
			("testStringPathType", testStringPathType),
			("testIntPathType", testIntPathType),
			("testUUIDPathType", testUUIDPathType)
		]
	}
    
    func testStringPathType() {
        let result = String.fromString("testStringPathType")
        XCTAssertEqual(result, "testStringPathType")
    }
    
    func testIntPathType() {
        let intResult = Int.fromString("123")
        XCTAssertEqual(intResult, 123)
        
        let doubleResult = Int.fromString("123.456")
        XCTAssertNil(doubleResult)
        
        let stringResult = Int.fromString("my-awesome-post")
        XCTAssertNil(stringResult)
    }
    
    func testUUIDPathType() {
        let UUIDResult = NSUUID.fromString("9527E82F-873D-465B-9269-3107DACC2922")
        XCTAssertEqual(UUIDResult, NSUUID(UUIDString: "9527E82F-873D-465B-9269-3107DACC2922"))
        
        let stringResult = NSUUID.fromString("my-awesome-post")
        XCTAssertNil(stringResult)
    }

}
