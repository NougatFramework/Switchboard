public enum RoutingError {
	
	case NotFound(Method, Path)
	
}

extension RoutingError: ErrorType {}
extension RoutingError: ResponseEncodable {
	
	public func asResponse() -> Response {
		switch self {
			case let .NotFound(method, path):
				let html = "<h1><pre>Could not \(method) \(path)</pre></h1>"
				return Response(statusCode: .NotFound, headers: [
					"Content-Type": "text/html",
					"Content-Length": String(html.characters.count)
				], body: html)
		}
	}
	
}

public final class Router {

	// TODO: experiment with setting this up as a tree, instead of an array?
	public private(set) var routes: [Route] = []
	public var globalMiddleware: [Route.Middleware] = []

	public func route(request: Request) throws -> Response {
		for route in routes {
			if route.matches(request) {
				 return route.handle(request)
			}
		}
		
		throw RoutingError.NotFound(request.method, request.path)
	}

}

extension Router {

    private func addRoute(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (MatchedRequest) -> Response) {
		let routeHandler = RouteHandlerWithNoArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [], middleware: middleware, handler: routeHandler)]
	}

	public func get(path: Path, middleware: [Route.Middleware] = [], handler: (MatchedRequest) -> Response) {
		addRoute(.GET, path: path, middleware: middleware, handler: handler)
	}
    
}

extension Router {

    private func addRoute<A: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (MatchedRequest, A) -> Response) {
		let routeHandler = RouteHandlerWithOneArg(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self], middleware: middleware, handler: routeHandler)]
	}

	public func get<A: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (MatchedRequest, A) -> Response) {
		addRoute(.GET, path: path, middleware: middleware, handler: handler)
	}
    
}
