import Foundation
import XCTest
import Basic
import SPMUtility
import Yams

@testable import FLXEnvGeneratorCore

final class EnvSpecTests: XCTestCase {
    
    // MARK: - Throwing input tests
    
    // MARK: Swift decoding error - Type mismatch
    
    func test_empty_env_spec() throws {
        
        let arguments = Arguments.emptyEnvSpec
        let generator = Generator(arguments: arguments)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            // No key immediately decodable, throws `typeMismatch`
            if case .typeMismatch(_, let context) = error as! Swift.DecodingError {
                
                // Should have no decoding success
                XCTAssertEqual(0, context.codingPath.count)
                
            } else {

                XCTFail("Unexpectedly not caught")

            }
            
        }
        
    }
    
    func test_empty_mangled_env_spec() throws {
        
        let arguments = Arguments.mangledEnvSpec
        let generator = Generator(arguments: arguments)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            // No key immediately decodable, throws `typeMismatch`
            if case .typeMismatch(_, let context) = error as! Swift.DecodingError {
                
                // Should have no decoding success
                XCTAssertEqual(0, context.codingPath.count)
                
            } else {
                
                XCTFail("Unexpectedly not caught")
                
            }
            
        }
        
    }
    
    func test_environment_and_settings_mangled() throws {
        
        let arguments = Arguments.environmentsAndSettingsMangled
        let generator = Generator(arguments: arguments)
        
        // Incomplete data after first key, throws `typeMismatch`
        XCTAssertThrowsError(try generator.run()) { error in
            
            if case .typeMismatch(_, let context) = error as! Swift.DecodingError {
                
                // Should fail at coding path 1
                XCTAssertEqual(1, context.codingPath.count)
                XCTAssertEqual("environments", context.codingPath[0].stringValue)
                
            } else {
                
                XCTFail("Unexpectedly not caught")
                
            }
            
        }
        
    }
    
    func test_environment_only_mangled() throws {
        
        let arguments = Arguments.environmentsOnlyMangled
        let generator = Generator(arguments: arguments)
        
        // Incomplete data after first key, throws `typeMismatch`
        XCTAssertThrowsError(try generator.run()) { error in
            
            if case .typeMismatch(_, let context) = error as! Swift.DecodingError {
                
                // Should have no decoding success
                XCTAssertEqual(1, context.codingPath.count)
                XCTAssertEqual("environments", context.codingPath[0].stringValue)
                
            } else {
                
                XCTFail("Unexpectedly not caught")
                
            }
            
        }
        
    }
    
    // MARK: Swift decoding error - Key not found
    
    func test_settings_only_mangled() throws {

        let arguments = Arguments.settingsOnlyMangled
        let generator = Generator(arguments: arguments)

        // Missing environment key, throws `keyNotFound`
        XCTAssertThrowsError(try generator.run()) { error in

            if case .keyNotFound(_, let context) = error as! Swift.DecodingError {
                
                // Should have no decoding success
                XCTAssertEqual(0, context.codingPath.count)
                
            } else {
                
                XCTFail("Unexpectedly not caught")
                
            }

        }

    }
    
    // MARK: Settings environment name invalid
    
    func test_environment_and_settings_mismatch() throws {
        
        let arguments = Arguments.environmentsAndSettingsMismatch
        let generator = Generator(arguments: arguments)
        
        // A settings name provided in the envspec.yml is invalid
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.settingsEnvironmentNameInvalid)
            
        }
        
    }
    
    // MARK: Duplicate environment name
    
    func test_duplicate_environment_name() throws {
        
        let arguments = Arguments.duplicateEnvironmentName
        let generator = Generator(arguments: arguments)
        
        // Duplicate environment names in the envspec.yml
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.duplicateEnvironmentName)
            
        }
        
    }
    
    // MARK: Environment name illegal
    
    func test_environment_name_illegal() throws {
        
        let arguments = Arguments.environmentNameIllegal
        let generator = Generator(arguments: arguments)
        
        // Using `shared` as an environment name is illegal - it is reserved for sharing settings
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.environmentNameIllegal)
            
        }
        
    }
    
}
