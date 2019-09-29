//
//  FLXEnvSpecDecoder.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

// Third-party dependency
import PathKit
import Yams

public struct FLXEnvSpecDecoder: EnvSpecDecodable {
    
    // MARK: - EnvSpecDecodable conformance
    
    public static func decode(specPath: String, specName: String) throws -> EnvSpec {
                
        let data = try readData(specPath: specPath, specName: specName)
        let encodedString = String(data: data, encoding: .utf8) ?? ""
        let envSpec = try FLXEnvSpecDecoder.decodeEnvSpec(yamlString: encodedString)
    
        return envSpec

    }
    
    // MARK: - Private methods
    
    private static func readData(specPath: String, specName: String) throws -> Data {

        let filePath: String = specPath == "" ? Path.current.description : specPath
        let fileName: String = specName
        
        let path = Path(filePath) + fileName
        
        guard let data: Data = try? path.read() else {
        
            throw EnvError.couldNotReadData
            
        }
        
        return data
        
    }

    private static func decodeEnvSpec(yamlString: String) throws -> EnvSpec {
    
        // Decode the YAML string into EnvSpec struct
        let decoder = YAMLDecoder()
        let envSpec = try decoder.decode(EnvSpec.self, from: yamlString)

        return envSpec
       
    }

}

