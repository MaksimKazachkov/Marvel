//
//  CoreDataRepositoryAssembly.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 24.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import Swinject
import MarvelCoreDataRepository

enum CoreDataAssemblyError: Swift.Error, CustomDebugStringConvertible {
    
    case nilBundleIdentifier(String)
    case nilModelURL(String)
    case managedObjectModel(URL)
    
    var debugDescription: String {
        switch self {
        case let .nilBundleIdentifier(key):
            return "Can not create bundle identifier: \(key)"
        case let .nilModelURL(momdName):
            return "Can not create model url for momdName: \(momdName)"
        case let .managedObjectModel(url):
            return "Can not initialize mom from url: \(url)"
        }
    }
    
}

public struct CoreDataRepositoryAssembly<T: CoreDataRepresentable> where T == T.CoreDataType.DomainType {
    
    private let persistentContainer: NSPersistentContainer
    
    public init(momdName: String, bundleIdentifier: String) throws {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            throw CoreDataAssemblyError.nilBundleIdentifier(bundleIdentifier)
        }
        guard let modelURL = bundle.url(forResource: momdName, withExtension: "momd") else {
            throw CoreDataAssemblyError.nilModelURL(momdName)
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoreDataAssemblyError.managedObjectModel(modelURL)
        }
        let persistentContainer = NSPersistentContainer(
            name: momdName,
            managedObjectModel: managedObjectModel
        )
        let storeURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("\(momdName).sqlite")
        let psd = NSPersistentStoreDescription(url: storeURL)
        persistentContainer.persistentStoreDescriptions = [psd]
        self.persistentContainer = persistentContainer
    }
    
}

extension CoreDataRepositoryAssembly: Assembly {
    
    public func assemble(container: Container) {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            debugPrint("💡Persistent store url: \(storeDescription.url?.description ?? "🤷‍♂️ Could not find url")")
            container.register(CoreDataRepository<T>.self) { r -> CoreDataRepository<T> in
                return CoreDataRepository<T>(container: self.persistentContainer)
            }
        }
    }
}
