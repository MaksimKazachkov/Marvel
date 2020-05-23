//
//  Assembler.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

protocol Assembler {
    
    associatedtype T
    
    func resolve() throws -> T
    
}
