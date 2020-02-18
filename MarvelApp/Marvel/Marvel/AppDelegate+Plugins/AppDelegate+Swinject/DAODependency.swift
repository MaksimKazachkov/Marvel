//
//  DAODependency.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 18.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDAO
import MarvelDomain
import Swinject

class DAODependency: DependencyRegistering {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        registerCharactersDAO()
    }
    
    private func registerCharactersDAO() {
        let momdName = "Characters"
        guard let modelURL = Bundle(identifier: "com.MaksimKazachkov.Marvel")?.url(forResource: momdName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let persistentContainer = NSPersistentContainer(name: momdName, managedObjectModel: mom)
        let storeURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("Characters.sqlite")
        let psd = NSPersistentStoreDescription(url: storeURL)
        persistentContainer.persistentStoreDescriptions = [psd]
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            debugPrint("💡Persistent store url: \(storeDescription.url?.description ?? "🤷‍♂️ Could not find url")")
            self.container.register(CoreDataDAO<MarvelDomain.Character>.self) { (resolver) -> CoreDataDAO<MarvelDomain.Character> in
                return CoreDataDAO<MarvelDomain.Character>.init(container: persistentContainer)
            }
        }
    }
    
}
