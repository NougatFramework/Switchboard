//
//  WildcardPathTests.swift
//  Switchboard
//
//  Created by Grant Butler on 1/18/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import XCTest
@testable import Switchboard

class WildcardPathTests: XCTestCase {

    var allTests: [(String, () -> Void)] {
		return [
			("testWildcardPathsAreEqual", testWildcardPathsAreEqual),
			("testWildcardPathsAreNotEqual", testWildcardPathsAreNotEqual),
			("testWildcardPathMatches", testWildcardPathMatches)
		]
	}
	
	func testWildcardPathsAreEqual() {
		let path = Path(stringLiteral: "/path/to/:thing")
		
		let wildcardPath1 = WildcardPath(path: path, pathTypes: [String.self])
		let wildcardPath2 = WildcardPath(path: path, pathTypes: [String.self])
		XCTAssertEqual(wildcardPath1, wildcardPath2)
		
		let otherPath = Path(stringLiteral: "/path/to/:something")
		let wildcardPath3 = WildcardPath(path: otherPath, pathTypes: [String.self])
		XCTAssertEqual(wildcardPath1, wildcardPath3)
	}
	
	func testWildcardPathsAreNotEqual() {
		let path = Path(stringLiteral: "/path/to/:thing")
		
		let wildcardPath1 = WildcardPath(path: path, pathTypes: [String.self])
		let wildcardPath2 = WildcardPath(path: path, pathTypes: [Int.self])
		XCTAssertNotEqual(wildcardPath1, wildcardPath2)
		
		let longPath = Path(stringLiteral: "/some/other/path/to/:thing")
		let wildcardPath3 = WildcardPath(path: longPath, pathTypes: [String.self])
		XCTAssertNotEqual(wildcardPath1, wildcardPath3)
		
		let otherPath = Path(stringLiteral: "/some/other/:thing")
		let wildcardPath4 = WildcardPath(path: otherPath, pathTypes: [String.self])
		XCTAssertNotEqual(wildcardPath1, wildcardPath4)
	}
	
	func testWildcardPathMatches() {
		let pathToMatch = Path(stringLiteral: "/user/1234")
		let wildcardPath = WildcardPath(path: "/user/:user_id", pathTypes: [Int.self])
		XCTAssertTrue(wildcardPath.matches(pathToMatch))
		
		let invalidPath = Path(stringLiteral: "/user/grantjbutler")
		XCTAssertFalse(wildcardPath.matches(invalidPath))
		
		let nonMatchingPath = Path(stringLiteral: "/post/this-is-a-post")
		XCTAssertFalse(wildcardPath.matches(nonMatchingPath))
		
		let longerPath = Path(stringLiteral: "/user/1234/comments")
		XCTAssertFalse(wildcardPath.matches(longerPath))
	}

}
