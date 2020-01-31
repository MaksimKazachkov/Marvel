//
//  Repository.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreRepository
import Combine
import CoreData

public class Repository /*: CoreRepository.RepositoryType*/ {
    
    private let context: NSManagedObjectContext
    
    private let scheduler: ImmediateScheduler = .shared
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
}
