import Foundation

public struct Path {

	public let components: [String]
	
}

extension Path: Equatable { }

public func ==(lhs: Path, rhs: Path) -> Bool {
	guard lhs.components.count == rhs.components.count else { return false }
	return lhs.components == rhs.components
}

extension Path: StringLiteralConvertible {
	
	public init(extendedGraphemeClusterLiteral value: String) {
		// TODO: Remove dependency on Foundation?
		components = (value as NSString).pathComponents
	}
	
	public init(stringLiteral value: String) {
		// TODO: Remove dependency on Foundation?
		components = (value as NSString).pathComponents
	}
	
	public init(unicodeScalarLiteral value: String) {
		// TODO: Remove dependency on Foundation?
		components = (value as NSString).pathComponents
	}

}
