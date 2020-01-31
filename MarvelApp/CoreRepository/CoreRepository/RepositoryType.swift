//
//  RepositoryType.swift
//  CoreRepository
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

public protocol RepositoryType {
    
    associatedtype T
    func query(with predicate: NSPredicate?,
               sortDescriptors: [NSSortDescriptor]?) -> AnyPublisher<[T], NSError>
    func save(entity: T) -> AnyPublisher<T, Error>
    func delete(entity: T) -> AnyPublisher<Void, NSError>
    
}
