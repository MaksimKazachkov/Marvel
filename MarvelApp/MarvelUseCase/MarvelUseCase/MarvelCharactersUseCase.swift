//
//  MarvelCharactersUseCase.swift
//  MarvelUseCase
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelDomain
import MarvelNetworkRepository
import MarvelCoreDataRepository

final public class MarvelCharactersUseCase: CharactersUseCase {
        
    private let networkRepository: CharactersRepository

    private let coreDataRepository: CoreDataRepository<MarvelDomain.Character>
    
    public init(
        networkRepository: CharactersRepository,
        coreDataRepository: CoreDataRepository<MarvelDomain.Character>
    ) {
        self.networkRepository = networkRepository
        self.coreDataRepository = coreDataRepository
    }
    
    public func fetch(limit: Int, offset: Int) -> AnyPublisher<[MarvelDomain.Character], Error> {
        return networkRepository.characters(limit: limit, offset: offset)
            .flatMap({ self.save(characters: $0) })
            .eraseToAnyPublisher()
    }
    
}

private extension MarvelCharactersUseCase {
    
    func save(characters: [MarvelDomain.Character]) -> AnyPublisher<[MarvelDomain.Character], Error> {
        let publishers = characters
            .map({ return coreDataRepository.update(object: $0) })
        
        return Publishers.MergeMany(publishers)
            .map({ characters })
            .eraseToAnyPublisher()
    }
    
}
