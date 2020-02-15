//
//  URLRequestConstructor.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Core

public struct URLRequestConstructor {
    
    public let configuration: Configuration
    
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    public func asURLRequest(route: Route) throws -> URLRequest {
        let components = makeURLComponents(for: route)
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = route.data
        
        return URLRequest(url: url)
    }
    
    
    public func asURLRequest(route: Route, with additionalURLQueryItems: [URLQueryItem]) throws -> URLRequest {
        var components = makeURLComponents(for: route)
        
        if var queryItems = components.queryItems {
            queryItems.append(contentsOf: additionalURLQueryItems)
            components.queryItems = queryItems
        } else {
            components.queryItems = additionalURLQueryItems
        }
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = route.data
        
        return URLRequest(url: url)
    }
    
    public func makeURLComponents(for route: Route) -> URLComponents {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.port = configuration.port
        components.path = route.path
        components.queryItems = makeQueryItems(from: route.parameters)
        
        return components
    }
    
    private func makeQueryItems(from parameters: Route.Parameters?) -> [URLQueryItem]? {
        return parameters?.compactMap({ URLQueryItem(name: $0.key, value: $0.value.description) })
    }
    
}
