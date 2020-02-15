//
//  URLType+DomainConvertableType.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension URLType: DomainConvertableType {
    
    public static func fetchRequest(by uid: String) -> NSFetchRequest<NSFetchRequestResult>? {
        return nil
    }

    public func asDomain() -> MarvelDomain.URLType {
        return MarvelDomain.URLType(
            type: type,
            url: url)
    }
    
}
