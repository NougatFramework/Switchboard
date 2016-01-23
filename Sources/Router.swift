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

	private func addRoute(method: Method, path: Path, pathTypes: [PathType.Type] = [], middleware: [Route.Middleware] = [], handler: Route.RouteHandler) {
		routes += [Route(method: method, path: path, pathTypes: pathTypes, middleware: middleware, handler: handler)]
	}

	public func get(path: Path, pathTypes: [PathType.Type] = [], middleware: [Route.Middleware] = [], handler: Route.RouteHandler) {
		addRoute(.GET, path: path, pathTypes: pathTypes, middleware: middleware, handler: handler)
	}

	public func route(request: Request) throws -> Response {
		for route in routes {
			if route.matches(request) {
				 return route.handle(request)
			}
		}
		
		throw RoutingError.NotFound(request.method, request.path)
	}

}
