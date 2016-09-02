//
//  MatchedRequest.swft
//  Switchboard
//
//  Created by Grant Butler on 5/21/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

struct MatchedRequest {

	let request: Request
	let route: Route

    func paramAtIndex<T: PathType>(_ index: Int) -> T? {
        let wildcard = route.wildcardPath.wildcards[index]
        return param(forWildcard: wildcard)
    }

    fileprivate func param<T: PathType>(forWildcard wildcard: String) -> T? {
        guard let wildcardIndex = route.wildcardPath.indexOf(wildcard: wildcard) else {
            return nil
        }

		let value = request.path.components[wildcardIndex]
		return T.fromString(value)
    }

}
