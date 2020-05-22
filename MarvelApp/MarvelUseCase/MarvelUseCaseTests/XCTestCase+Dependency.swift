//
//  XCTestCase+Injection.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
//import MarvelNetwork
//import Core
//import MarvelRepository
//import MarvelDAO
//import MarvelDomain
//import CoreData
//import Swinject
//
//class Dependency {
//
//    let container = Swinject.Container()
//
//    func registerDependencies() throws {
//        try registerCredentials()
//        try registerConfiguration()
//        registerURLConstructor()
//        registerMarvelClient()
//        registerCharactersRepository()
//        registerCharactersDAO()
//        registerUseCases()
//    }
//
//    private func registerCredentials() throws {
//        guard
//            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelUseCaseTests")?.object(forInfoDictionaryKey: "Credentials") else {
//                return
//        }
//        let data = try JSONSerialization.data(withJSONObject: object, options: [])
//        let credentials = try JSONDecoder().decode(Credentials.self, from: data)
//        container.register(Credentials.self) { (resolver) -> Credentials in
//            return credentials
//        }
//    }
//
//    private func registerConfiguration() throws {
//        guard
//            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelUseCaseTests")?.object(forInfoDictionaryKey: "Configuration") else {
//                return
//        }
//        let data = try JSONSerialization.data(withJSONObject: object, options: [])
//        let configuration = try JSONDecoder().decode(Configuration.self, from: data)
//        container.register(Configuration.self) { (resolver) -> Configuration in
//            return configuration
//        }
//    }
//
//    private func registerURLConstructor() {
//        container.register(URLRequestConstructor.self) { (resolver) -> URLRequestConstructor in
//            return URLRequestConstructor(configuration: resolver.resolve(Configuration.self)!)
//        }
//    }
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
//
//}
