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
	
    func paramAtIndex<T: PathType>(index: Int) -> T? {
        let wildcardKey = route.wildcardPath.wildcards[index]
        return param(wildcardKey: wildcardKey)
    }
    
    private func param<T: PathType>(wildcardKey wildcardKey: String) -> T? {
        guard let wildcardIndex = route.wildcardPath.indexOfWildcard(wildcardKey) else {
            return nil
        }
        
		let value = request.path.components[wildcardIndex]
		return T.fromString(value)
    }
    
}
