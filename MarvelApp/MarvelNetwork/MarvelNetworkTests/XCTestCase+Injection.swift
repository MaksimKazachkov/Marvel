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

class Injection {
    
    func registerClient() throws {
        try registerCredentials()
        try registerClient()
        
        Resolver.root
            .register { MarvelClient() }
            .implements(Client.self)
    }
    
    private func registerCredentials() throws {
        guard
            let path = Bundle.main.path(forResource: "Credentials", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path) else {
                return
        }
        let credentials = try PropertyListDecoder().decode(Credentials.self, from: data)
        Resolver.root
            .register { credentials }
            .implements(Credentials.self)
    }
    
    private func registerConfiguration() throws {
        guard
            let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path) else {
                return
        }
        let configuration = try PropertyListDecoder().decode(Configuration.self, from: data)
        Resolver.root
            .register { configuration }
            .implements(Credentials.self)
    }
    
}
