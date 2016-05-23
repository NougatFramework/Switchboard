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
