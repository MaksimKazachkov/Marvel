//
//  Resource+CDR.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
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
            entity.removeFromItems(entity.items)
            items?
                .forEach({
                    let itemEntity = MarvelCoreDataRepository.Item(context: context)
                    $0.update(entity: itemEntity)
                    entity.addToItems(itemEntity)
                })
        }
    }
    
}
