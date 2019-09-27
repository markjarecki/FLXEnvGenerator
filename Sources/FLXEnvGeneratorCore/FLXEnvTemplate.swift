//
//  FLXEnvTemplate.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public struct FLXEnvTemplate<AutoText: AutoTextable>: EnvTemplatable {

    // MARK: - EnvTemplatable conformance

    public static func apply(currentEnvironment: String, optionsName: String, constantName: String, access: String, environments: [String]) throws -> String {
        
        var templateString: String = ""
        
        // Append the auto text
        templateString.append(AutoText.text)
        
        // Generate the environments string
        let environmentsStr = environmentsString(optionsName: optionsName, constantName: constantName, access: access, environments: environments)
        
        // Generate the constant string
        let constantStr = constantString(currentEnvironment: currentEnvironment, optionsName: optionsName, constantName: constantName, access: access)
        
        return "\(AutoText.text)\(environmentsStr)\(constantStr)"
    
    }

    // MARK: - Private methods
    
    private static func environmentsString(optionsName: String, constantName: String, access: String, environments: [String]) -> String {
        
        let declarationOpen: String = "\(access) enum \(optionsName) {\n"
        
        var declarationBody: String = ""
        
        for environment in environments {
        
            declarationBody.append("\t case \(environment)\n")
        
        }
        
        let declarationClose: String = "}\n"

        return "\(declarationOpen)\(declarationBody)\(declarationClose)\n"
    
    }
    
    private static func constantString(currentEnvironment: String, optionsName: String, constantName: String, access: String) -> String {
    
        return "\(access) let \(constantName): \(optionsName) = .\(currentEnvironment) \n"
    
    }

}

