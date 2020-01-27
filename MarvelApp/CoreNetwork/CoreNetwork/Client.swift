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
    func requestObjects<T: Codable>(_ type: T.Type, route: Route, at keyPath: String) -> AnyPublisher<[T], Error>
    func requestData(route: Route) -> AnyPublisher<Data, Error>
    func request(route: Route) -> AnyPublisher<(), Error>

}