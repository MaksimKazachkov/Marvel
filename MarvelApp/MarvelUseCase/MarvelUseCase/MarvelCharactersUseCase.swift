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
    
    public let repository: CharactersRepository
    
    public let dao: CoreDataDAO<Character>
    
    public init(
        repository: CharactersRepository,
        dao: CoreDataDAO<Character>
    ) {
        self.repository = repository
        self.dao = dao
    }
    
    public func fetch(limit: Int, offset: Int) -> AnyPublisher<[Character], Error> {
        return repository.characters(limit: limit, offset: offset)
            .flatMap({ self.save(characters: $0) })
            .eraseToAnyPublisher()
    }
    
}

private extension MarvelCharactersUseCase {
    
    func save(characters: [Character]) -> AnyPublisher<[Character], Error> {
        let publishers = characters
            .map({ return dao.create(object: $0) })
        
        return Publishers.MergeMany(publishers)
            .map({ characters })
            .eraseToAnyPublisher()
    }
    
}
