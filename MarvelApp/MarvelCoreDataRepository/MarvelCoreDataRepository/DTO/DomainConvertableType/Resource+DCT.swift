//
//  Resource+DCT.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension Resource: DomainConvertableType {
    
    public static func fetchRequest(by uid: String) -> NSFetchRequest<NSFetchRequestResult>? {
        return nil
    }
    
    public func asDomain() -> MarvelDomain.Resource {
        return MarvelDomain.Resource(
            available: Int(available),
            returned: Int(returned),
            collectionURI: collectionURI,
            items: items.map({ $0.asDomain() })
        )
    }
    
}
