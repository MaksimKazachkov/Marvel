//
//  Configuration.swift
//  Core
//
//  Created by Maksim Kazachkov on 07.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Configuration: Codable {
    
    public let scheme: String
    
    public let host: String
    
    public let port: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case port, scheme, host
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scheme = try container.decode(String.self, forKey: .scheme)
        host = try container.decode(String.self, forKey: .host)
        if let portString = try container.decodeIfPresent(String.self, forKey: .port) {
            port = Int(portString)
        } else {
            port = nil
        }
    }
    
}
