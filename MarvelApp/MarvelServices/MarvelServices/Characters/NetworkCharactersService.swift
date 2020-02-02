//
//  NetworkCharactersService.swift
//  MarvelServices
//
//  Created by Maksim Kazachkov on 02.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelNetwork
import MarvelDomain

final public class NetworkCharactersService {
    
    private let client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    public func characters(limit: Int, offset: Int) -> AnyPublisher<[Character], Error> {
        let model = CharactersRO(limit: limit, offset: offset)
        return client.requestObjects(
            route: CharactersRoute.characters(model),
            at: "data.results"
        )
    }
    
}
