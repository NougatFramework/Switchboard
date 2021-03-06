# Switchboard

[![Build Status](https://travis-ci.org/NougatFramework/Switchboard.svg?branch=master)](https://travis-ci.org/NougatFramework/Switchboard) [![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-compatible-green.svg)](https://github.com/NougatFramework/Switchboard/blob/master/Package.swift) [![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/NougatFramework/Switchboard/blob/master/LICENSE.md)

**Switchboard is in an alpha state. Expect bugs, missing features and documentation, and breaking API changes.**

Switchboard is a type-safe request router in Swift.

## Features

- [x] Request Routing
- [x] In-path Parameters/Wildcards
- [x] Middleware
- [ ] Query String Parsing
- [ ] Documentation

## Example

```swift
import Switchboard

let router = Router()
router.get("/") { (request) -> Response in
	return Response.html(body: "<h1>Welcome!</h1>")
}

router.get("/posts/:post_id") { (request, postID: Int) -> Response in
	return Response.html(body: "<h1>Post \(postID)</h1>")
}

let response = try! router.route(Request(method: .GET, path: "/posts/123"))
```
