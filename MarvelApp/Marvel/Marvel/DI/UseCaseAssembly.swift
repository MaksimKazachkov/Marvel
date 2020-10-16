//
//  UseCaseAssembly.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 24.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core
import MarvelNetwork
import MarvelNetworkRepository
import MarvelUseCase
import MarvelCoreDataRepository
import MarvelDomain
import Swinject

public struct UseCaseAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CharactersUseCase.self) { r -> CharactersUseCase in
            return MarvelCharactersUseCase(
                networkRepository: r.resolve(CharactersRepository.self)!,
                coreDataRepository: r.resolve(CoreDataRepository<MarvelDomain.Character>.self)!
            )
        }
    }
    
}

