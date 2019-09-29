//
//  ArgumentDefaultsReadable.swift
//
//  Created by Mark Jarecki on 30/8/19.
//

import Foundation

public protocol ArgumentDefaultsReadable {
    
    static var specPath: String { get }
    static var specName: String { get }
    static var settingsPath: String { get }
    static var settingsName: String { get }
    static var environmentPath: String { get }
    static var environmentName: String { get }
    static var optionsName: String { get }
    static var constantName: String { get }
    static var access: String { get }

}

