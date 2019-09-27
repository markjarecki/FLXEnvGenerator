//
//  main.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation
import FLXEnvGeneratorCore

// Generatoer tool instance
let generator = Generator()

do {
    
    try generator.run()
    
    // Write to STDOUT
    fputs("Successfully generated environment settings & environment options files! \n\n", stdout)
    
    exit(EXIT_SUCCESS)
    
} catch {
    
    // Write to STDERR
    fputs("An error occurred: \(error) \n\n", stderr)
    
    exit(EXIT_FAILURE)
    
}
