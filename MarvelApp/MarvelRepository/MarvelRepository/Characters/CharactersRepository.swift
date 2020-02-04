//
//  CharactersRepository.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelNetwork
import MarvelDomain

public protocol CharactersRepository {
    
    func characters(limit: Int, offset: Int) -> AnyPublisher<[Character], Error>
    
}
