//
//  CharactersRoute.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreNetwork

enum CharactersRoute: Route {
    
    case characters
    
    var method: HTTPMethod {
        switch self {
        case .characters:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        }
    }
    
    var parameters: Self.Parameters? {
        switch self {
        case .characters:
            return nil
        }
    }
    
    var data: Data? {
        switch self {
        case .characters:
            return nil
        }
    }
    
}
