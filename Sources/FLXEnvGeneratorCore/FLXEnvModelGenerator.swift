//
//  FLXEnvModelGenerator.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation
import Basic
import SPMUtility

public struct FLXEnvModelGenerator<ArgumentDefaults: ArgumentDefaultsReadable>:
        EnvModelGeneratable {

    // MARK: - Initialiser
    
    public static func generate(arguments: ArgumentParser.Result) throws -> EnvModel {
        
        // Validation
        guard let currentEnvironment: String = try? arguments.get(EnvArguments.currentEnvironment.long) else { throw EnvError.missingCurrentEnvironment }
        let access: String = (try? arguments.get(EnvArguments.access.long)) ?? ArgumentDefaults.access
        let specPath: String = (try? arguments.get(EnvArguments.specPath.long)) ?? ArgumentDefaults.specPath
        let specName: String = (try? arguments.get(EnvArguments.specName.long)) ?? ArgumentDefaults.specName
        let settingsPath: String = (try? arguments.get(EnvArguments.settingsPath.long)) ?? ArgumentDefaults.settingsPath
        let settingsName: String = (try? arguments.get(EnvArguments.settingsName.long)) ?? ArgumentDefaults.settingsName
        let environmentPath: String = (try? arguments.get(EnvArguments.environmentPath.long)) ?? ArgumentDefaults.environmentPath
        let environmentName: String = (try? arguments.get(EnvArguments.environmentName.long)) ?? ArgumentDefaults.environmentName
        let optionsName: String = (try? arguments.get(EnvArguments.optionsName.long)) ?? ArgumentDefaults.optionsName
        let constantName: String = (try? arguments.get(EnvArguments.constantName.long)) ?? ArgumentDefaults.constantName

        return EnvModel(
                    currentEnvironment: currentEnvironment,
                    specPath: specPath,
                    specName: specName,
                    settingsPath: settingsPath,
                    settingsName: settingsName,
                    environmentPath: environmentPath,
                    environmentName: environmentName,
                    optionsName: optionsName,
                    constantName: constantName,
                    access: access)

    }
    
}
