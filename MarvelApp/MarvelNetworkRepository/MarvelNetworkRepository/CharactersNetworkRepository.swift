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
        return client.requestObjects(
            route: CharactersRoute.characters(paging),
            at: "data.results"
        ).eraseToAnyPublisher()
    }
    
    
}
