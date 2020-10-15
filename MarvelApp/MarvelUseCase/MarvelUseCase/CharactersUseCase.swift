//
//  CharactersUseCase.swift
//  MarvelUseCase
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelDomain
import Core

public protocol CharactersUseCase {
    
    func fetch(with paging: Paging) -> AnyPublisher<[MarvelDomain.Character], Error>
    
}
