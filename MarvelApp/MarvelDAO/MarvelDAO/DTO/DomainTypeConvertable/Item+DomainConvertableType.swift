//
//  Item+DomainConvertableType.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension Item: DomainConvertableType {
    
    public func asDomain() -> MarvelDomain.Resource.Item {
        return MarvelDomain.Resource.Item(
            name: name,
            resourceURI: resourceURI
        )
    }
    
}
