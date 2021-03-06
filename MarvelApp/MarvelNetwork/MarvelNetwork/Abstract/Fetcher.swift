//
//  Client.swift
//  MarvelNetwork
//
//  Created by Maksim Kazachkov on 02.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

public protocol Fetcher {
        
    func requestObject<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<T, Error>
    func requestObjects<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<[T], Error>
    func requestData(route: Route) -> AnyPublisher<Data, Error>
    func request(route: Route) -> AnyPublisher<Void, Error>

}
