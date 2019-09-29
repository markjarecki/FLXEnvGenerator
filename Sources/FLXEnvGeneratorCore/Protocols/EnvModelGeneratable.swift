//
//  InitialisableProtocols.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation
import Basic
import SPMUtility

public protocol EnvModelGeneratable {
    
    static func generate(arguments: ArgumentParser.Result) throws -> EnvModel
    
}
