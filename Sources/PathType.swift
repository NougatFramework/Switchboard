//
//  PathType.swift
//  Switchboard
//
//  Created by Grant Butler on 5/19/16.
//  Copyright © 2016 Nougat. All rights reserved.
//

import Foundation

public protocol PathType {

	static func fromString(_ string: String) -> Self?

}

extension Int: PathType {

	public static func fromString(_ string: String) -> Int? {
		return Int(string)
	}

}

extension String: PathType {

	public static func fromString(_ string: String) -> String? {
		return String(string)
	}

}

extension UUID: PathType {

    public static func fromString(_ string: String) -> UUID? {
        return self.init(uuidString: string)
    }

}
