//
//  URLType.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension URLType: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self = .init(
            type: try container.decode(String.self, forKey: .type),
            url: try container.decode(.url, transformer: URLTransformer())
        )

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(url, forKey: .url)
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case type, url
        
    }
    
}
