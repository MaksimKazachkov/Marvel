//
//  CharactersRoute.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public enum CharactersRoute: Route {
    
    case characters(CharactersRO)
    
    public var method: HTTPMethod {
        switch self {
        case .characters:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        }
    }
    
    public var parameters: Self.Parameters? {
        switch self {
        case .characters:
            return nil
        }
    }
    
    public var data: Data? {
        switch self {
        case .characters(let model):
            return try? JSONEncoder().encode(model)
        }
    }
    
}
