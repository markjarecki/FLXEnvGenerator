//
//  CurrentEnvValidatable.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public protocol CurrentEnvValidatable {
    
    static func validate(currentEnvironment: String, environments: [String]) throws -> Void
    
}
