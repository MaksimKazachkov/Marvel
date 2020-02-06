//
//  MarvelCharactersRepository.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelDomain
import MarvelNetwork
import Resolver

final public class MarvelCharactersRepository: CharactersRepository {
    
    @Injected private var client: Client

    public func characters(limit: Int, offset: Int) -> AnyPublisher<[Character], Error> {
        let model = CharactersRO(limit: limit, offset: offset)
        return client.requestObjects(
            route: CharactersRoute.characters(model),
            at: "data.results"
        ).eraseToAnyPublisher()
    }
    
    
}
