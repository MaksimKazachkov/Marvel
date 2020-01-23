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
        
    private let ts: Int
    
    private let privateKey: String
    
    private let publicKey: String
    
    lazy var hash: String? = {
        let encryptor = SHA256Encryptor()
        let rawHash = "\(ts)\(privateKey)\(publicKey)"
        return encryptor.encrypt(rawHash: rawHash)
    }()
    
    public init(
        baseURL: String,
        ts: Int,
        privateKey: String,
        publicKey: String) {
        self.ts = ts
        self.privateKey = privateKey
        self.publicKey = publicKey
    }
    
    public func makeRequestObject<Codable>(route: Route, at keyPath: String) -> Future<Codable, ApiError> {
        return Future { (promise) in
            // TODO: - implement logic
        }
    }
    
    public func makeRequest<Codable>(route: Route, at keyPath: String) -> Future<[Codable], ApiError> {
        return Future { (promise) in
            // TODO: - implement logic
        }
    }
    
    public func makeRequestVoid(route: Route) -> Future<Void, ApiError> {
        return Future { (promise) in
            // TODO: - implement logic
        }
    }
    
    public func makeRequestAny(route: Route) -> Future<Any, ApiError> {
        return Future { (promise) in
            // TODO: - implement logic
        }
    }
    
}
