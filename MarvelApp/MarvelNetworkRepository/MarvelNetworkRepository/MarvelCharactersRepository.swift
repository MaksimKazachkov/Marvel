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
    
    private let fetcher: Fetcher
    
    public init(client: Fetcher) {
        self.fetcher = client
    }
    
    public func characters(
        parameters: CharactersParameters
    ) -> AnyPublisher<[Character], Error> {
        return fetcher.requestObjects(
            route: CharactersRoute.characters(parameters),
            at: "data.results"
        ).eraseToAnyPublisher()
    }
    
    
}
