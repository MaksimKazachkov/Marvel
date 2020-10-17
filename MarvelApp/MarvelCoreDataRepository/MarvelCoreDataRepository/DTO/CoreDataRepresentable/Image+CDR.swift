//
//  Image+CDR.swift
//  MarvelCoreDataRepository
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension MarvelDomain.Image: CoreDataRepresentable {
    
    public var uid: String? {
        return nil
    }
    
    public func update(entity: Image) {
        entity.path = path
        entity.ext = extensionType.rawValue
    }
    
}
