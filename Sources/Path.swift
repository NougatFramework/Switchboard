import Foundation

public struct Path {

	public let components: [String]

}

extension Path: Equatable { }

public func ==(lhs: Path, rhs: Path) -> Bool {
	guard lhs.components.count == rhs.components.count else { return false }
	return lhs.components == rhs.components
}

extension Path: ExpressibleByStringLiteral {

	public init(extendedGraphemeClusterLiteral value: String) {
		components = (value as NSString).pathComponents
	}

	public init(stringLiteral value: String) {
		components = (value as NSString).pathComponents
	}

	public init(unicodeScalarLiteral value: String) {
		components = (value as NSString).pathComponents
	}

}

extension Path: CustomStringConvertible {

    public var description: String {
        return components.joined(separator: "/")
    }

}
