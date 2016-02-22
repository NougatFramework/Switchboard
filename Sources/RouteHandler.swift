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

