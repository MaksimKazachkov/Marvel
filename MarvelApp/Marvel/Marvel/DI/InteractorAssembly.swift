//
//  InteractorAssembly.swift
//  MarvelUseCaseTests
//
//  Created by Максим Казачков on 16.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import MarvelNetwork
import MarvelNetworkRepository
import MarvelUseCase
import MarvelCoreDataRepository
import MarvelDomain
import Redux
import Swinject

public struct InteractorAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CharactersInteractorType.self) { r -> CharactersInteractor in
            return CharactersInteractor(
                useCase: r.resolve(CharactersUseCase.self)!,
                store: charactersStore
            )
        }
    }
    
}

