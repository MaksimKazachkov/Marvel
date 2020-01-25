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
        
    func requestObject<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<T, Error>
    func requestObjects<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<[T], Error>
    func request(route: Route, at keyPath: String) -> AnyPublisher<(), Error>
    
}
