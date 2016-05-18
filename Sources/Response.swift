

public protocol ResponseEncodable {
	
	func asResponse() -> Response
	
}

public struct Response {

	let statusCode: StatusCode
	
	// TODO: This was [(String, String)], but it looks like built-in tuple comparison isn't in the snapshots yet.
	//       Change back to an array of tuples when the snapshots get tuple comparison.
	var headers: [String: String]
	
	// FIXME: Data instead?
	let body: String

}

extension Response {
	
	static func plainText(content: String, statusCode: StatusCode = .OK, headers: [String: String] = [:]) -> Response {
		return make(content, contentType: "text/plain", statusCode: statusCode, headers: headers)
	}
	
	static func html(content: String, statusCode: StatusCode = .OK, headers: [String: String] = [:]) -> Response {
		return make(content, contentType: "text/html", statusCode: statusCode, headers: headers)
	}
	
	private static func make(content: String, contentType: String, statusCode: StatusCode = .OK, headers: [String: String] = [:]) -> Response {
		var responseHeaders = headers
		responseHeaders["Content-Type"] = contentType
		responseHeaders["Content-Length"] = "\(content.utf8.count)"
		
		return self.init(statusCode: statusCode, headers: responseHeaders, body: content)
	}
	
}

extension Response: Equatable {}

public func ==(lhs: Response, rhs: Response) -> Bool {
	guard lhs.statusCode == rhs.statusCode else { return false }
	guard lhs.headers == rhs.headers else { return false }
	guard lhs.body == rhs.body else { return false }
	return true
}

// NOTE: I'd love for this to be possible. Then, all Swift errors could easily translate to 500 HTTP errors.
//       However, Swift doesn't allow inheritence clauses in protocol extensions, so this isn't possible right now.
//extension ErrorType: ResponseEncodable {
//	
//	public func asResponse() -> Response {
//		return Response
//	}
//	
//}
