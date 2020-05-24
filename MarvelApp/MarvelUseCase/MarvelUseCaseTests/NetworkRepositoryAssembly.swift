//
//  NetworkRepositoryAssembly.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import MarvelNetwork
import MarvelNetworkRepository
import Swinject

public struct NetworkRepositoryAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(Client.self) { r -> MarvelClient in
            return MarvelClient(
                credentials: r.resolve(Credentials.self)!,
                constructor: r.resolve(URLRequestConstructor.self)!
            )
        }
        container.register(CharactersRepository.self) { (resolver) -> CharactersRepository in
            return MarvelCharactersRepository(client: resolver.resolve(Client.self)!)
        }
    }
    
}
