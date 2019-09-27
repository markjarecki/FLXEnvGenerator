//
//  Access.swift
//
//  Created by Mark Jarecki on 29/8/19.
//

import Foundation
import Basic
import SPMUtility

public enum Access: String {
    
    case `public` = "public"
    case `internal` = "internal"
    case `fileprivate` = "fileprivate"
    
}

// MARK: - ArgumentKind conformance

extension Access: ArgumentKind {
    
    public init(argument: String) throws {
        
        // Cannot guard a nested a enum's failable initialiser on `self`, so test prior to initialisation
        guard Access.init(rawValue: argument) != nil else {
        
            throw EnvError.invalidAccessOption
        
        }
        
        self.init(rawValue: argument)!
        
    }
    
    static public var completion: ShellCompletion {
        
        return ShellCompletion.values([
                (value: "public", description: "public"),
                (value: "internal", description: "internal"),
                (value: "fileprivate", description: "fileprivate")
            ])
        
    }
    
}

