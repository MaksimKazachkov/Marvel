//
//  Injected.swift
//  Core
//
//  Created by Maksim Kazachkov on 06.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Injected<Dependency> {
    
    private var dependency: Dependency?
    
    
    
}
