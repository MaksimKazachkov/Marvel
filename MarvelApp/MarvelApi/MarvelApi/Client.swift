//
//  Client.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

public protocol Client {
        
    func makeRequestObject<Codable>(route: Route, at keyPath: String) -> Future<Codable, ApiError>
    func makeRequest<Codable>(route: Route, at keyPath: String) -> Future<[Codable], ApiError>
    func makeRequestVoid(route: Route) -> Future<Void, ApiError>
    func makeRequestAny(route: Route) -> Future<Any, ApiError>
    
}
