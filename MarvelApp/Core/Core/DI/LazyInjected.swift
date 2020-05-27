//
//  LazyInjected.swift
//  Core
//
//  Created by Maksim Kazachkov on 27.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Swinject

@propertyWrapper
public struct LazyInjected<T> {
    
    private var object: T!
    
    public let resolver: Resolver
        
    public init() {
        self.resolver = Core.resolver
    }
    
    public init(resolver: Resolver = Core.resolver) {
        self.resolver = resolver
    }
    
    public var wrappedValue: T {
        mutating get {
            if object == nil {
                object = resolver.resolve(T.self)
            }
            return object
        }
        mutating set { object = newValue  }
    }
    
    public var projectedValue: LazyInjected<T> {
        get { return self }
        mutating set { self = newValue }
    }
    
}
