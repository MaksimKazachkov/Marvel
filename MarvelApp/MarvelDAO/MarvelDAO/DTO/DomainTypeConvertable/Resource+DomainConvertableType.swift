//
//  Resource+DomainConvertableType.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension Resource: DomainConvertableType {
    
    public func asDomain() -> MarvelDomain.Resource {
        return MarvelDomain.Resource(
            available: Int(available),
            returned: Int(returned),
            collectionURI: collectionURI,
            items: items.map({ $0.asDomain() })
        )
    }
    
}
