

protocol RouteHandlingType {
    
    func perform(request: MatchedRequest) -> Response?
    
}

public struct Route {

	public typealias Middleware = (request: Request, next: (Request) throws -> Response) throws -> Response
	
	public let method: Method
	public let wildcardPath: WildcardPath
	public let middleware: [Middleware]
	
    let handler: RouteHandlingType
	
	init(method: Method, wildcardPath: WildcardPath, middleware: [Middleware] = [], handler: RouteHandlingType) {
		self.method = method
		self.wildcardPath = wildcardPath
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
		return try handle(request, middlewareGenerator: middleware.generate())
	}
	
	private func handle(request: Request, middlewareGenerator: IndexingGenerator<[Middleware]>) throws -> Response {
		var mutableMiddlewareGenerator = middlewareGenerator
		if let middleware = mutableMiddlewareGenerator.next() {
			return try middleware(request: request, next: { (aRequest) -> Response in
				return try self.handle(aRequest, middlewareGenerator: mutableMiddlewareGenerator)
			})
		}
		
        let matchedRequest = MatchedRequest(request: request, route: self)
        guard let response = handler.perform(matchedRequest) else {
            throw RoutingError.NotFound(request.method, request.path)
        }
        
        return response
	}

}


