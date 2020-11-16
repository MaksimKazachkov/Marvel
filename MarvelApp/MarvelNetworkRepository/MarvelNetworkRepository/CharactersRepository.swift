//
//  CharactersRepository.swift
//  MarvelNetworkRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelNetwork
import MarvelDomain
import Core

public protocol CharactersRepository {
    
    func characters(
        parameters: CharactersParameters
    ) -> AnyPublisher<[Character], Error>
    
}
