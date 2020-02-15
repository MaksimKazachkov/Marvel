//
//  CharacterMO+DomainConvertableType.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 03.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension Character: DomainConvertableType {
    
    public func asDomain() -> MarvelDomain.Character {
        return MarvelDomain.Character(
            id: Int(id),
            name: name,
            description: desc,
            modified: modified,
            resourceURI: resourceURI,
            urls: [],
            comics: MarvelDomain.Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []),
            stories: MarvelDomain.Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []),
            events: MarvelDomain.Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []),
            series: MarvelDomain.Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []))
    }
    
}
