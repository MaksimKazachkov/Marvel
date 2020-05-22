//
//  URLType+DCT.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
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
