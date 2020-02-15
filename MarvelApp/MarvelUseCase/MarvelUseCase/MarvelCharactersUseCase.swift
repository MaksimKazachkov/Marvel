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
import MarvelRepository
import MarvelDAO

final public class MarvelCharactersUseCase: CharactersUseCase {
        
    private let repository: CharactersRepository

    private let dao: CoreDataDAO<MarvelDomain.Character>
    
    public init(
        repository: CharactersRepository,
        dao: CoreDataDAO<MarvelDomain.Character>
    ) {
        self.repository = repository
        self.dao = dao
    }
    
    public func fetch(limit: Int, offset: Int) -> AnyPublisher<[MarvelDomain.Character], Error> {
        return repository.characters(limit: limit, offset: offset)
            .flatMap({ self.save(characters: $0) })
            .eraseToAnyPublisher()
    }
    
}

private extension MarvelCharactersUseCase {
    
    func save(characters: [MarvelDomain.Character]) -> AnyPublisher<[MarvelDomain.Character], Error> {
        let publishers = characters
            .map({ return dao.create(object: $0) })
        
        return Publishers.MergeMany(publishers)
            .map({ characters })
            .eraseToAnyPublisher()
    }
    
}
