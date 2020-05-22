//
//  CoreDataRepresentable.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData

public protocol CoreDataRepresentable {
    
    associatedtype CoreDataType: (NSManagedObject & DomainConvertableType)
    
    var uid: String? { get }
    
    func update(entity: CoreDataType)
        
}
