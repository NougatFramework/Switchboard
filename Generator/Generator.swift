#!/usr/bin/xcrun --sdk macosx swift

//
//  Generator.swift
//  Switchboard
//
//  Created by Grant Butler on 5/18/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

let numberFormatter = NSNumberFormatter()
numberFormatter.numberStyle = .SpellOutStyle

if #available(OSX 10.10, *) {
    numberFormatter.formattingContext = .Standalone
}

struct HandlerType {
    
    let paramCount: Int
    
    var typeName: String {
        let paramString = paramCount == 1 ? "Arg" : "Args"
		let numberString = numberFormatter.stringFromNumber(paramCount)!
		
		return "RouteHandlerWith\(numberString)\(paramString)"
    }
    
    var genericTypes: [String] {
        return (0..<paramCount).map { String(UnicodeScalar($0 + 65)) }
    }
    
    var handlerTypes: [String] {
        return ["Request"] + genericTypes
    }
    
    init(paramCount: Int) {
        self.paramCount = paramCount
    }
    
    func generateHandler() -> String {
        let handlerSignature = "(\(handlerTypes.joinWithSeparator(", "))) -> Response"
		let genericsList = genericTypes.map { return $0 + ": PathType" }.joinWithSeparator(", ")
        let genericsClause = genericsList.isEmpty ? "" : "<" + genericsList + ">"
        
        var handlerStruct =
			"struct \(typeName)\(genericsClause): RouteHandlingType {\n\n" +
			"    private let handler: \(handlerSignature)\n" +
            "    init(handler: \(handlerSignature)) {\n" +
            "        self.handler = handler\n" +
            "    }\n\n" +
            "    func perform(request: MatchedRequest) -> Response {\n"
        
        var handlerParams = ["request"]
        
        for (i, generic) in genericTypes.enumerate() {
            let paramName = "param\(i + 1)"
            
            handlerStruct += "        let \(paramName): \(generic) = request.paramAtIndex(\(i))\n"
            
            handlerParams += [paramName]
        }
        
        handlerStruct +=
            "        return handler(\(handlerParams.joinWithSeparator(", ")))\n" +
            "    }\n\n" +
            "}"
        
        return handlerStruct
    }
    
}

func generateRouteHandlers(count: Int = 6) -> (generatedCode: String, types: [HandlerType]) {
	let handlerTypes: [HandlerType] = (0...count).map { HandlerType(paramCount: $0) }
    return (generatedCode: handlerTypes.map { $0.generateHandler() }.joinWithSeparator("\n\n"), types: handlerTypes)
}

let (generatedCode, types) = generateRouteHandlers()
print("\(generatedCode)")
