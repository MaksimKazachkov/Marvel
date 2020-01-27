//
//  ServerError.swift
//  Network
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct ServerError: Codable {
 
    
    
}

public func decodeServerError(data: Data) throws -> ServerError {
    let decoder = JSONDecoder()
    return try decoder.decode(ServerError.self, from: data)
}
