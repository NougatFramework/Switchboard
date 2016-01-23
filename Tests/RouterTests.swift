//
//  RouterTests.swift
//  Switchboard
//
//  Created by Grant Butler on 1/8/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import XCTest
@testable import Switchboard

class RouterTests: XCTestCase {
	
	var allTests: [(String, () -> Void)] {
		return [
			("testThrowsNotFoundError", testThrowsNotFoundError),
			("testRoutesGETRequests", testRoutesGETRequests),
			("testRoutesMatchMethod", testRoutesMatchMethod),
			("testMiddlewareIsCalled", testMiddlewareIsCalled),
			("testWildcardRoutes", testWildcardRoutes)
		]
	}
	
	func testThrowsNotFoundError() {
		let router = Router()
		
		do {
			try router.route(Request(method: .GET, path: "/"))
			XCTFail("Request was routed.")
		}
		catch RoutingError.NotFound(_, _) {
			// Pass
		}
		catch {
			XCTFail("An unknown error was caught.")
		}
	}
	
	func testRoutesGETRequests() {
		let router = Router()
		
		router.get("/") { (request) -> Response in
			return Response(statusCode: .OK, headers: [:], body: "")
		}
		
		do {
			let response = try router.route(Request(method: .GET, path: "/"))
			XCTAssertEqual(response, Response(statusCode: .OK, headers: [:], body: ""))
		}
		catch {
			XCTFail("An unknown error was caught.")
		}
	}
	
	func testRoutesMatchMethod() {
		let router = Router()
		
		router.get("/") { (request) -> Response in
			return Response(statusCode: .OK, headers: [:], body: "")
		}
		
		do {
			try router.route(Request(method: .POST, path: "/"))
			XCTFail("Request was routed.")
		}
		catch RoutingError.NotFound(_, _) {
			// Pass
		}
		catch {
			XCTFail("An unknown error was caught.")
		}
	}
	
	func testMiddlewareIsCalled() {
		let middleware = { (request: MatchedRequest, next: (MatchedRequest) -> Response) -> Response in
			var response = next(request)
			response.headers["X-Powered-By"] = "Switchboard"
			return response
		}
		let router = Router()
		
		router.get("/", middleware: [middleware]) { (request) -> Response in
			return Response(statusCode: .OK, headers: [:], body: "")
		}
		
		do {
			let response = try router.route(Request(method: .GET, path: "/"))
			XCTAssertEqual(response, Response(statusCode: .OK, headers: ["X-Powered-By":"Switchboard"], body: ""))
		}
		catch {
			XCTFail("An unknown error was caught.")
		}
	}
	
	func testWildcardRoutes() {
		let router = Router()
		
		router.get("/posts/:post_id", pathTypes: [Int.self]) { (request) -> Response in
			guard let postID: Int = request.param("post_id") else { return Response(statusCode: .NotFound, headers: [:], body: "") }
			return Response(statusCode: .OK, headers: [:], body: "Post \(postID)")
		}
		
		do {
			let response = try router.route(Request(method: .GET, path: "/posts/123"))
			XCTAssertEqual(response, Response(statusCode: .OK, headers: [:], body: "Post 123"))
		}
		catch {
			XCTFail("An unknown error was caught.")
		}
		
		do {
			try router.route(Request(method: .GET, path: "/posts/some-slug"))
			XCTFail("Request was routed.")
		}
		catch RoutingError.NotFound(_, _) {
			// Pass
		}
		catch {
			XCTFail("An unknown error was caught.")
		}
	}

}
