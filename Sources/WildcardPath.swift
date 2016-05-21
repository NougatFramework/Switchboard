//
//  WildcardPath.swift
//  Switchboard
//
//  Created by Grant Butler on 1/18/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

public struct WildcardPath {
	
	public let path: Path
	public let pathTypes: [PathType.Type]
	public let wildcards: [String]
	
	public init(path: Path, pathTypes: [PathType.Type]) {
        let wildcards = path.components.filter { $0.hasPrefix(":") }
        precondition(wildcards.count == pathTypes.count)
        
		self.path = path
		self.pathTypes = pathTypes
        self.wildcards = wildcards
	}
	
	public func matches(path: Path) -> Bool {
        guard self.path.components.count == path.components.count else { return false }
        
		for (selfPathComponent, otherPathComponent) in zip(self.path.components, path.components) {
			if selfPathComponent.hasPrefix(":") {
				guard let wildcardIndex = wildcards.indexOf(selfPathComponent) else { return false }
				
				let pathType = pathTypes[wildcardIndex]
				guard pathType.fromString(otherPathComponent) != nil else { return false }
			}
            else {
                guard selfPathComponent == otherPathComponent else { return false }
            }
		}
		
		return true
	}
	
	public func indexOfWildcard(wildcard: String) -> Int? {
		guard wildcard.hasPrefix(":") else { return nil }
		return path.components.indexOf(wildcard)
	}
	
}

extension WildcardPath: Equatable { }

public func ==(lhs: WildcardPath, rhs: WildcardPath) -> Bool {
	guard lhs.path.components.count == rhs.path.components.count else { return false }
	
	for (lPathComponent, rPathComponent) in zip(lhs.path.components, rhs.path.components) {
		if lPathComponent.hasPrefix(":") && rPathComponent.hasPrefix(":") { continue }
		guard lPathComponent == rPathComponent else { return false }
	}
	
	guard lhs.pathTypes.count == rhs.pathTypes.count else { return false }
	
	for (lPathType, rPathType) in zip(lhs.pathTypes, rhs.pathTypes) {
		guard lPathType.self == rPathType.self else { return false }
	}
	
	return true
}
