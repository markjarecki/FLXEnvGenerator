//
//  EnvSpec.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

/* YAML example
// REQUIRED
environments:
    - development
    - testflight
    - appstore
// OPTIONAL
settings:
    shared:
        - OTHER_LDFLAGS: $(inherited) -ObjC
    development:
        - STORYBOARD_NAME: LaunchScreen-development
        - CODE_SIGN_ENTITLEMENTS: development.entitlements
    testflight:
        - STORYBOARD_NAME: LaunchScreen-testflight
        - CODE_SIGN_ENTITLEMENTS: testflight.entitlements
    appstore:
        - STORYBOARD_NAME: LaunchScreen-appstore
        - CODE_SIGN_ENTITLEMENTS: appstore.entitlements

*/

public typealias EnvArray = [String]
public typealias Setting = [String: String]
public typealias SettingsDict = [String: [Setting]]

public struct EnvSpec: Codable, Equatable {
    
    // MARK: - Properties
    
    public let environments: EnvArray
    public let settings: SettingsDict?
    
    // MARK: - Initialiser
    
    public init(environments: EnvArray, settings: SettingsDict?) {
    
        self.environments = environments
        self.settings = settings
    
    }
    
}


// MARK: - Equatable conformance

public func ==(lhs: EnvSpec, rhs: EnvSpec) -> Bool {
    
    return lhs.environments == rhs.environments &&
            lhs.settings == rhs.settings
    
}
