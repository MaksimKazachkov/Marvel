//
//  Character+CoreDataRepresentable.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 03.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension MarvelDomain.Character: CoreDataRepresentable {
    
    public var uid: String? {
        guard let id = id else {
            return nil
        }
        return String(id)
    }
    
    public func update(entity: Character) {
        if let id = id {
            entity.id = Int64(id)
        }
        entity.name = name
        entity.desc = description
        entity.modified = modified
        entity.resourceURI = resourceURI
    }
    
}
