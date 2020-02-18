//
//  RepositoryDependency.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 18.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelNetwork
import MarvelRepository
import Swinject

class RepositoryDependency: DependencyRegistering {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        registerCharactersRepository()
    }
    
    private func registerCharactersRepository() {
        container.register(CharactersRepository.self) { (resolver) -> MarvelCharactersRepository in
            return MarvelCharactersRepository(client: resolver.resolve(Client.self)!)
        }
    }
    
}
