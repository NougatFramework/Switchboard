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
	
    internal func paramAtIndex<T: PathType>(index: Int) -> T {
        let wildcardKey = route.path.wildcards[index]
        return param(wildcardKey: wildcardKey)
    }
    
    private func param<T: PathType>(wildcardKey wildcardKey: String) -> T {
        guard let wildcardIndex = route.path.indexOfWildcard(wildcardKey) else {
            preconditionFailure("No wildcard with key \(wildcardKey)")
        }
        
		let value = request.path.components[wildcardIndex]
		return T.fromString(value)!
    }
    
}
