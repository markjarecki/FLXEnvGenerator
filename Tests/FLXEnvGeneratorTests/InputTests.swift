import Foundation
import XCTest
import Basic
import SPMUtility

@testable import FLXEnvGeneratorCore

final class InputTests: XCTestCase {
    
    // MARK: - Throwing input tests
    
    // MARK: Unknown option
    
    func test_invalid_input_flag() throws {
        
        let flag = "-x"
        let arguments = Arguments.invalidInput(flag: flag)
        let generator = Generator(arguments: arguments)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            if case .unknownOption(let option) = error as! ArgumentParserError {
                
                XCTAssertEqual(option, flag)
                
            } else {
                
                XCTFail("Unexpectedly not caught")
                
            }
            
        }
        
    }
    
    // MARK: Missing current environment
    
    func test_no_arguments() throws {
        
        let generator = Generator(arguments: [])
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.missingCurrentEnvironment)
            
        }
        
    }
    
    func test_missing_current_environment_long_arguments() throws {

        let arguments = Arguments.longArgumentsNoCurrentEnvironment
        let generator = Generator(arguments: arguments)

        XCTAssertThrowsError(try generator.run()) { error in

            XCTAssertEqual(error as! EnvError, EnvError.missingCurrentEnvironment)

        }

    }

    func test_missing_current_environment_short_arguments() throws {

        let arguments = Arguments.shortArgumentsNoCurrentEnvironment
        let generator = Generator(arguments: arguments)

        XCTAssertThrowsError(try generator.run()) { error in

            XCTAssertEqual(error as! EnvError, EnvError.missingCurrentEnvironment)

        }

    }
    
    // MARK: Invalid access value
    
    func test_invalid_access_value_long_arguments() throws {
        
        let arguments = Arguments.invalidAccessLongArguments
        let generator = Generator(arguments: arguments)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.invalidAccessOption)
            
        }
        
    }
    
    func test_invalid_access_value_short_arguments() throws {
        
        let arguments = Arguments.invalidAccessShortArguments
        let generator = Generator(arguments: arguments)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.invalidAccessOption)
            
        }
        
    }
    
    // MARK: Current environment illegal
    
    func test_current_environment_illegal() throws {
        
        let arguments = Arguments.currentEnvironmentIllegal
        let generator = Generator(arguments: arguments)
        
        // Current environment name provided in argument, not present in valid envspec.yml environments
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.currentEnvironmentIllegal)
            
        }
        
    }
    
}
