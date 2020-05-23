//
//  CredentialsAssembler.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Swinject

public struct PlistAssembly<T: Codable>: Assembly {
    
    private let service: T

    public init(bundleIdentifier: String, infoDictionaryKey: String) throws {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            throw PlistAssemblyError.nilBundleIdentifier(bundleIdentifier)
        }
        guard let object = bundle.object(forInfoDictionaryKey: infoDictionaryKey) else {
            throw PlistAssemblyError.nilInfoDictionary(infoDictionaryKey)
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        service = try JSONDecoder().decode(T.self, from: data)
    }
    
    public func assemble(container: Container) {
        container.register(T.self) { _ in self.service }
    }
    
}
