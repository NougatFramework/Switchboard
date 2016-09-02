extension Router {

    private func addRoute(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request) -> Response) {
        let routeHandler = RouteHandlerWithZeroArgs(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A) -> Response) {
        let routeHandler = RouteHandlerWithOneArg(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [A.self])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B) -> Response) {
        let routeHandler = RouteHandlerWithTwoArgs(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [A.self, B.self])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C) -> Response) {
        let routeHandler = RouteHandlerWithThreeArgs(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [A.self, B.self, C.self])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType, D: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D) -> Response) {
        let routeHandler = RouteHandlerWithFourArgs(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [A.self, B.self, C.self, D.self])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType, D: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType, D: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType, D: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType, D: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType, D: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E) -> Response) {
        let routeHandler = RouteHandlerWithFiveArgs(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [A.self, B.self, C.self, D.self, E.self])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E, F) -> Response) {
        let routeHandler = RouteHandlerWithSixArgs(handler: handler)
        let wildcardPath = WildcardPath(path: path, pathTypes: [A.self, B.self, C.self, D.self, E.self, F.self])
        routes += [Route(method: method, wildcardPath: wildcardPath, middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E, F) -> Response) {
        addRoute(method: .GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E, F) -> Response) {
        addRoute(method: .POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E, F) -> Response) {
        addRoute(method: .PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E, F) -> Response) {
        addRoute(method: .DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(_ path: Path, middleware: [Route.Middleware] = [], handler: @escaping (Request, A, B, C, D, E, F) -> Response) {
        addRoute(method: .PATCH, path: path, middleware: middleware, handler: handler)
    }

}