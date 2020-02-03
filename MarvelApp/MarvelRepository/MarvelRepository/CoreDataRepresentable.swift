//
//  CoreDataRepresentable.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 03.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData

public protocol CoreDataRepresentable {
    
    associatedtype CoreDataType: (NSManagedObject & DomainConvertableType)
    
    var uid: String { get }
    
    func update(entity: CoreDataType)
    
    static var primaryAttribute: String { get }
    
}
