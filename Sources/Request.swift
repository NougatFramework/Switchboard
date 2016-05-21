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

	public let method: Method
	public let path: Path
	public let headers: [(String, String)]
	public let body: String? // FIXME: Data instead?
	
	init(method: Method, path: Path, headers: [(String, String)] = [], body: String? = nil) {
		self.method = method
		self.path = path
		self.headers = headers
		self.body = body
	}
	
}

public struct MatchedRequest {
	
	public let request: Request
	public let route: Route
	
    internal func paramAtIndex<T: PathType>(index: Int) -> T {
        let wildcardKey = route.wildcardPath.wildcards[index]
        return param(wildcardKey: wildcardKey)
    }
    
    private func param<T: PathType>(wildcardKey wildcardKey: String) -> T {
        guard let wildcardIndex = route.wildcardPath.indexOfWildcard(wildcardKey) else {
            preconditionFailure("No wildcard with key \(wildcardKey)")
        }
        
		let value = request.path.components[wildcardIndex]
		return T.fromString(value)!
    }
    
}
