public enum Method: String {

	case CONNECT
	case DELETE
	case GET
	case HEAD
	case OPTIONS
	case PATCH
	case POST
	case PUT
	case TRACE

}

public struct Request {

	let method: Method
	let path: Path
	let headers: [(String, String)]
	let body: String? // FIXME: Data instead?
	
	init(method: Method, path: Path, headers: [(String, String)] = [], body: String? = nil) {
		self.method = method
		self.path = path
		self.headers = headers
		self.body = body
	}
	
//	init(method: Method, path: String, headers: [(String, String)] = [], body: String? = nil) {
//		self.init(method: method, path: Path(stringLiteral: path), headers: headers, body: body)
//	}
	
}

public struct MatchedRequest {
	
	public let request: Request
	public let route: Route
	
	public func param<T: PathType>(key: String) -> T? {
		let wildcard = ":" + key
		guard let wildcardIndex = route.path.indexOfWildcard(wildcard) else { return nil }
		let value = request.path.components[wildcardIndex]
		return T.fromString(value)
	}
	
}
