public enum Method: String {

	case CONNECT
	case DELETE
	case GET
	case HEAD
	case OPTIONS
	case PATCH
	case POST
	case PUT
	case TRACE

}

public struct Request {

	public let method: Method
	public let path: Path
	public let headers: [(String, String)]
	public let body: String? // FIXME: Data instead?
	public let query: [String: String]

	init(method: Method, path: Path, headers: [(String, String)] = [], query: [String: String] = [:], body: String? = nil) {
		self.method = method
		self.path = path
		self.headers = headers
		self.query = query
		self.body = body
	}

}
