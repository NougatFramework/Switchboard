//
//  RouteHandler.swift
//  Switchboard
//
//  Created by Butler, Grant on 2/22/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

protocol RouteHandlingType {
    
    func perform(request: MatchedRequest) -> Response?
    
}

struct RouteHandlerWithNoArgs: RouteHandlingType {
    
    private let handler: (Request) -> Response
    init(handler: (Request) -> Response) {
        self.handler = handler
    }
    
    func perform(request: MatchedRequest) -> Response? {
        return handler(request.request)
    }
    
}

struct RouteHandlerWithOneArg<A: PathType>: RouteHandlingType {
    
    private let handler: (Request, A) -> Response
    init(handler: (Request, A) -> Response) {
        self.handler = handler
    }
    
    func perform(request: MatchedRequest) -> Response? {
        guard let param1: A = request.paramAtIndex(0) else { return nil }
        return handler(request.request, param1)
    }
    
}

struct RouteHandlerWithTwoArgs<A: PathType, B: PathType>: RouteHandlingType {
    
    private let handler: (Request, A, B) -> Response
    init(handler: (Request, A, B) -> Response) {
        self.handler = handler
    }
    
    func perform(request: MatchedRequest) -> Response? {
        guard let param1: A = request.paramAtIndex(0),
              let param2: B = request.paramAtIndex(1) else { return nil }
        return handler(request.request, param1, param2)
    }
    
}
