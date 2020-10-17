//
//  Character.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension Character: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self = .init(
            id: try container.decode(Int.self, forKey: .id),
            name: try container.decode(String.self, forKey: .name),
            description: try container.decode(String.self, forKey: .description),
            modified: Date(),
            resourceURI: try container.decode(.resourceURI, transformer: URLTransformer()),
            urls: try container.decode([URLType].self, forKey: .urls),
            thumbnail: try container.decode(Image.self, forKey: .thumbnail),
            comics: try container.decode(Resource.self, forKey: .comics),
            stories: try container.decode(Resource.self, forKey: .stories),
            events: try container.decode(Resource.self, forKey: .events),
            series: try container.decode(Resource.self, forKey: .series)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(modified, forKey: .modified)
        try container.encode(resourceURI, forKey: .resourceURI)
        try container.encode(urls, forKey: .urls)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(comics, forKey: .comics)
        try container.encode(stories, forKey: .stories)
        try container.encode(events, forKey: .events)
        try container.encode(series, forKey: .series)
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case id, name, description, modified, resourceURI, urls, thumbnail,
        comics, stories, events, series
        
    }
    
}
