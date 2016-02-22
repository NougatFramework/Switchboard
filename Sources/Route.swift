

public struct Route {

	public typealias Middleware = (request: MatchedRequest, next: (MatchedRequest) -> Response) -> Response
	
	public let method: Method
	public let path: WildcardPath
	public let middleware: [Middleware]
	
    let handler: RouteHandlingType
	
	init(method: Method, path: Path, pathTypes: [PathType.Type] = [], middleware: [Middleware] = [], handler: RouteHandlingType) {
		self.method = method
		self.path = WildcardPath(path: path, pathTypes: pathTypes)
		self.middleware = middleware
		self.handler = handler
	}
	
	public func matches(request: Request) -> Bool {
		return matches(request.method, path: request.path)
	}
	
	public func matches(method: Method, path: Path) -> Bool {
		guard self.method == method else { return false }
		guard self.path.matches(path) else { return false }
		return true
	}
	
	public func handle(request: Request) -> Response {
		let matchedRequest = MatchedRequest(request: request, route: self)
		return handle(matchedRequest, middlewareGenerator:  middleware.generate())
	}
	
	private func handle(request: MatchedRequest, middlewareGenerator: IndexingGenerator<[Middleware]>) -> Response {
		var mutableMiddlewareGenerator = middlewareGenerator
		if let middleware = mutableMiddlewareGenerator.next() {
			return middleware(request: request, next: { (aRequest) -> Response in
				return self.handle(aRequest, middlewareGenerator: mutableMiddlewareGenerator)
			})
		}
		
        return handler.perform(request)
	}

}


