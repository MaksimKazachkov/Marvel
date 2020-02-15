//
//  MarvelClient.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 24.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import Core

public class MarvelClient: Client {
    
    private let configuration: URLSessionConfiguration = .default
    
    private let session: URLSession
    
    private let credentials: Credentials
        
    private let constructor: URLRequestConstructor
    
    public init(
        credentials: Credentials,
        constructor: URLRequestConstructor
    ) {
        self.credentials = credentials
        self.constructor = constructor
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    public func requestObject<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<T, Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .tryMap({ try validate(data: $0.data, response: $0.response) })
                .decode(type: T.self, decoder: JSONNestedDecoder(keyPath: keyPath))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    public func requestObjects<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<[T], Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .tryMap({ try validate(data: $0.data, response: $0.response) })
                .decode(type: [T].self, decoder: JSONNestedDecoder(keyPath: keyPath))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    public func requestData(route: Route) -> AnyPublisher<Data, Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .tryMap({ try validate(data: $0.data, response: $0.response) })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    public func request(route: Route) -> AnyPublisher<(), Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .tryMap({ try validate(data: $0.data, response: $0.response) })
                .map({ _ in return Void() })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
}

private extension Client {

    func makeQueryItems(from credentials: Credentials) throws -> [URLQueryItem] {
        guard let hash = credentials.hash else {
            throw URLError(.fileDoesNotExist)
        }
        return [
            URLQueryItem(name: "ts", value: credentials.ts.description),
            URLQueryItem(name: "apikey", value: credentials.publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
    }
    
}
