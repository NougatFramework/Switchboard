//
//  RouteHandler.swift
//  Switchboard
//
//  Created by Butler, Grant on 2/22/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

protocol RouteHandlingType {
    
    func perform(request: MatchedRequest) -> Response
    
}

struct RouteHandlerWithNoArgs: RouteHandlingType {
    
    private let handler: (MatchedRequest) -> Response
    init(handler: (MatchedRequest) -> Response) {
        self.handler = handler
    }
    
    func perform(request: MatchedRequest) -> Response {
        return handler(request)
    }
    
}

struct RouteHandlerWithOneArg<A: PathType>: RouteHandlingType {
    
    private let handler: (MatchedRequest, A) -> Response
    init(handler: (MatchedRequest, A) -> Response) {
        self.handler = handler
    }
    
    func perform(request: MatchedRequest) -> Response {
        let param1: A = request.paramAtIndex(0)
        return handler(request, param1)
    }
    
}

struct RouteHandlerWithTwoArgs<A: PathType, B: PathType>: RouteHandlingType {
    
    private let handler: (MatchedRequest, A, B) -> Response
    init(handler: (MatchedRequest, A, B) -> Response) {
        self.handler = handler
    }
    
    func perform(request: MatchedRequest) -> Response {
        let param1: A = request.paramAtIndex(0)
		let param2: B = request.paramAtIndex(1)
        return handler(request, param1, param2)
    }
    
}
