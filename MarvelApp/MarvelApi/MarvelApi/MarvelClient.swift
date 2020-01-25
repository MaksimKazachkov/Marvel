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
    
    private let apiKey: String?
    
    private let configuration: URLSessionConfiguration = .default
    
    private let session: URLSession
    
    private let scheme: String
    
    private let host: String
    
    private let port: Int?
    
    public init(
        scheme: String,
        host: String,
        port: Int?,
        ts: Int,
        privateKey: String,
        publicKey: String) {
        self.scheme = scheme
        self.host = host
        self.port = port
        let hash = "\(ts)\(privateKey)\(publicKey)"
        let encryptor = SHA256Encryptor()
        apiKey = encryptor.encrypt(hash: hash)
        session = URLSession(configuration: configuration)
    }
    
    public func requestObject<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<T, Error> {
        do {
            let request = try prepare(route: route)
            return session.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: T.self, decoder: JSONNestedDecoder(keyPath: keyPath))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    public func requestObjects<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<[T], Error> {
        do {
            let request = try prepare(route: route)
            return session.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: [T].self, decoder: JSONNestedDecoder(keyPath: keyPath))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
}

private extension MarvelClient {
    
    func prepare(route: Route) throws -> URLRequest {
        let components = makeURLComponents(for: route)
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = route.data
        
        return URLRequest(url: url)
    }
    
    func makeURLComponents(for route: Route) -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.queryItems = makeQueryItems(from: route.parameters)
        
        return components
    }
    
    func makeQueryItems(from parameters: Route.Parameters?) -> [URLQueryItem]? {
        return parameters?.compactMap({ URLQueryItem(name: $0.key, value: $0.value.description) })
    }
    
}
