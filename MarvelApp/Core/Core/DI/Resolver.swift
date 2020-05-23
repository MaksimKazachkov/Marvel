//
//  Resolver.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public protocol Resolver {
    
    func resolve<T>(_ serviceType: T.Type) -> T?

}
