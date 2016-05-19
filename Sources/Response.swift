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
	
	static func plainText(body: String, statusCode: StatusCode = .OK, headers: [String: String] = [:]) -> Response {
		return make(body, contentType: "text/plain", statusCode: statusCode, headers: headers)
	}
	
	static func html(body: String, statusCode: StatusCode = .OK, headers: [String: String] = [:]) -> Response {
		return make(body, contentType: "text/html", statusCode: statusCode, headers: headers)
	}
	
	private static func make(body: String, contentType: String, statusCode: StatusCode = .OK, headers: [String: String] = [:]) -> Response {
		var responseHeaders = headers
		responseHeaders["Content-Type"] = contentType
		responseHeaders["Content-Length"] = "\(body.utf8.count)"
		
		return self.init(statusCode: statusCode, headers: responseHeaders, body: body)
	}
	
}

extension Response {

	init(error: ErrorType) {
		self = self.dynamicType.plainText("\(error)", statusCode: .InternalServerError)
	}

}

extension Response: ResponseEncodable {
	
	public func asResponse() -> Response {
		return self
	}
	
}

extension Response: Equatable {}

public func ==(lhs: Response, rhs: Response) -> Bool {
	guard lhs.statusCode == rhs.statusCode else { return false }
	guard lhs.headers == rhs.headers else { return false }
	guard lhs.body == rhs.body else { return false }
	return true
}
