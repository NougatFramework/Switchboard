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
    
    var genericsClause: String {
        let genericsList = genericTypes.map { return $0 + ": PathType" }.joinWithSeparator(", ")
        return genericsList.isEmpty ? "" : "<" + genericsList + ">"
    }
    
    var handlerTypes: [String] {
        return ["Request"] + genericTypes
    }
    
    var handlerSignature: String {
        return "(\(handlerTypes.joinWithSeparator(", "))) -> Response"
    }
    
    var pathTypes: String {
        return genericTypes.map { "\($0).self" }.joinWithSeparator(", ")
    }
    
    init(paramCount: Int) {
        self.paramCount = paramCount
    }
    
}

func generateHandlerStruct(handler: HandlerType) -> String {
    var handlerStruct =
        "struct \(handler.typeName)\(handler.genericsClause): RouteHandlingType {\n\n" +
        "    private let handler: \(handler.handlerSignature)\n" +
        "    init(handler: \(handler.handlerSignature)) {\n" +
        "        self.handler = handler\n" +
        "    }\n\n" +
        "    func perform(request: MatchedRequest) -> Response {\n"
    
    var handlerParams = ["request"]
    
    handler.genericTypes.enumerate().forEach { (i, generic) in
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

func generateRouterExtension(handler: HandlerType) -> String {
    var routerExtension =
        "extension Router {\n\n" +
        "    private func addRoute\(handler.genericsClause)(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: \(handler.handlerSignature) {\n" +
        "        let routeHandler = RouteHandlerWithTwoArgs(handler: handler)\n" +
        "        routes += [Route(method: method, path: path, pathTypes: [\(handler.pathTypes)], middleware: middleware, handler: routeHandler)]\n" +
        "    }\n\n"

    ["GET", "POST", "PUT", "DELETE", "PATCH"].forEach { (method) in
        routerExtension +=
        "    public func \(method.lowercaseString)\(handler.genericsClause)(path: Path, middleware: [Route.Middleware] = [], handler: \(handler.handlerSignature) {\n" +
        "        addRoute(.\(method), path: path, middleware: middleware, handler: handler)\n" +
        "    }\n\n"
    }

    routerExtension += "}"

    return routerExtension
}

func generateFile(path: String, handlerTypes: [HandlerType], generateFunc: (handler: HandlerType) -> String) throws {
    let generatedFileContents = handlerTypes.map(generateFunc).joinWithSeparator("\n\n")
    try generatedFileContents.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
}

let fileManager = NSFileManager.defaultManager()
let sourcesDirectory = fileManager.currentDirectoryPath + "/../Sources"

let handlerTypes: [HandlerType] = (0...6).map { HandlerType(paramCount: $0) }

do {
    try generateFile(sourcesDirectory + "/RouteHandlers.swift", handlerTypes: handlerTypes, generateFunc: generateHandlerStruct)
    try generateFile(sourcesDirectory + "/RouterExtensions.swift", handlerTypes: handlerTypes, generateFunc: generateRouterExtension)
}
catch {
    print("\(error)")
}