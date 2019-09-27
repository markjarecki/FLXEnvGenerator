import Foundation
import XCTest
import Basic
import SPMUtility

@testable import FLXEnvGeneratorCore

final class WriteFileTests: XCTestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        
        super.setUp()
        
        try? FileManager.default.removeItem(atPath: DirectoryPath.temporary)
        try! FileManager.default.createDirectory(atPath: DirectoryPath.temporary, withIntermediateDirectories: true)
        
    }
    
    override func tearDown() {
        
        super.tearDown()
        
        try! FileManager.default.removeItem(atPath: DirectoryPath.temporary)
        
    }
    
    // MARK: - Throwing input tests
    
    func test_cannot_write_settings_to_temporary_directory() throws {
        
        let settingsPath = "\(DirectoryPath.temporary)Settings"
        let environmentPath = "\(DirectoryPath.temporary)Environment"
        
        // Create subdirectories
        try! FileManager.default.createDirectory(atPath: settingsPath, withIntermediateDirectories: true)
        try! FileManager.default.createDirectory(atPath: environmentPath, withIntermediateDirectories: true)
        
        // Make settings path inaccessible
        try! FileManager.default.setAttributes([FileAttributeKey.immutable: true], ofItemAtPath: settingsPath)
        
        let generator = Generator(arguments: Arguments.arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsAndSettingsDevelopment, settingsPath: settingsPath, environmentPath: environmentPath))
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual((error as NSError).localizedFailureReason, "You don’t have permission.")
            try! FileManager.default.setAttributes([FileAttributeKey.immutable: false], ofItemAtPath: settingsPath)
            
        }
        
    }
    
    func test_cannot_write_environment_to_temporary_directory() throws {
        
        let settingsPath = "\(DirectoryPath.temporary)Settings"
        let environmentPath = "\(DirectoryPath.temporary)Environment"
        
        // Create subdirectories
        try! FileManager.default.createDirectory(atPath: settingsPath, withIntermediateDirectories: true)
        try! FileManager.default.createDirectory(atPath: environmentPath, withIntermediateDirectories: true)
        
        // Make environment path inaccessible
        try! FileManager.default.setAttributes([FileAttributeKey.immutable: true], ofItemAtPath: environmentPath)
        
        let generator = Generator(arguments: Arguments.arguments(currentEnvironment: "development", specPath: EnvSpecPath.environmentsAndSettingsDevelopment, settingsPath: settingsPath, environmentPath: environmentPath))
        
        XCTAssertThrowsError(try generator.run()) { error in
            
            XCTAssertEqual((error as NSError).localizedFailureReason, "You don’t have permission.")
            try! FileManager.default.setAttributes([FileAttributeKey.immutable: false], ofItemAtPath: environmentPath)
            
        }
        
    }
    
}
