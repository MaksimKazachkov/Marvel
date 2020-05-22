//
//  RepositoryType.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import CoreData

public protocol DAO {
    
    associatedtype T
    
    func create(object: T) -> AnyPublisher<Void, Error>
    func read(by predicate: NSPredicate) -> AnyPublisher<T?, Error>
    func update(object: T) -> AnyPublisher<Void, Error>
    func delete(object: T) -> AnyPublisher<Void, Error>
    
}
