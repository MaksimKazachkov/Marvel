//
//  EncodingContainerTransformer.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

protocol DecodingContainerTransformer {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ decoded: Input) throws -> Output
    
}

protocol EncodingContainerTransformer {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ encoded: Output) throws -> Input
    
}

typealias CodableContainerTransformer = DecodingContainerTransformer & EncodingContainerTransformer

extension KeyedDecodingContainer {
    
    func decode<T: DecodingContainerTransformer>(
        _ key: KeyedDecodingContainer.Key,
        transformer: T) throws -> T.Output where T.Input: Decodable {
        let decoded: T.Input = try decode(key)
        
        return try transformer.transform(decoded)
    }
    
    func decode<T>(_ key:KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        return try decode(T.self, forKey: key)
    }
    
    func decodeIfPresent<T: DecodingContainerTransformer>(
        _ key: KeyedDecodingContainer.Key,
        transformer: T
    ) throws -> T.Output? where T.Input: Decodable {
        if let decoded: T.Input = try decodeIfPresent(key) {
            return try transformer.transform(decoded)
        } else {
            return nil
        }
    }
    
    func decodeIfPresent<T>(_ key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
        return try decodeIfPresent(T.self, forKey: key)
    }
    
}

extension KeyedEncodingContainer {
    
    mutating func encode<T: EncodingContainerTransformer>(
        _ value: T.Output,
        forKey key: KeyedEncodingContainer.Key,
        transformer: T
    ) throws where T.Input: Encodable {
        let transformed: T.Input = try transformer.transform(value)
        try encode(transformed, forKey: key)
    }
    
}
