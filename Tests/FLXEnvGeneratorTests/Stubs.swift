import Foundation
import XCTest
import PathKit
import FLXEnvGeneratorCore

let appName: String = "envgenerator"

struct DirectoryPath {
    
    static private let selfPath: Path = Path(#file)
    
    static let selfDirectory: String = "\(selfPath.parent().description)/"
    static let temporary: String = NSTemporaryDirectory() + "EnvGeneratorCoreTestsTemp/"
    
}

struct File {
    
    static let defaultGeneratedEnvironmentName: String = FLXArgumentDefaults.environmentName
    static let defaultGeneratedSettingsName: String = FLXArgumentDefaults.settingsName
    static let customGeneratedEnvironmentName: String = "AppEnvironment.swift"
    static let customGeneratedSettingsName: String = "appenvgenerator.settings"
    
}

struct EnvSpecPath {
    
    static let prefix = "\(DirectoryPath.selfDirectory)EnvSpec/"
    
    static let empty: String = "\(prefix)Empty/"
    static let mangled: String = "\(prefix)Mangled/"
    static let environmentsOnly: String = "\(prefix)EnvironmentsOnly/"
    static let environmentsOnlyMangled: String = "\(prefix)EnvironmentsOnlyMangled/"
    static let environmentsAndSettingsDevelopment: String = "\(prefix)EnvironmentsSettingsDevelopment/"
    static let environmentsAndSettingsMangled: String = "\(prefix)EnvironmentsSettingsMangled/"
    static let environmentsAndSettingsMismatch: String = "\(prefix)EnvironmentsSettingsMismatch/"
    static let settingsOnly: String = "\(prefix)SettingsOnly/"
    static let settingsOnlyMangled: String = "\(prefix)SettingsOnlyMangled/"
    static let duplicateEnvironmentName: String = "\(prefix)DuplicateEnvironmentName/"
    static let environmentNameIllegal: String = "\(prefix)EnvironmentNameIllegal/"

}

struct EnvSettingsPath {
    
    static let prefix = "\(DirectoryPath.selfDirectory)EnvSettings/"
    
    static let empty: String = "\(prefix)Empty/"
    static let development: String = "\(prefix)Development/"
    
}

struct EnvironmentsPath {
    
    static let prefix = "\(DirectoryPath.selfDirectory)Environments/"
    
    static let customConstantName: String = "\(prefix)CustomConstantName/"
    static let customEnvironmentFileName: String = "\(prefix)CustomEnvironmentFileName/"
    static let customOptionsName: String = "\(prefix)CustomOptionsName/"
    static let `default`: String = "\(prefix)Default/"

}

struct Arguments {
    
    // MARK: - Input testing arguments
    
    static let longArgumentsNoCurrentEnvironment: [String] = { return arguments() }()
    
    static let shortArgumentsNoCurrentEnvironment: [String] = { return arguments(short: true) }()
    
    static let longArgumentsDevelopmentEnvironment: [String] = { return arguments(currentEnvironment: "development") }()
    
    static let shortArgumentsDevelopmentEnvironment: [String] = { return arguments(short: true, currentEnvironment: "development") }()
    
    static let invalidAccessLongArguments: [String] = { return arguments(currentEnvironment: "development", access: "invalidvalue") }()
    
    static let invalidAccessShortArguments: [String] = { return arguments(short: true, currentEnvironment: "development", access: "invalidvalue") }()
    
    static let currentEnvironmentIllegal: [String] = { return arguments(currentEnvironment: "illegalName", specPath: EnvSpecPath.environmentsAndSettingsDevelopment) }()
    
    // MARK: - EnvSpec testing arguments
    
    static let emptyEnvSpec: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.empty) }()
    
    static let mangledEnvSpec: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.mangled) }()
    
    static let environmentsOnlyMangled: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsOnlyMangled) }()
    
    static let settingsOnlyMangled: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.settingsOnlyMangled) }()
    
    static let environmentsAndSettingsMangled: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsAndSettingsMangled) }()
    
    static let environmentsAndSettingsMismatch: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsAndSettingsMismatch) }()
    
    static let duplicateEnvironmentName: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.duplicateEnvironmentName) }()
    
    static let environmentNameIllegal: [String] = { return arguments(currentEnvironment: "shared", specPath: EnvSpecPath.environmentNameIllegal) }()
    
    // MARK: - EnvSettings testing arguments
    
    static let emptyEnvSettings: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsOnly, settingsPath: DirectoryPath.temporary) }()
    
    static let developmentEnvSettings: [String] = { return arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsAndSettingsDevelopment, settingsPath: DirectoryPath.temporary) }()
    
    // MARK: - Argument generator methods
    
    static func invalidInput(flag: String) -> [String] {
        
        return [appName, flag, "development"]
        
    }
    
    static func arguments(
            short: Bool = false,
            currentEnvironment: String? = nil,
            specPath: String = FLXArgumentDefaults.specPath,
            specName: String = FLXArgumentDefaults.specName,
            settingsPath: String = FLXArgumentDefaults.settingsPath,
            settingsName: String = FLXArgumentDefaults.settingsName,
            environmentPath: String = FLXArgumentDefaults.environmentPath,
            environmentName: String = FLXArgumentDefaults.environmentName,
            optionsName: String = FLXArgumentDefaults.optionsName,
            constantName: String = FLXArgumentDefaults.constantName,
            access: String = FLXArgumentDefaults.access
        ) -> [String] {
        
        var args = [
            appName,
            (short ? EnvArguments.specPath.short : EnvArguments.specPath.long), specPath,
            (short ? EnvArguments.specName.short : EnvArguments.specName.long), specName,
            (short ? EnvArguments.settingsPath.short : EnvArguments.settingsPath.long), settingsPath,
            (short ? EnvArguments.settingsName.short : EnvArguments.settingsName.long), settingsName,
            (short ? EnvArguments.environmentPath.short : EnvArguments.environmentPath.long), environmentPath,
            (short ? EnvArguments.environmentName.short : EnvArguments.environmentName.long), environmentName,
            (short ? EnvArguments.optionsName.short : EnvArguments.optionsName.long), optionsName,
            (short ? EnvArguments.constantName.short : EnvArguments.constantName.long), constantName,
            (short ? EnvArguments.access.short : EnvArguments.access.long), access
        ]
        
        if let currentEnv = currentEnvironment {
            
            args.append(short ? EnvArguments.currentEnvironment.short : EnvArguments.currentEnvironment.long)
            args.append(currentEnv)
            
        }
        
        return args
        
    }
    
}
