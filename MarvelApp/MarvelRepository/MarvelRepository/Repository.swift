//
//  Repository.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import CoreData

public class Repository<T: CoreDataRepresentable> where T == T.CoreDataType.DomainType {
    
    private let container: NSPersistentContainer
    
    private let context: NSManagedObjectContext
    
    public init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.newBackgroundContext()
    }
    
    func create(object: T) -> T.CoreDataType {
        let entity = T.CoreDataType(context: context)
        object.update(entity: entity)
        return entity
    }
    
    func queryResult(by request: NSFetchRequest<NSFetchRequestResult>) throws -> NSFetchRequestResult? {
        try request.execute().first
    }
    
    func queryResults(by request: NSFetchRequest<NSFetchRequestResult>) throws -> [NSFetchRequestResult] {
        try request.execute()
    }
    
    func update(object: T) throws {
        let predicate = NSPredicate(format: "id == %@", object.uid)
        guard let entity = try findOrFetch(by: predicate) else {
            return
        }
        object.update(entity: entity)
    }
    
    func delete(object: T) {
        let predicate = NSPredicate(format: "id == %@", object.uid)
        do {
            guard let entity = try findOrFetch(by: predicate) else {
                return
            }
            context.delete(entity)
        } catch {
            print(error)
        }
    }
    
}

private extension Repository {
    
    func findOrFetch(by predicate: NSPredicate) throws -> T.CoreDataType? {
        return try find(by: predicate) ?? fetch(by: predicate)
    }
    
    func fetch(by predicate: NSPredicate) throws -> T.CoreDataType? {
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.predicate = predicate
        return try queryResult(by: request) as? T.CoreDataType
    }
    
    func find(by predicate: NSPredicate) -> T.CoreDataType? {
        context.registeredObjects
            .filter({ !$0.isFault })
            .filter({ predicate.evaluate(with: $0) })
            .first as? T.CoreDataType
    }
    
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
