

public struct Route {

	public typealias Middleware = (request: MatchedRequest, next: (MatchedRequest) throws -> Response) throws -> Response
	
	public let method: Method
	public let wildcardPath: WildcardPath
	public let middleware: [Middleware]
	
    let handler: RouteHandlingType
	
	init(method: Method, path: Path, pathTypes: [PathType.Type] = [], middleware: [Middleware] = [], handler: RouteHandlingType) {
		self.method = method
		self.wildcardPath = WildcardPath(path: path, pathTypes: pathTypes)
		self.middleware = middleware
		self.handler = handler
	}
	
	public func matches(request: Request) -> Bool {
		return matches(request.method, path: request.path)
	}
	
	public func matches(method: Method, path: Path) -> Bool {
		guard self.method == method else { return false }
		guard wildcardPath.matches(path) else { return false }
		return true
	}
	
	public func handle(request: Request) throws -> Response {
		let matchedRequest = MatchedRequest(request: request, route: self)
		return try handle(matchedRequest, middlewareGenerator: middleware.generate())
	}
	
	private func handle(request: MatchedRequest, middlewareGenerator: IndexingGenerator<[Middleware]>) throws -> Response {
		var mutableMiddlewareGenerator = middlewareGenerator
		if let middleware = mutableMiddlewareGenerator.next() {
			return try middleware(request: request, next: { (aRequest) -> Response in
				return try self.handle(aRequest, middlewareGenerator: mutableMiddlewareGenerator)
			})
		}
		
        guard let response = handler.perform(request) else {
            throw RoutingError.NotFound(request.request.method, request.request.path)
        }
        
        return response
	}

}


