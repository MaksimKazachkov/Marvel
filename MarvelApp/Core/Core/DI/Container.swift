//
//  Container.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public final class Container: Resolver {
    
    public static let main = Container()
    
    private var registrations: [ObjectIdentifier: Any] = [:]

    public func register<T>(_ object: T) {
        registrations[key(for: T.self)] = object
    }
    
    public func resolve<T>(_ objectType: T.Type) -> T? {
        return registrations[key(for: T.self)] as? T
    }
    
    private func key<T>(for type: T.Type) -> ObjectIdentifier {
        return ObjectIdentifier(T.self)
    }
    
}
