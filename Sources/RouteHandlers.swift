struct RouteHandlerWithZeroArgs: RouteHandlingType {

    private let handler: (Request) -> Response
    init(handler: (Request) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        return handler(matchedRequest.request)
    }

}

struct RouteHandlerWithOneArg<A: PathType>: RouteHandlingType {

    private let handler: (Request, A) -> Response
    init(handler: (Request, A) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        guard let param1: A = matchedRequest.paramAtIndex(0) else { return nil }
        return handler(matchedRequest.request, param1)
    }

}

struct RouteHandlerWithTwoArgs<A: PathType, B: PathType>: RouteHandlingType {

    private let handler: (Request, A, B) -> Response
    init(handler: (Request, A, B) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        guard let param1: A = matchedRequest.paramAtIndex(0) else { return nil }
        guard let param2: B = matchedRequest.paramAtIndex(1) else { return nil }
        return handler(matchedRequest.request, param1, param2)
    }

}

struct RouteHandlerWithThreeArgs<A: PathType, B: PathType, C: PathType>: RouteHandlingType {

    private let handler: (Request, A, B, C) -> Response
    init(handler: (Request, A, B, C) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        guard let param1: A = matchedRequest.paramAtIndex(0) else { return nil }
        guard let param2: B = matchedRequest.paramAtIndex(1) else { return nil }
        guard let param3: C = matchedRequest.paramAtIndex(2) else { return nil }
        return handler(matchedRequest.request, param1, param2, param3)
    }

}

struct RouteHandlerWithFourArgs<A: PathType, B: PathType, C: PathType, D: PathType>: RouteHandlingType {

    private let handler: (Request, A, B, C, D) -> Response
    init(handler: (Request, A, B, C, D) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        guard let param1: A = matchedRequest.paramAtIndex(0) else { return nil }
        guard let param2: B = matchedRequest.paramAtIndex(1) else { return nil }
        guard let param3: C = matchedRequest.paramAtIndex(2) else { return nil }
        guard let param4: D = matchedRequest.paramAtIndex(3) else { return nil }
        return handler(matchedRequest.request, param1, param2, param3, param4)
    }

}

struct RouteHandlerWithFiveArgs<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType>: RouteHandlingType {

    private let handler: (Request, A, B, C, D, E) -> Response
    init(handler: (Request, A, B, C, D, E) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        guard let param1: A = matchedRequest.paramAtIndex(0) else { return nil }
        guard let param2: B = matchedRequest.paramAtIndex(1) else { return nil }
        guard let param3: C = matchedRequest.paramAtIndex(2) else { return nil }
        guard let param4: D = matchedRequest.paramAtIndex(3) else { return nil }
        guard let param5: E = matchedRequest.paramAtIndex(4) else { return nil }
        return handler(matchedRequest.request, param1, param2, param3, param4, param5)
    }

}

struct RouteHandlerWithSixArgs<A: PathType, B: PathType, C: PathType, D: PathType, E: PathType, F: PathType>: RouteHandlingType {

    private let handler: (Request, A, B, C, D, E, F) -> Response
    init(handler: (Request, A, B, C, D, E, F) -> Response) {
        self.handler = handler
    }

    func perform(matchedRequest: MatchedRequest) -> Response? {
        guard let param1: A = matchedRequest.paramAtIndex(0) else { return nil }
        guard let param2: B = matchedRequest.paramAtIndex(1) else { return nil }
        guard let param3: C = matchedRequest.paramAtIndex(2) else { return nil }
        guard let param4: D = matchedRequest.paramAtIndex(3) else { return nil }
        guard let param5: E = matchedRequest.paramAtIndex(4) else { return nil }
        guard let param6: F = matchedRequest.paramAtIndex(5) else { return nil }
        return handler(matchedRequest.request, param1, param2, param3, param4, param5, param6)
    }

}