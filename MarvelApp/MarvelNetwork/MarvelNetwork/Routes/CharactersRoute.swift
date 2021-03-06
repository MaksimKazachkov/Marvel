//
//  CharactersRoute.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

public enum CharactersRoute: Route {
    
    case characters(CharactersParameters)
    
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
    
    public var headers: Self.Headers? {
        return nil
    }
    
    public var queryParameters: Self.Parameters? {
        switch self {
        case .characters(let query):
            return [
                "limit": query.paging.limit,
                "offset": query.paging.offset,
                "orderBy": query.orderBy
            ]
        }
    }
    
    public var body: Data? {
        return nil
    }
    
}
