//
//  Resource.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension Resource: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self = .init(
            available: try container.decode(Int.self, forKey: .available),
            returned: try container.decode(Int.self, forKey: .returned),
            collectionURI: try container.decode(.collectionURI, transformer: URLTransformer()),
            items: try container.decode([Item].self, forKey: .items)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(available, forKey: .available)
        try container.encode(returned, forKey: .returned)
        try container.encode(collectionURI, forKey: .collectionURI)
        try container.encode(items, forKey: .items)
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case available, returned, collectionURI, items
        
    }
    
}
