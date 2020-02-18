//
//  NetworkDependency.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 18.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import MarvelNetwork
import Swinject

class NetworkDependency: DependencyRegistering {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        registerURLConstructor()
        registerMarvelClient()
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
