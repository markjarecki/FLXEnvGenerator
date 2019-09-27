//
//  EnvArguments.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public enum EnvArguments {
    
    case currentEnvironment
    case specPath
    case specName
    case settingsPath
    case settingsName
    case environmentPath
    case environmentName
    case optionsName
    case constantName
    case access
    
    public var long: String {
        
        switch self {
            
            case .currentEnvironment: return "--currentenvironment"
            case .specPath: return "--specpath"
            case .specName: return "--specname"
            case .settingsPath: return "--settingspath"
            case .settingsName: return "--settingsname"
            case .environmentPath: return "--environmentpath"
            case .environmentName: return "--environmentname"
            case .optionsName: return "--optionsname"
            case .constantName: return "--constantname"
            case .access: return "--access"
            
        }
        
    }
    
    public var short: String {
        
        switch self {
            
            case .currentEnvironment: return "-e"
            case .specPath: return "-s"
            case .specName: return "-S"
            case .settingsPath: return "-t"
            case .settingsName: return "-T"
            case .environmentPath: return "-v"
            case .environmentName: return "-V"
            case .optionsName: return "-o"
            case .constantName: return "-c"
            case .access: return "-a"
            
        }
        
    }

}
