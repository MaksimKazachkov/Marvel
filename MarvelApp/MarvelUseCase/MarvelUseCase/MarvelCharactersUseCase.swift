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
import Resolver

final public class MarvelCharactersUseCase: CharactersUseCase {
    
    @Injected private var repository: CharactersRepository
    
    @Injected private var dao: CoreDataDAO<Character>
    
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
