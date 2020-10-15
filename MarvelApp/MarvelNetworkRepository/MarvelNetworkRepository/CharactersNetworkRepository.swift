//
//  CharactersNetworkRepository.swift
//  MarvelNetworkRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelDomain
import MarvelNetwork
import Core

final public class MarvelCharactersRepository: CharactersRepository {
    
    private let client: Client
    
    public init(client: Client) {
        self.client = client
    }

    public func characters(with paging: Paging) -> AnyPublisher<[Character], Error> {
        let model = CharactersRO(limit: paging.limit, offset: paging.offset)
        return client.requestObjects(
            route: CharactersRoute.characters(model),
            at: "data.results"
        ).eraseToAnyPublisher()
    }
    
    
}
