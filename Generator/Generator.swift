#!/usr/bin/xcrun --sdk macosx swift

//
//  Generator.swift
//  Switchboard
//
//  Created by Grant Butler on 5/18/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

@available(OSX 10.10, *)
func generateRouteHandlers(count: Int = 6) -> (generatedCode: String, types: [String]) {
	var types: [String] = []
	var generatedCode: [String] = []
	
	let numberFormatter = NSNumberFormatter()
	numberFormatter.numberStyle = .SpellOutStyle
    numberFormatter.formattingContext = .Standalone
	
	var generics: [String] = []
	var handlerTypes = ["Request"]
	
	for argCount in 0...count {
		if argCount != 0 {
            let letter = letters[argCount - 1]
			generics += [letter]
			handlerTypes += [letter]
		}
		
		let argString = argCount == 1 ? "Arg" : "Args"
		let numberString = numberFormatter.stringFromNumber(argCount)!
		
		let typeName = "RouteHandlerWith\(numberString)\(argString)"
		types += [typeName]
		
		let handlerSignature = "(\(handlerTypes.joinWithSeparator(", "))) -> Response"
		let genericsList = generics.map { return $0 + ": PathType" }.joinWithSeparator(", ")
        let genericsClause = genericsList.isEmpty ? "" : "<" + genericsList + ">"
        
		var handlerStruct =
			"struct \(typeName)\(genericsClause): RouteHandlingType {\n\n" +
			"    private let handler: \(handlerSignature)\n" +
            "    init(handler: \(handlerSignature)) {\n" +
            "        self.handler = handler\n" +
            "    }\n\n" +
            "    func perform(request: MatchedRequest) -> Response {\n"
        
        var handlerParams = ["request"]
        
        for (i, generic) in generics.enumerate() {
            let paramName = "param\(i + 1)"
            
            handlerStruct += "        let \(paramName): \(generic) = request.paramAtIndex(\(i))\n"
            
            handlerParams += [paramName]
        }
        
        handlerStruct +=
            "        return handler(\(handlerParams.joinWithSeparator(", ")))\n" +
            "    }\n\n" +
            "}"
        
        generatedCode += [handlerStruct]
	}
	
	return (generatedCode: generatedCode.joinWithSeparator("\n\n"), types: types)
}

if #available(OSX 10.10, *) {
    let (generatedCode, types) = generateRouteHandlers()
    print("\(generatedCode)")
}
else {
    print("OS X 10.10 is required to run the generator.")
    exit(EXIT_FAILURE)
}
