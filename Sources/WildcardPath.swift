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
	public var wildcards: [String] {
		return path.components.filter { return $0.hasPrefix(":") }
	}
	
	public init(path: Path, pathTypes: [PathType.Type]) {
		// TODO: Validate that there are the same number of wildcards as path types.
		
		self.path = path
		self.pathTypes = pathTypes
	}
	
	public func matches(path: Path) -> Bool {
		guard self.path.components.count == path.components.count else { return false }
		for (selfPathComponent, otherPathComponent) in zip(self.path.components, path.components) {
			if selfPathComponent.hasPrefix(":") {
				guard let wildcardIndex = wildcards.indexOf(selfPathComponent) else { return false }
				
				let pathType = pathTypes[wildcardIndex]
				
				if let _ = pathType.fromString(otherPathComponent) {
					continue
				}
				else {
					return false
				}
			}
			
			guard selfPathComponent == otherPathComponent else { return false }
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

public protocol PathType {

	static func fromString(string: String) -> Self?

}

extension Int: PathType {

	public static func fromString(string: String) -> Int? {
		return Int(string)
	}

}

extension String: PathType {

	public static func fromString(string: String) -> String? {
		return String(string)
	}

}
