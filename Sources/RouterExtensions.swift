extension Router {

    private func addRoute(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request) -> Response) {
        let routeHandler = RouteHandlerWithZeroArgs(handler: handler)
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

    private func addRoute<A: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A) -> Response) {
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

    private func addRoute<A: PathType, B: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B) -> Response) {
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

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C) -> Response) {
        let routeHandler = RouteHandlerWithThreeArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self, B.self, C.self], middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType, D: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D) -> Response) {
        let routeHandler = RouteHandlerWithFourArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self, B.self, C.self, D.self], middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType, D: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType, D: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType, D: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType, D: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType, D: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E) -> Response) {
        let routeHandler = RouteHandlerWithFiveArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self, B.self, C.self, D.self, E.self], middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }

}

extension Router {

    private func addRoute<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(method: Method, path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E, F) -> Response) {
        let routeHandler = RouteHandlerWithSixArgs(handler: handler)
        routes += [Route(method: method, path: path, pathTypes: [A.self, B.self, C.self, D.self, E.self, F.self], middleware: middleware, handler: routeHandler)]
    }

    public func get<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E, F) -> Response) {
        addRoute(.GET, path: path, middleware: middleware, handler: handler)
    }

    public func post<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E, F) -> Response) {
        addRoute(.POST, path: path, middleware: middleware, handler: handler)
    }

    public func put<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E, F) -> Response) {
        addRoute(.PUT, path: path, middleware: middleware, handler: handler)
    }

    public func delete<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E, F) -> Response) {
        addRoute(.DELETE, path: path, middleware: middleware, handler: handler)
    }

    public func patch<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>(path: Path, middleware: [Route.Middleware] = [], handler: (Request, A, B, C, D, E, F) -> Response) {
        addRoute(.PATCH, path: path, middleware: middleware, handler: handler)
    }

}