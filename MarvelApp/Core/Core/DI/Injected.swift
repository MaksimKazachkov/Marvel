//
//  Injected.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Swinject

@propertyWrapper
public struct Injected<T> {

    private var object: T!
    
    public init() {
        self.object = resolver.resolve(T.self)!
    }

    public init(resolver: Resolver = resolver) {
        self.object = resolver.resolve(T.self)!
    }

    public var wrappedValue: T {
        get { object }
        mutating set { object = newValue }
    }
    public var projectedValue: Injected<T> {
        get { self }
        mutating set { self = newValue }
    }
    
}
