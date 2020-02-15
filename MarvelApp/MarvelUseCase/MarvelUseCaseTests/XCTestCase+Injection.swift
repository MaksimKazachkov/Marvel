//
//  XCTestCase+Injection.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Resolver
import MarvelNetwork
import Core
import MarvelRepository
import MarvelDAO
import MarvelDomain
import CoreData

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        try! Resolver.root.registerDependencies()
    }
}

extension Resolver {
    
    func registerDependencies() throws {
        try registerCredentials()
        try registerConfiguration()
        registerURLConstructor()
        registerMarvelClient()
        registerCharactersRepository()
        registerCharactersDAO()
    }
    
    private func registerCredentials() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelNetworkTests")?.object(forInfoDictionaryKey: "Credentials") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let credentials = try JSONDecoder().decode(Credentials.self, from: data)
        Resolver
            .register { credentials }
    }
    
    private func registerConfiguration() throws {
        guard
            let object = Bundle(identifier: "com.MaksimKazachkov.MarvelNetworkTests")?.object(forInfoDictionaryKey: "Configuration") else {
                return
        }
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let configuration = try JSONDecoder().decode(Configuration.self, from: data)
        Resolver
            .register { configuration }
    }
    
    private func registerURLConstructor() {
        Resolver
            .register { URLRequestConstructor() }
    }
    
    private func registerMarvelClient() {
        Resolver
            .register { MarvelClient() }
            .implements(Client.self)
    }
    
    private func registerCharactersRepository() {
        Resolver
            .register { MarvelCharactersRepository() }
            .implements(CharactersRepository.self)
    }
    
    private func registerCharactersDAO() {
        let momdName = "Characters"
        guard let modelURL = Bundle(identifier: "com.MaksimKazachkov.MarvelDAO")?.url(forResource: momdName, withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: momdName, managedObjectModel: mom)
        let psd = NSPersistentStoreDescription()
        psd.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [psd]
        container.loadPersistentStores { (storeDescription, error) in
            Resolver.register { container }
            Resolver
                .register { CoreDataDAO<MarvelDomain.Character>() }
        }
        
    }
    
}
