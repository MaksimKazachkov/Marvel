//
//  BasePersistentContainer.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 31.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData

class BasePersistenceContainer: NSPersistentContainer {
    
    func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }
    

        
}
