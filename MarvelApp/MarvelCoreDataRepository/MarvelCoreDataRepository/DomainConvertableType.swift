//
//  DomainConvertableType.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData

public protocol DomainConvertableType {
    
    associatedtype DomainType
        
    func asDomain() -> DomainType
    
    static func fetchRequest(by uid: String) -> NSFetchRequest<NSFetchRequestResult>?
    
    static func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>
        
}
