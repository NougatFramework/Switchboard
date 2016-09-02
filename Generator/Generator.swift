#!/usr/bin/xcrun --sdk macosx swift

//
//  Generator.swift
//  Switchboard
//
//  Created by Grant Butler on 5/18/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .spellOut

if #available(OSX 10.10, *) {
    numberFormatter.formattingContext = .standalone
}

struct HandlerType {
    
    let paramCount: Int
    
    var typeName: String {
        let paramString = paramCount == 1 ? "Arg" : "Args"
		let numberString = numberFormatter.string(from: NSNumber(value: paramCount))!
		
		return "RouteHandlerWith\(numberString)\(paramString)"
    }
    
    var genericTypes: [String] {
        return (0..<paramCount).map { UnicodeScalar($0 + 65)!.escaped(asASCII: false) }
    }
    
    var genericsClause: String {
        let genericsList = genericTypes.map { return $0 + ": PathType" }.joined(separator: ", ")
        return genericsList.isEmpty ? "" : "<" + genericsList + ">"
    }
    
    var handlerTypes: [String] {
        return ["Request"] + genericTypes
    }
    
    var handlerSignature: String {
        return "(\(handlerTypes.joined(separator: ", "))) -> Response"
    }
    
    var pathTypes: String {
        return genericTypes.map { "\($0).self" }.joined(separator: ", ")
    }
    
    init(paramCount: Int) {
        self.paramCount = paramCount
    }
    
}

func generateHandlerStruct(_ handler: HandlerType) -> String {
    var handlerStruct =
        "struct \(handler.typeName)\(handler.genericsClause): RouteHandlingType {\n\n" +
        "    private let handler: \(handler.handlerSignature)\n" +
        "    init(handler: @escaping \(handler.handlerSignature)) {\n" +
        "        self.handler = handler\n" +
        "    }\n\n" +
        "    func perform(_ matchedRequest: MatchedRequest) -> Response? {\n"
    
    var handlerParams = ["matchedRequest.request"]
    
    handler.genericTypes.enumerated().forEach { (i, generic) in
        let paramName = "param\(i + 1)"
        
        handlerStruct += "        guard let \(paramName): \(generic) = matchedRequest.paramAtIndex(\(i)) else { return nil }\n"
        handlerParams += [paramName]
    }
    
    handlerStruct +=
        "        return handler(\(handlerParams.joined(separator: ", ")))\n" +
        "    }\n\n" +
        "}"
    
    return handlerStruct
}

func generateRouterExtension(_ handler: HandlerType) -> String {
    var routerExtension =
        "extension Router {\n\n" +
        "    private func addRoute\(handler.genericsClause)(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping \(handler.handlerSignature)) {\n" +
        "        let routeHandler = \(handler.typeName)(handler: handler)\n" +
        "        let wildcardPath = WildcardPath(path: path, pathTypes: [\(handler.pathTypes)])\n" +
        "        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]\n" +
        "    }\n\n"

    ["GET", "POST", "PUT", "DELETE", "PATCH"].forEach { (method) in
        routerExtension +=
        "    public func \(method.lowercased())\(handler.genericsClause)(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping \(handler.handlerSignature)) {\n" +
        "        addRoute(method: .\(method), path: path, middleware: middleware, handler: handler)\n" +
        "    }\n\n"
    }

    routerExtension += "}"

    return routerExtension
}

func generateFile(path: String, handlerTypes: [HandlerType], generateFunc: (HandlerType) -> String) throws {
    let generatedFileContents = handlerTypes.map(generateFunc).joined(separator: "\n\n")
    try generatedFileContents.write(toFile: path, atomically: false, encoding: .utf8)
}

let fileManager = FileManager.default
let sourcesDirectory = fileManager.currentDirectoryPath + "/../Sources"

let handlerTypes: [HandlerType] = (0...6).map { HandlerType(paramCount: $0) }

do {
    try generateFile(path: sourcesDirectory + "/RouteHandlers.swift", handlerTypes: handlerTypes, generateFunc: generateHandlerStruct)
    try generateFile(path: sourcesDirectory + "/RouterExtensions.swift", handlerTypes: handlerTypes, generateFunc: generateRouterExtension)
}
catch {
    print("\(error)")
}
