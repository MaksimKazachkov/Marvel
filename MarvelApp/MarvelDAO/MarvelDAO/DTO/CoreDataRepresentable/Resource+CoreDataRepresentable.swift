//
//  Resource+CoreDataRepresentable.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain
import CoreData

extension MarvelDomain.Resource: CoreDataRepresentable {
    
    public var uid: String? {
        return nil
    }
    
    public func update(entity: Resource) {
        if let available = available {
            entity.available = Int16(available)
        }
        entity.collectionURI = collectionURI
        if let returned = returned {
            entity.returned = Int16(returned)
        }
        
        if let context = entity.managedObjectContext {
            items?
                .forEach({
                    let itemEntity = MarvelDAO.Item(context: context)
                    $0.update(entity: itemEntity)
                    entity.addToItems(itemEntity)
                })
        }
    }
    
}
