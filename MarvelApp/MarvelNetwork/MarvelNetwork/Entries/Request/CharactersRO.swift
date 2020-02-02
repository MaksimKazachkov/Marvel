//
//  CharactersRO.swift
//  MarvelNetwork
//
//  Created by Maksim Kazachkov on 02.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct CharactersRO: Codable {
    
    let limit: Int
    
    let offset: Int
    
    public init(
        limit: Int,
        offset: Int
    ) {
        self.limit = limit
        self.offset = offset
    }
    
}
