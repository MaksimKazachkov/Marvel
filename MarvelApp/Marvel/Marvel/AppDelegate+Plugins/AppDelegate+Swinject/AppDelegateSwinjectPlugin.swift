//
//  AppDelegate+DI.swift
//  Marvel
//
//  Created by Maksim Kazachkov on 06.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import UIKit
import MarvelNetwork
import MarvelRepository
import MarvelDAO
import MarvelDomain
import CoreData
import Swinject

class AppDelegateSwinjectPlugin: NSObject, UIApplicationDelegate {
    
    private let container = Container()
    
    private lazy var dependencies: [DependencyRegistering] = {
        return [
            EnvironmentDependency(container: container),
            NetworkDependency(container: container),
            RepositoryDependency(container: container),
            DAODependency(container: container),
            UseCaseDependency(container: container)
        ]
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dependencies.forEach({ $0.register() })
        
        return true
    }
    
}
