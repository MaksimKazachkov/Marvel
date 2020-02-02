//
//  CharactersService.swift
//  MarvelServices
//
//  Created by Maksim Kazachkov on 02.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

public protocol CharactersService {
    
    func characters(limit: Int, offset: Int) -> AnyPublisher<[Character], Error>
    
}
