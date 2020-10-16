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

struct AssemblyFactory {
    
    func applyAssemblies() throws {
        assembler.apply(assemblies: [
            try makeCredentialsAssembly(),
            try makeConfigurationAssembly(),
            makeURLConstructorAssembly(),
            makeNetworkCharactersRepositoryAssembly(),
            try makeCoreDataRepositoryAssembly(),
            makeUseCaseAssembly(),
            makeInteractorAssembly()
        ])
    }
    
    private func makeCredentialsAssembly() throws -> Assembly {
        return try PlistAssembly<Credentials>(
            bundleIdentifier: "com.MaksimKazachkov.Marvel",
            infoDictionaryKey: "Credentials"
        )
    }
    
    private func makeConfigurationAssembly() throws -> Assembly {
        return try PlistAssembly<Configuration>(
            bundleIdentifier: "com.MaksimKazachkov.Marvel",
            infoDictionaryKey: "Configuration"
        )
    }
    
    private func makeURLConstructorAssembly() -> Assembly {
        return URLRequestConstructorAssembly()
    }
    
    
    private func makeNetworkCharactersRepositoryAssembly() -> Assembly {
        return NetworkRepositoryAssembly()
    }
    
    private func makeCoreDataRepositoryAssembly() throws -> Assembly {
        return try CoreDataRepositoryAssembly<MarvelDomain.Character>(
            momdName: "Characters",
            bundleIdentifier: "com.MaksimKazachkov.MarvelCoreDataRepository"
        )
    }
    
    private func makeUseCaseAssembly() -> Assembly {
        return UseCaseAssembly()
    }
    
    private func makeInteractorAssembly() -> Assembly {
        return InteractorAssembly()
    }
    
}
