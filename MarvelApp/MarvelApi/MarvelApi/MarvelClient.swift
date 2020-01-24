//
//  MarvelClient.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 24.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

public class MarvelClient: Client {
    
    private let hash: String?
    
    private let session: URLSession = .shared
    
    public init(
        baseURL: String,
        ts: Int,
        privateKey: String,
        publicKey: String) {
        let rawHash = "\(ts)\(privateKey)\(publicKey)"
        let encryptor = SHA256Encryptor()
        hash = encryptor.encrypt(rawHash: rawHash)
    }
    
    public func requestObject<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<T, Error> {
        let request = prepare(route: route)
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONNestedDecoder(keyPath: keyPath))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    public func requestObjects<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<[T], Error> {
        let request = prepare(route: route)
        return session.dataTaskPublisher(for: request)
        .map(\.data)
        .decode(type: [T].self, decoder: JSONNestedDecoder(keyPath: keyPath))
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    public func request(route: Route) -> AnyPublisher<Void, Error> {
        let request = prepare(route: route)
                return Future { (promise) in
            // TODO: - implement logic
        }.eraseToAnyPublisher()
    }
    
    public func requestAny(route: Route) -> AnyPublisher<Any, Error> {
        let request = prepare(route: route)
        return Future { (promise) in
            // TODO: - implement logic
        }.eraseToAnyPublisher()
    }
    
}

private extension MarvelClient {
    
    func prepare(route: Route) -> URLRequest {
        var urlRequest = route.asURLRequest()
        if let hash = hash {
            urlRequest.url?.appendPathComponent(hash)
        }
        return urlRequest
    }
    
}
