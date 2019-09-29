//
//  EnvTemplatable.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public protocol EnvTemplatable {
    
    static func apply(currentEnvironment: String, optionsName: String, constantName: String, access: String, environments: [String]) throws -> String
    
}
