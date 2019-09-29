//
//  EnvModel.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public struct EnvModel: Codable, Equatable {
    
    // MARK: - Properties
    
    public let currentEnvironment: String
    public let specPath: String
    public let specName: String
    public let settingsPath: String
    public let settingsName: String
    public let environmentPath: String
    public let environmentName: String
    public let optionsName: String
    public let constantName: String
    public let access: String
    
    // MARK: - Initialiser
    
    public init(currentEnvironment: String, specPath: String, specName: String, settingsPath: String, settingsName: String, environmentPath: String, environmentName: String, optionsName: String, constantName: String, access: String) {
    
        self.currentEnvironment = currentEnvironment
        self.specPath = specPath
        self.specName = specName
        self.settingsPath = settingsPath
        self.settingsName = settingsName
        self.environmentPath = environmentPath
        self.environmentName = environmentName
        self.optionsName = optionsName
        self.constantName = constantName
        self.access = access

    }
    
}


// MARK: - Equatable conformance

public func ==(lhs: EnvModel, rhs: EnvModel) -> Bool {
    
    return lhs.currentEnvironment == rhs.currentEnvironment &&
            lhs.specPath == rhs.specPath &&
            lhs.specName == rhs.specName &&
            lhs.settingsPath == rhs.settingsPath &&
            lhs.settingsName == rhs.settingsName &&
            lhs.environmentPath == rhs.environmentPath &&
            lhs.environmentName == rhs.environmentName &&
            lhs.optionsName == rhs.optionsName &&
            lhs.constantName == rhs.constantName &&
            lhs.access == rhs.access

}
