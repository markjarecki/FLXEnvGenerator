//
//  Errors.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public enum EnvError: Error, Equatable {
    
    case missingCurrentEnvironment
    case invalidAccessOption
    case couldNotReadData
    case duplicateEnvironmentName
    case settingsEnvironmentNameInvalid
    case currentEnvironmentIllegal
    case environmentNameIllegal
    case noEnvironmentsInEnvSpec

}

public func ==(lhs: EnvError, rhs: EnvError) -> Bool {
    
    switch (lhs, rhs) {
    
        case (.missingCurrentEnvironment, .missingCurrentEnvironment),
            (.invalidAccessOption, .invalidAccessOption),
            (.couldNotReadData, .couldNotReadData),
            (.duplicateEnvironmentName, .duplicateEnvironmentName),
            (.settingsEnvironmentNameInvalid, .settingsEnvironmentNameInvalid),
            (.currentEnvironmentIllegal, .currentEnvironmentIllegal),
            (.environmentNameIllegal, .environmentNameIllegal),
            (.noEnvironmentsInEnvSpec, .noEnvironmentsInEnvSpec):
          return true
        
        default:
          return false
      
    }
    
}
