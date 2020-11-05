//
//  Paging.swift
//  MarvelNetwork
//
//  Created by Максим Казачков on 25.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension Paging: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self = .init(
            limit: try container.decode(Int.self, forKey: .limit),
            offset: try container.decode(Int.self, forKey: .offset)
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(limit, forKey: .limit)
        try container.encode(offset, forKey: .offset)
    }

    private enum CodingKeys: String, CodingKey {

        case limit, offset
        
    }
    
}
