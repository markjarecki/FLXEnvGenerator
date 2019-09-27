import Foundation
import XCTest

@testable import FLXEnvGeneratorCore

final class EnvSpecAccessTests: XCTestCase {
    
    // MARK: - Throwing input tests
    
    // MARK: Could not read data

    func test_development_long_arguments_no_envspec() throws {

        let arguments = Arguments.longArgumentsDevelopmentEnvironment
        let generator = Generator(arguments: arguments)

        XCTAssertThrowsError(try generator.run()) { error in

            XCTAssertEqual(error as! EnvError, EnvError.couldNotReadData)

        }

    }
    
    func test_development_short_arguments_no_envspec() throws {
        
        let arguments = Arguments.shortArgumentsDevelopmentEnvironment
        let generator = Generator(arguments: arguments)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.couldNotReadData)
            
        }
        
    }
    
    func test_development_long_arguments_envspec_inaccessible() throws {
        
        let path = "\(EnvSpecPath.environmentsAndSettingsDevelopment)"
        try! FileManager.default.setAttributes([FileAttributeKey.immutable: true], ofItemAtPath: path)
        let generator = Generator(arguments: Arguments.longArgumentsDevelopmentEnvironment)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.couldNotReadData)
            try! FileManager.default.setAttributes([FileAttributeKey.immutable: false], ofItemAtPath: path)
            
        }
        
    }
    
    func test_development_short_arguments_envspec_inaccessible() throws {
        
        let path = "\(EnvSpecPath.environmentsAndSettingsDevelopment)"
        try! FileManager.default.setAttributes([FileAttributeKey.immutable: true], ofItemAtPath: path)
        let generator = Generator(arguments: Arguments.shortArgumentsDevelopmentEnvironment)
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual(error as! EnvError, EnvError.couldNotReadData)
            try! FileManager.default.setAttributes([FileAttributeKey.immutable: false], ofItemAtPath: path)
            
        }
        
    }
    
}
