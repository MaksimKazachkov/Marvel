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
            urls: urls.map({ $0.asDomain() }),
            comics: comics?.asDomain(),
            stories: stories?.asDomain(),
            events: events?.asDomain(),
            series: series?.asDomain()
        )
    }
    
}
