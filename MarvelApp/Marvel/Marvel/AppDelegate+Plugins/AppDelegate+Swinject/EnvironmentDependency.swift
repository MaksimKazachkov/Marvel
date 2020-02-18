//
//  Swinject+RegisterEnviropment.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 18.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import Swinject

class EnvironmentDependency: DependencyRegistering {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        try! registerCredentials()
        try! registerConfiguration()
    }
    
    private func registerCredentials() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.Marvel")?.object(forInfoDictionaryKey: "Credentials") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let credentials = try JSONDecoder().decode(Credentials.self, from: data)
        container.register(Credentials.self) { (resolver) -> Credentials in
            return credentials
        }
    }
    
    private func registerConfiguration() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.Marvel")?.object(forInfoDictionaryKey: "Configuration") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let configuration = try JSONDecoder().decode(Configuration.self, from: data)
        container.register(Configuration.self) { (resolver) -> Configuration in
            return configuration
        }
    }
    
}
