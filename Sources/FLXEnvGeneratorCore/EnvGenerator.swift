//
//  EnvGenerator.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation
import Basic
import SPMUtility

// Third-party
import PathKit

public final class EnvGenerator<ArgumentDefaults: ArgumentDefaultsReadable,
    EnvModelGenerator: EnvModelGeneratable,
    EnvSpecDecoder: EnvSpecDecodable,
    EnvSpecValidator: EnvSpecValidatable,
    CurrentEnvValidator: CurrentEnvValidatable,
    SettingsTemplate: SettingsTemplatable,
    EnvTemplate: EnvTemplatable> {
    
    // MARK: - Properties
    
    private let arguments: [String]
    private let parser = ArgumentParser(usage: "<options>",
                                overview: "Tool generates an environment build settings file, and an environment file Swift file containing environment options and the current environment constant")
    
    // MARK: - Initialiser
    
    public init(arguments: [String] = CommandLine.arguments) {
        
        // Don't include the command name
        self.arguments = Array(arguments.dropFirst())
        
        setupParser()
        
    }
    
    // MARK: - Public interface
    
    public func run() throws -> Void {
        
        // Parse the command line arguments for valid options
        let parsedArguments: ArgumentParser.Result = try parser.parse(arguments)
        
        // Generate the EnvModel
        let envModel = try EnvModelGenerator.generate(arguments: parsedArguments)
        
        // fputs("Using EnvModel... \n\(envModel)\n\n", stdout)
        
        // Decode the EnvSpec
        let envSpec = try EnvSpecDecoder.decode(specPath: envModel.specPath, specName: envModel.specName)
        
        // fputs("Using EnvSpec... \n\(envSpec)\n\n", stdout)
        
        // Validate decode EnvSpec
        try EnvSpecValidator.validate(spec: envSpec)
        
        // Validate whether `currentEnvironment` argument is a valid environment
        try CurrentEnvValidator.validate(currentEnvironment: envModel.currentEnvironment, environments: envSpec.environments)
        
        // Apply templates
        let settingsTemplateString = try SettingsTemplate.apply(currentEnvironment: envModel.currentEnvironment, settings: envSpec.settings)
        let environmentTemplateString  = try EnvTemplate.apply(currentEnvironment: envModel.currentEnvironment, optionsName: envModel.optionsName, constantName: envModel.constantName, access: envModel.access, environments: envSpec.environments)
        
        // Do not try to write a settings file if there is no template string
        if let settingsTemplateString = settingsTemplateString {
            
            let settingsPath: Path = Path(envModel.settingsPath) + envModel.settingsName

            // Write settings file
            try settingsTemplateString.write(toFile: settingsPath.description, atomically: true, encoding: String.Encoding.utf8)
        
        }
        
        let environmentPath: Path = Path(envModel.environmentPath) + envModel.environmentName
        
        // Write the environment file
        try environmentTemplateString.write(toFile: environmentPath.description, atomically: true, encoding: String.Encoding.utf8)

    }
    
    // MARK: - Private helper methods
    
    private func setupParser() {
    
        // <options>
        
        // Required
        _ = parser.add(option: EnvArguments.currentEnvironment.long, shortName: EnvArguments.currentEnvironment.short, kind: String.self, usage: "REQUIRED. Name of current selected environment - must be an environment specified in the YAML environement spec file", completion: nil)
        
        // With defaults
        _ = parser.add(option: EnvArguments.specPath.long, shortName: EnvArguments.specPath.short, kind: String.self, usage: "Path to YAML environment spec file - default: \(ArgumentDefaults.specPath)", completion: nil)
        _ = parser.add(option: EnvArguments.specName.long, shortName: EnvArguments.specName.short, kind: String.self, usage: "Name of YAML environment spec file - default: \(ArgumentDefaults.specName)", completion: nil)
        _ = parser.add(option: EnvArguments.settingsPath.long, shortName: EnvArguments.settingsPath.short, kind: String.self, usage: "Path to generated environment build settings file - default: \(ArgumentDefaults.settingsPath)", completion: nil)
        _ = parser.add(option: EnvArguments.settingsName.long, shortName: EnvArguments.settingsName.short, kind: String.self, usage: "Name of generated environment build settings file - default: \(ArgumentDefaults.settingsName)", completion: nil)
        _ = parser.add(option: EnvArguments.environmentPath.long, shortName: EnvArguments.environmentPath.short, kind: String.self, usage: "Path to generated environment file - containing environment options enum and the current environment constant - default: \(ArgumentDefaults.environmentPath)", completion: nil)
        _ = parser.add(option: EnvArguments.environmentName.long, shortName: EnvArguments.environmentName.short, kind: String.self, usage: "Name of generated environment file - containing environment options enum and the current environment constant - default: \(ArgumentDefaults.environmentName)", completion: nil)
        _ = parser.add(option: EnvArguments.optionsName.long, shortName: EnvArguments.optionsName.short, kind: String.self, usage: "Name of the generated enum environment options - default: \(ArgumentDefaults.optionsName)", completion: nil)
        _ = parser.add(option: EnvArguments.constantName.long, shortName: EnvArguments.constantName.short, kind: String.self, usage: "Name of the generated `let` environment constant - default: \(ArgumentDefaults.constantName)", completion: nil)
        _ = parser.add(option: EnvArguments.access.long, shortName: EnvArguments.access.short, kind: Access.self, usage: "Generated environment types access modifier - public, internal, fileprivate - default: \(ArgumentDefaults.access)", completion: nil)
    
    }
    
}
