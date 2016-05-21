public enum RoutingError {
	
	case NotFound(Method, Path)
	
}

extension RoutingError: ErrorType {}
extension RoutingError: ResponseEncodable {
	
	public func asResponse() -> Response {
		switch self {
			case let .NotFound(method, path):
				return Response.html("<h1><pre>Could not \(method) \(path)</pre></h1>", statusCode: .NotFound)
		}
	}
	
}

public final class Router {
    
    // TODO: experiment with setting this up as a tree, instead of an array?
    public private(set) var routes: [Route] = []
    public var globalMiddleware: [Route.Middleware] = []
    
    public func route(request: Request) throws -> Response {
        for route in routes where route.matches(request) {
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
        
        throw RoutingError.NotFound(request.method, request.path)
    }
    
}

extension Router {
    
    public func addRoute(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        let routeHandler = RouteHandlerWithNoArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [], middleware: middleware, handler: routeHandler)]
    }
    
    public func get(path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }
    
    public func post(path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }
    
    public func put(path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }
    
    public func delete(path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }
    
    public func patch(path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }
    
}

extension Router {
    
    public func addRoute<A: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
        let routeHandler = RouteHandlerWithOneArg(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self], middleware: middleware, handler: routeHandler)]
    }
    
    public func get<A: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }
    
    public func post<A: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }
    
    public func put<A: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }
    
    public func delete<A: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }
    
    public func patch<A: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }
    
}

extension Router {
    
    public func addRoute<A: PathType, B: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
        let routeHandler = RouteHandlerWithTwoArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self, B.self], middleware: middleware, handler: routeHandler)]
    }
    
    public func get<A: PathType, B: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }
    
    public func post<A: PathType, B: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }
    
    public func put<A: PathType, B: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }
    
    public func delete<A: PathType, B: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }
    
    public func patch<A: PathType, B: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }
    
}
