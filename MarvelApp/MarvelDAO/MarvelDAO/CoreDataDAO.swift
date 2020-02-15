//
//  CoreDataDAO.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import CoreData
import MarvelDomain
import Resolver

public class CoreDataDAO<T: CoreDataRepresentable>: DAO where T == T.CoreDataType.DomainType {
    
    @Injected private var container: NSPersistentContainer
    
    private lazy var context: NSManagedObjectContext = {
       return container.newBackgroundContext()
    }()

    public func create(object: T) -> AnyPublisher<Void, Error> {
        return Future { [weak self] (promise) in
            guard let self = self else {
                return
            }
            let entity = T.CoreDataType(context: self.context)
            object.update(entity: entity)
            promise(.success(()))
        }
        .flatMap({ self.save(context: self.context) })
        .eraseToAnyPublisher()
    }
    
    public func read(by predicate: NSPredicate) -> AnyPublisher<T?, Error> {
        return Future { [weak self] (promise) in
            guard let self = self else {
                return
            }
            do {
                let entity = try self.findOrFetch(by: predicate)
                promise(.success(entity?.asDomain()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func update(object: T) -> AnyPublisher<Void, Error> {
        return Future { [weak self] (promise) in
            guard let self = self, let uid = object.uid else {
                return
            }
            let predicate = NSPredicate(format: "id == %@", uid)
            do {
                guard let entity = try self.findOrFetch(by: predicate) else {
                    return
                }
                object.update(entity: entity)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .flatMap({ self.save(context: self.context) })
        .eraseToAnyPublisher()
    }
    
    public func delete(object: T) -> AnyPublisher<Void, Error> {
        return Future { [weak self] (promise) in
            guard let self = self, let uid = object.uid else {
                return
            }
            let predicate = NSPredicate(format: "id == %@", uid)
            do {
                guard let entity = try self.findOrFetch(by: predicate) else {
                    return
                }
                self.context.delete(entity)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .flatMap({ self.save(context: self.context) })
        .eraseToAnyPublisher()
    }
    
    func queryResult(by request: NSFetchRequest<NSFetchRequestResult>) throws -> NSFetchRequestResult? {
        try request.execute().first
    }
    
    func queryResults(by request: NSFetchRequest<NSFetchRequestResult>) throws -> [NSFetchRequestResult] {
        try request.execute()
    }
    
}

// MARK: - Private methods
private extension CoreDataDAO {
    
    func findOrFetch(by predicate: NSPredicate) throws -> T.CoreDataType? {
        return try find(by: predicate) ?? fetch(by: predicate)
    }
    
    func fetch(by predicate: NSPredicate) throws -> T.CoreDataType? {
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.predicate = predicate
        return try self.queryResult(by: request) as? T.CoreDataType
    }
    
    func find(by predicate: NSPredicate) -> T.CoreDataType? {
        context.registeredObjects
            .filter({ !$0.isFault })
            .filter({ predicate.evaluate(with: $0) })
            .first as? T.CoreDataType
    }
    
    func save(context: NSManagedObjectContext) -> AnyPublisher<Void, Error> {
        return Future { (promise) in
            guard context.hasChanges else {
                return
            }
            do {
                try context.save()
                promise(.success(()))
            } catch {
                context.rollback()
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
}
