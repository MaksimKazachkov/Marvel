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
        try 
        let predicate = NSPredicate(format: "id == %@", object.uid)
        if let entity = find(by: predicate) {
            object.update(entity: entity)
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.predicate = predicate
            guard let entity = try queryResult(by: request) as? T.CoreDataType else {
                return
            }
            object.update(entity: entity)
        }
    }
    
    func delete(object: T) {
        context.delete(object)
    }
    
}

private extension Repository {
    
    func findOrFetch(by predicate: NSPredicate) throws -> T.CoreDataType? {
        if let entity = find(by: predicate) {
            return entity
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.predicate = predicate
            guard let entity = try queryResult(by: request) as? T.CoreDataType else {
                return nil
            }
            return entity
        }
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
