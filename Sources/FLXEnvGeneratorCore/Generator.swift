//
//  Generator.swift
//
//  Created by Mark Jarecki on 26/9/19.
//

import Foundation

public typealias Generator = EnvGenerator<FLXArgumentDefaults,
    FLXEnvModelGenerator<FLXArgumentDefaults>,
    FLXEnvSpecDecoder,
    FLXEnvSpecValidator,
    FLXCurrentEnvValidator,
    FLXSettingsTemplate<FLXAutoText>,
    FLXEnvTemplate<FLXAutoText>>
