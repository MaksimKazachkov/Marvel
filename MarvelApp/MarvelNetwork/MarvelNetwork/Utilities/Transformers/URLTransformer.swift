//
//  URLTransformer.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

struct URLTransformer: DecodingContainerTransformer {
    
    typealias Input = String
    typealias Output = URL
    
    func transform(_ decoded: String) throws -> URL {
        guard let url = URL(string: decoded) else {
            throw URLError(.badURL)
        }
        return url
    }
    
}
