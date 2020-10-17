//
//  ContainerAssembly.swift
//  Marvel
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

public struct CharactersAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CharactersViewContainer.self) { r -> CharactersViewContainer in
            return CharactersViewContainer(
                charactersInteractor: r.resolve(CharactersInteractorType.self)!
            )
        }
    }
    
}
