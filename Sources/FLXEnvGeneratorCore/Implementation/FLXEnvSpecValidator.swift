//
//  FLXEnvSpecValidator.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public struct FLXEnvSpecValidator: EnvSpecValidatable {

    // MARK: - EnvSpecValidatable conformance
    
    public static func validate(spec: EnvSpec) throws -> Void {
                
        let environmentSet: Set<String> = Set(spec.environments)
        
        // No environments set
        guard !environmentSet.isEmpty else {
            
            throw EnvError.noEnvironmentsInEnvSpec
            
        }
        
        // No use of reserved value "shared" in environment names
        guard environmentSet.contains("shared") == false else {
        
            throw EnvError.environmentNameIllegal
        
        }
        
        // No environment name duplication
        guard environmentSet.count == spec.environments.count else {
        
            throw EnvError.duplicateEnvironmentName
        
        }
        
        // If settings have been set
        if let settings = spec.settings {
            
            // Setting keys are valid environment names
            for key in settings.keys {
                
                if key != "shared" {
                    
                    guard environmentSet.contains(key) == true else {
                        
                        throw EnvError.settingsEnvironmentNameInvalid
                        
                    }
                    
                }
                
            }
            
        }
        
    }

}

