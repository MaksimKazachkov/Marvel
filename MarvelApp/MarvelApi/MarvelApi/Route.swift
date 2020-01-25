//
//  Routable.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public protocol Route {
    
    typealias Parameters = [String: CustomStringConvertible]
            
    var method: HTTPMethod { get }
    
    var path: String { get }
    
    var parameters: Parameters? { get }
    
    var data: Data? { get }
    
}
