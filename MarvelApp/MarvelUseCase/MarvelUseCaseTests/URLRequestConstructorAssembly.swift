//
//  URLRequestConstructorAssembly.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelNetwork
import Core
import Swinject

public struct URLRequestConstructorAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(URLRequestConstructor.self) { r in
            return URLRequestConstructor(configuration: r.resolve(Configuration.self)!)
        }
    }
    
}
