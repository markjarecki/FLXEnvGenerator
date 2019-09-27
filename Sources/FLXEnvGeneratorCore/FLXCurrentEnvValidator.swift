//
//  FLXCurrentEnvValidator.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public struct FLXCurrentEnvValidator: CurrentEnvValidatable {

    // MARK: - CurrentEnvValidatable conformance
    
    public static func validate(currentEnvironment: String, environments: [String]) throws -> Void {
        
        // Make sure that the current environment is a valid one
        guard environments.contains(currentEnvironment) == true else {

            throw EnvError.currentEnvironmentIllegal

        }
    
    }

}

