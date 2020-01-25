//
//  MarvelClient.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 24.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import Network

public class Client: Network.Client {
    
    private let configuration: URLSessionConfiguration = .default
    
    private let session: URLSession
    
    private let credentials: Credentials
        
    private let constructor: URLRequestConstructor
    
    public init(
        constructor: URLRequestConstructor,
        credentials: Credentials) {
        self.constructor = constructor
        self.credentials = credentials
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    public func requestObject<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<T, Network.Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .mapError({ Network.Error.create($0) })
                .map(\.data)
                .decode(type: T.self, decoder: JSONNestedDecoder(keyPath: keyPath))
                .mapError({ Network.Error.create($0) })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .mapError({ Network.Error.create($0) })
                .eraseToAnyPublisher()
        }
    }
    
    public func requestObjects<T: Codable>(route: Route, at keyPath: String) -> AnyPublisher<[T], Network.Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .mapError({ Network.Error.create($0) })
                .map(\.data)
                .decode(type: [T].self, decoder: JSONNestedDecoder(keyPath: keyPath))
                .mapError({ Network.Error.create($0) })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .mapError({ Network.Error.create($0) })
                .eraseToAnyPublisher()
        }
    }
    
    public func request(route: Route, at keyPath: String) -> AnyPublisher<(), Network.Error> {
        do {
            let request = try constructor.asURLRequest(route: route, with: makeQueryItems(from: credentials))
            return session.dataTaskPublisher(for: request)
                .mapError({ Network.Error.create($0) })
                .map({ _ in return Void() })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .mapError({ Network.Error.create($0) })
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
