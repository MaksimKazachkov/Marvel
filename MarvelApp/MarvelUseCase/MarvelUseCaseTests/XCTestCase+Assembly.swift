//
//  XCTestCase+Injection.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelNetwork
import Core
import MarvelNetworkRepository
import MarvelCoreDataRepository
import MarvelDomain
import Swinject

struct AssemblerHelper {

    func applyAssemblies() throws {
        try applyCredentialsAssembly()
        try applyConfigurationAssembly()
        applyURLConstructorAssembly()
        //        registerMarvelClient()
        //        registerCharactersRepository()
        //        registerCharactersDAO()
        //        registerUseCases()
    }

    private func applyCredentialsAssembly() throws {
        let assembly = try PlistAssembly<Credentials>(
            bundleIdentifier: "com.MaksimKazachkov.MarvelUseCaseTests",
            infoDictionaryKey: "Credentials"
        )
        assembler.apply(assembly: assembly)
    }

    private func applyConfigurationAssembly() throws {
        let assembly = try PlistAssembly<Configuration>(
            bundleIdentifier: "com.MaksimKazachkov.MarvelUseCaseTests",
            infoDictionaryKey: "Configuration"
        )
        assembler.apply(assembly: assembly)
    }

    private func applyURLConstructorAssembly() {
        assembler.apply(assembly: URLRequestConstructorAssembly())
    }
 
    
//        private func registerCharactersRepository() {
//            container.register(CharactersRepository.self) { (resolver) -> MarvelCharactersRepository in
//                return MarvelCharactersRepository(client: resolver.resolve(Client.self)!)
//            }
//        }
//
//        private func registerCharactersDAO() {
//            let momdName = "Characters"
//            guard let modelURL = Bundle(identifier: "com.MaksimKazachkov.MarvelDAO")?.url(forResource: momdName, withExtension:"momd") else {
//                fatalError("Error loading model from bundle")
//            }
//            guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
//                fatalError("Error initializing mom from: \(modelURL)")
//            }
//            let persistentContainer = NSPersistentContainer(name: momdName, managedObjectModel: mom)
//            let storeURL = try! FileManager
//                .default
//                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                .appendingPathComponent("Characters.sqlite")
//            let psd = NSPersistentStoreDescription(url: storeURL)
//            persistentContainer.persistentStoreDescriptions = [psd]
//            persistentContainer.loadPersistentStores { (storeDescription, error) in
//                debugPrint("💡Persistent store url: \(storeDescription.url?.description ?? "🤷‍♂️ Could not find url")")
//                self.container.register(CoreDataDAO<MarvelDomain.Character>.self) { (resolver) -> CoreDataDAO<MarvelDomain.Character> in
//                    return CoreDataDAO<MarvelDomain.Character>.init(container: persistentContainer)
//                }
//            }
//        }
//
//        func registerUseCases() {
//            container.register(CharactersUseCase.self) { (resolver) -> MarvelCharactersUseCase in
//                return MarvelCharactersUseCase(
//                    repository: resolver.resolve(CharactersRepository.self)!,
//                    dao: resolver.resolve(CoreDataDAO<MarvelDomain.Character>.self)!)
//            }
//        }
    
}
