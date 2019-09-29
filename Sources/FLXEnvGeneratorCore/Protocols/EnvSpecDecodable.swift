//
//  EnvSpecDecodable.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public protocol EnvSpecDecodable {
    
    static func decode(specPath: String, specName: String) throws -> EnvSpec
    
}
