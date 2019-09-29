//
//  FLXSettingsTemplate.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public struct FLXSettingsTemplate<AutoText: AutoTextable>: SettingsTemplatable {
    
    // MARK: - SettingsTemplatable conformance
    
    public static func apply(currentEnvironment: String, settings: SettingsDict?) throws -> String? {
    
        // Make sure there are settings
        guard let settings: SettingsDict = settings else { return nil }
        
        // Fetch `shared` settings
        let sharedSettingsArray: [[String: String]] = settings["shared"] ?? []
        
        // Fetch current environment settings
        let currentSettingsArray: [[String: String]] = settings[currentEnvironment] ?? []
        
        // Merge the arrays
        let mergedSettings: [[String: String]] = sharedSettingsArray + currentSettingsArray
        
        // Merge in a string
        let mergedString = mergeToString(settings: mergedSettings)
        
        // If there are no settings, return nil
        guard mergedString != "" else { return nil }
        
        return "\(AutoText.text)\(mergedString)"
        
    }
    
    // MARK: - Private methods
    
    private static func mergeToString(settings: [[String: String]]) -> String {
    
        var outputString: String = ""
        
        for setting in settings {
        
            for (key, value) in setting {
            
                outputString.append("\(key) = \(value) \n")
            
            }
            
        }
    
        return outputString
    
    }

}

