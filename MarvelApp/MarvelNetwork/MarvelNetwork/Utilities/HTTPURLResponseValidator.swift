//
//  HTTPURLResponseValidator.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

func validate(data: Data, response: URLResponse) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw URLError(.unknown)
    }
    guard (200..<300).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    
    return data
}
