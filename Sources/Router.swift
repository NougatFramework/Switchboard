public enum RoutingError {

	case notFound(Method, Path)

}

extension RoutingError: Error {}
extension RoutingError: ResponseEncodable {

	public func asResponse() -> Response {
		switch self {
			case let .notFound(method, path):
				return Response.html("<h1><pre>Could not \(method) \(path)</pre></h1>", statusCode: .notFound)
		}
	}

}

public final class Router {

    // TODO: experiment with setting this up as a tree, instead of an array?
    public internal(set) var routes: [Route] = []
    public var globalMiddleware: [Route.Middleware] = []

    public func route(_ request: Request) throws -> Response {
        for route in routes where route.matches(request) {
            return try handle(route, request: request, middlewareGenerator: globalMiddleware.makeIterator())
        }

        throw RoutingError.notFound(request.method, request.path)
    }

    fileprivate func handle(_ route: Route, request: Request, middlewareGenerator: IndexingIterator<[Route.Middleware]>) throws -> Response {
		var mutableMiddlewareGenerator = middlewareGenerator
		if let middleware = mutableMiddlewareGenerator.next() {
			return try middleware(request, { (aRequest) -> Response in
				return try self.handle(route, request: aRequest, middlewareGenerator: mutableMiddlewareGenerator)
			})
		}

        do {
            return try route.handle(request)
        }
        catch let responseEncodableError as ResponseEncodable {
            return responseEncodableError.asResponse()
        }
        catch {
            return Response(error: error)
        }
	}

}
