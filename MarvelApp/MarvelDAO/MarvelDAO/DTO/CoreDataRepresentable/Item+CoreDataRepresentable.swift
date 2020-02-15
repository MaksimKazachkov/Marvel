//
//  Item+CoreDataRepresentable.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension MarvelDomain.Resource.Item: CoreDataRepresentable {
    
    public var uid: String? {
        return nil
    }
    
    public func update(entity: Item) {
        entity.name = name
        entity.resourceURI = resourceURI
    }
    
}
