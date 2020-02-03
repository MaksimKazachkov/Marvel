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
    
    private func sync<P>(object: T, update: @escaping (P) -> Void) where T.CoreDataType == P {
        let predicate = NSPredicate(
            format: "%@ == %@",
            T.primaryAttribute,
            object.uid
        )
        if let result = find(by: predicate) {
            //            sync(object: <#T##T#>, update: <#T##(P) -> Void#>)
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.predicate = predicate
            do {
                if let result = try queryResult(by: request) {
                    
                } else {
                    create(object: object)
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    func create(object: T) -> T.CoreDataType {
        let entity = T.CoreDataType(context: context)
        //        object.update(entity: entity)
        
        return entity
    }
    
    func queryResult(by request: NSFetchRequest<NSFetchRequestResult>) throws -> NSFetchRequestResult? {
        try request.execute().first
    }
    
    func queryResults(by request: NSFetchRequest<NSFetchRequestResult>) throws -> [NSFetchRequestResult] {
        try request.execute()
    }
    
    func find(by predicate: NSPredicate) -> T? {
        context.registeredObjects
            .filter({ !$0.isFault })
            .filter({ predicate.evaluate(with: $0) })
            .first as? T
    }
    
    func update(by predicate: NSPredicate, configure: (T) -> Void) throws {
        if let object = find(by: predicate) {
            configure(object)
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.predicate = predicate
            guard let object = try queryResult(by: request) as? T else {
                return
            }
            configure(object)
        }
    }
    
    func delete(object: T) {
        //        context.delete(object)
    }
    
    private func save(context: NSManagedObjectContext) throws {
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
