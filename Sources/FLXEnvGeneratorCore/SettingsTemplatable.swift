//
//  SettingsTemplatable.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public protocol SettingsTemplatable {
    
    static func apply(currentEnvironment: String, settings: SettingsDict?) throws -> String?
    
}
