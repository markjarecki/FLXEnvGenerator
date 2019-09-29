//
//  EnvSpecValidatable.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public protocol EnvSpecValidatable {
    
    static func validate(spec: EnvSpec) throws -> Void
    
}
