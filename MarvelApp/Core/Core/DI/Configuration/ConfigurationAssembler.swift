//
//  ConfigurationAssembler.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct ConfigurationAssembler: Assembler {
    
    public let bundleIdentifier: String

    public let infoDictionaryKey: String
    
    public init(bundleIdentifier: String, infoDictionaryKey: String) {
        self.bundleIdentifier = infoDictionaryKey
        self.infoDictionaryKey = infoDictionaryKey
    }
    
    public func resolve() throws -> Configuration {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            throw AssemblerError.nilBundleIdentifier(bundleIdentifier)
        }
        guard let object = bundle.object(forInfoDictionaryKey: infoDictionaryKey) else {
            throw AssemblerError.nilInfoDictionary(infoDictionaryKey)
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        return try JSONDecoder().decode(Configuration.self, from: data)
    }
    
}
