//
//  ImageClient.swift
//  MarvelNetwork
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import CoreNetwork

public class ImageClient: CoreNetwork.ImageClient {
        
    private let configuration: URLSessionConfiguration = {
        let config: URLSessionConfiguration = .default
        
        config.urlCache = URLCache(
            memoryCapacity: 50 * 1024,
            diskCapacity: 50 * 1024
        )

        config.httpMaximumConnectionsPerHost = 5

        return config
    }()
    
    private lazy var session: URLSession = {
       return URLSession(configuration: configuration)
    }()
    
    public func image(for url: URL) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError({ CoreNetwork.Error.create($0) })
            .eraseToAnyPublisher()
    }
    
}
