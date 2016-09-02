//
//  PathTests.swift
//  Switchboard
//
//  Created by Grant Butler on 1/18/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import XCTest
@testable import Switchboard

class PathTests: XCTestCase {

    var allTests: [(String, () -> Void)] {
		return [
			("testPathsAreEqual", testPathsAreEqual),
			("testPathsAreNotEqual", testPathsAreNotEqual)
		]
	}
	
	func testPathsAreEqual() {
		let path1 = Path(stringLiteral: "/path/to/switchboard")
		let path2 = Path(stringLiteral: "/path/to/switchboard")
		XCTAssertEqual(path1, path2)
	}
	
	func testPathsAreNotEqual() {
		let path1 = Path(stringLiteral: "/path/to/switchboard")
		let path2 = Path(stringLiteral: "/path/to/localhost")
		XCTAssertNotEqual(path1, path2)
	}

}
