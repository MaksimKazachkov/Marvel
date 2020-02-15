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

public class CoreDataDAO<T: CoreDataRepresentable>: DAO where T == T.CoreDataType.DomainType {
    
    private let container: NSPersistentContainer
    
    public init(container: NSPersistentContainer) {
        self.container = container
    }
    
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
                let request = NSFetchRequest<NSFetchRequestResult>()
                request.resultType = .managedObjectResultType
                request.predicate = predicate
                let entity = try self.findOrFetch(by: request)
                promise(.success(entity?.asDomain()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func update(object: T) -> AnyPublisher<Void, Error> {
        return Future { [weak self] (promise) in
            guard let self = self, let uid = object.uid, let request = T.CoreDataType.fetchRequest(by: uid) else {
                return
            }
            do {
                let entity: T.CoreDataType = try self.findOrFetch(by: request) ?? T.CoreDataType(context: self.context)
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
            guard let self = self, let uid = object.uid, let request = T.CoreDataType.fetchRequest(by: uid) else {
                return
            }
            do {
                guard let entity = try self.findOrFetch(by: request) else {
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
    
    func queryResult(by request: NSFetchRequest<NSFetchRequestResult>) throws -> T.CoreDataType? {
        try context.fetch(request).first as? T.CoreDataType
    }
    
    func queryResults(by request: NSFetchRequest<NSFetchRequestResult>) throws -> [NSFetchRequestResult] {
        try context.fetch(request)
    }
    
}

// MARK: - Private methods
private extension CoreDataDAO {
    
    func findOrFetch(by request: NSFetchRequest<NSFetchRequestResult>) throws -> T.CoreDataType? {
        return try find(by: request) ?? fetch(by: request)
    }
    
    func fetch(by request: NSFetchRequest<NSFetchRequestResult>) throws -> T.CoreDataType? {
        return try self.queryResult(by: request)
    }
    
    func find(by request: NSFetchRequest<NSFetchRequestResult>) -> T.CoreDataType? {
        context.registeredObjects
            .compactMap({ $0 as? T.CoreDataType })
            .filter({ !$0.isFault })
            .filter({ (request.predicate?.evaluate(with: $0) ?? false) })
            .first
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
