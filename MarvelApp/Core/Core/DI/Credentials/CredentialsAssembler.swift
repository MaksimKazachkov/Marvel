//
//  CredentialsAssembler.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

struct CredentialsAssembler: Assembler {
    
    let bundleIdentifier: String

    let infoDictionaryKey: String
    
    func resolve() throws -> Credentials {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            throw CredentialsAssemblerError.nilBundleIdentifier(bundleIdentifier)
        }
        guard let object = bundle.object(forInfoDictionaryKey: infoDictionaryKey) else {
            throw CredentialsAssemblerError.nilInfoDictionary(infoDictionaryKey)
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        return try JSONDecoder().decode(Credentials.self, from: data)
    }
    
}
