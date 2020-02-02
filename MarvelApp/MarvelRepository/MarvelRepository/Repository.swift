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

public class Repository<T: NSManagedObject> {
    
    private let context: NSManagedObjectContext
    
    private let scheduler: ImmediateScheduler = .shared
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create() -> T {
        return T(context: context)
    }
    
    func queryResult(by request: NSFetchRequest<T>) throws -> T? {
        return try request.execute().first
    }
    
    func queryResults(by request: NSFetchRequest<T>) throws -> [T] {
        return try request.execute()
    }
    
    func findObject(by predicate: NSPredicate) -> T? {
        context.registeredObjects
            .filter({ !$0.isFault })
            .filter({ predicate.evaluate(with: $0) })
            .first as? T
    }
    
    func updateObject(by predicate: NSPredicate, configure: (T) -> Void) throws {
        if let object = findObject(by: predicate) {
            configure(object)
        } else {
            let request = NSFetchRequest<T>()
            request.predicate = predicate
            guard let object = try queryResult(by: request) else {
                return
            }
            configure(object)
        }
    }
    
    func delete(object: T, in context: NSManagedObjectContext) {
        context.delete(object)
    }
    

    
}
