//
//  Character+DCT.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension Character: DomainConvertableType {
    
    public static func fetchRequest(by uid: String) -> NSFetchRequest<NSFetchRequestResult>? {
        let fetchReqeust: NSFetchRequest<Character> = fetchRequest()
        fetchReqeust.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Character.id), uid])
        fetchReqeust.resultType = .managedObjectResultType
        return fetchReqeust as? NSFetchRequest<NSFetchRequestResult>
    }
    
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
