//
//  UseCaseDependency.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 18.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDAO
import MarvelRepository
import MarvelDomain
import MarvelUseCase
import Swinject

class UseCaseDependency: DependencyRegistering {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        registerUseCases()
    }
    
    func registerUseCases() {
        container.register(CharactersUseCase.self) { (resolver) -> MarvelCharactersUseCase in
            return MarvelCharactersUseCase(
                repository: resolver.resolve(CharactersRepository.self)!,
                dao: resolver.resolve(CoreDataDAO<MarvelDomain.Character>.self)!)
        }
    }
    
}
