//
//  Dependency.swift
//  MarvelNetworkTests
//
//  Created by Maksim Kazachkov on 06.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import MarvelNetwork
import Swinject

class Dependency {
    
    let container = Swinject.Container()
    
    func registerDependencies() throws {
        try registerCredentials()
        try registerConfiguration()
        registerURLConstructor()
        registerMarvelClient()
    }
    
    private func registerCredentials() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelNetworkTests")?.object(forInfoDictionaryKey: "Credentials") else {
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
            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelNetworkTests")?.object(forInfoDictionaryKey: "Configuration") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let configuration = try JSONDecoder().decode(Configuration.self, from: data)
        container.register(Configuration.self) { (resolver) -> Configuration in
            return configuration
        }
    }
    
    private func registerURLConstructor() {
        container.register(URLRequestConstructor.self) { (resolver) -> URLRequestConstructor in
            return URLRequestConstructor(configuration: resolver.resolve(Configuration.self)!)
        }
    }
    
    private func registerMarvelClient() {
        container.register(Client.self) { (resolver) -> MarvelClient in
            return MarvelClient(
                credentials: resolver.resolve(Credentials.self)!,
                constructor: resolver.resolve(URLRequestConstructor.self)!
            )
        }
    }
    
}
