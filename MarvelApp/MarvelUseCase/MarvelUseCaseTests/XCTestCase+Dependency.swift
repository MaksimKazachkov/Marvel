//
//  XCTestCase+Injection.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelNetwork
import Core
import MarvelNetworkRepository
import MarvelCoreDataRepository
import MarvelDomain
import CoreData

class Dependency {
    
    private let container: Container = .main

    func registerDependencies() throws {
        try registerCredentials()
        try registerConfiguration()
        registerURLConstructor()
//        registerMarvelClient()
//        registerCharactersRepository()
//        registerCharactersDAO()
//        registerUseCases()
    }

    private func registerCredentials() throws {
        let assembler = CredentialsAssembler(
            bundleIdentifier: "com.MaksimKazachkov.MarvelUseCaseTests",
            infoDictionaryKey: "Credentials"
        )
        let credentials = try assembler.resolve()
        container.register(credentials)
    }

    private func registerConfiguration() throws {
        let assembler = ConfigurationAssembler(
            bundleIdentifier: "com.MaksimKazachkov.MarvelUseCaseTests",
            infoDictionaryKey: "Configuration"
        )
        let configuration = try assembler.resolve()
        container.register(configuration)
    }

    private func registerURLConstructor() {
        let urlConstructor = URLRequestConstructor(configuration: container.resolve(Configuration.self)!)
        container.register(urlConstructor)
    }
//
//    private func registerMarvelClient() {
//        container.register(Client.self) { (resolver) -> MarvelClient in
//            return MarvelClient(
//                credentials: resolver.resolve(Credentials.self)!,
//                constructor: resolver.resolve(URLRequestConstructor.self)!
//            )
//        }
//    }
//
//    private func registerCharactersRepository() {
//        container.register(CharactersRepository.self) { (resolver) -> MarvelCharactersRepository in
//            return MarvelCharactersRepository(client: resolver.resolve(Client.self)!)
//        }
//    }
//
//    private func registerCharactersDAO() {
//        let momdName = "Characters"
//        guard let modelURL = Bundle(identifier: "com.MaksimKazachkov.MarvelDAO")?.url(forResource: momdName, withExtension:"momd") else {
//            fatalError("Error loading model from bundle")
//        }
//        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
//            fatalError("Error initializing mom from: \(modelURL)")
//        }
//        let persistentContainer = NSPersistentContainer(name: momdName, managedObjectModel: mom)
//        let storeURL = try! FileManager
//            .default
//            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            .appendingPathComponent("Characters.sqlite")
//        let psd = NSPersistentStoreDescription(url: storeURL)
//        persistentContainer.persistentStoreDescriptions = [psd]
//        persistentContainer.loadPersistentStores { (storeDescription, error) in
//            debugPrint("💡Persistent store url: \(storeDescription.url?.description ?? "🤷‍♂️ Could not find url")")
//            self.container.register(CoreDataDAO<MarvelDomain.Character>.self) { (resolver) -> CoreDataDAO<MarvelDomain.Character> in
//                return CoreDataDAO<MarvelDomain.Character>.init(container: persistentContainer)
//            }
//        }
//    }
//
//    func registerUseCases() {
//        container.register(CharactersUseCase.self) { (resolver) -> MarvelCharactersUseCase in
//            return MarvelCharactersUseCase(
//                repository: resolver.resolve(CharactersRepository.self)!,
//                dao: resolver.resolve(CoreDataDAO<MarvelDomain.Character>.self)!)
//        }
//    }

}
