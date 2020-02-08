//
//  Dependency.swift
//  MarvelNetworkTests
//
//  Created by Maksim Kazachkov on 06.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import Resolver
import MarvelNetwork

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        try! Resolver.root.registerClient()
    }
}

extension Resolver {
    
    func registerClient() throws {
        print("🟢")
        try registerCredentials()
        print("🔴")
        try registerConfiguration()
        print("🌕")
        registerURLConstructor()
        Resolver
            .register { MarvelClient() }
            .implements(Client.self)
            .scope(ResolverScopeApplication())
    }
    
    private func registerCredentials() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelNetworkTests")?.object(forInfoDictionaryKey: "Credentials") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let credentials = try JSONDecoder().decode(Credentials.self, from: data)
        Resolver
            .register { credentials }
            .implements(Credentials.self)
            .scope(ResolverScopeApplication())
    }
    
    private func registerConfiguration() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelNetworkTests")?.object(forInfoDictionaryKey: "Configuration") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let configuration = try JSONDecoder().decode(Configuration.self, from: data)
        Resolver
            .register { configuration }
            .implements(Configuration.self)
            .scope(ResolverScopeApplication())
    }
    
    private func registerURLConstructor() {
        Resolver
            .register { URLRequestConstructor() }
            .implements(URLRequestConstructor.self)
            .scope(ResolverScopeApplication())
    }
    
}
