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

extension CharacterMO: DomainConvertableType {
    
    public func asDomain() -> Character {
        return Character(
            id: Int(id),
            name: name!,
            description: desc!,
            modified: modified!,
            resourceURI: URL(string: "www.google.com")!,
            urls: [],
            comics: Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []),
            stories: Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []),
            events: Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []),
            series: Resource(available: 0, returned: 0, collectionURI: URL(string: "www.google.com")!, items: []))
    }
    
}
