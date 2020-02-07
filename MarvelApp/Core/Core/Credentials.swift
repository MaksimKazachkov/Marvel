//
//  Credentials.swift
//  Core
//
//  Created by Maksim Kazachkov on 07.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public class Credentials: Codable {
    
    public let ts: Int
    
    public let privateKey: String
    
    public let publicKey: String
    
    public lazy var hash: String? = {
        let rawHash = "\(ts)\(privateKey)\(publicKey)"
        let encryptor = MD5Encryptor()
        return encryptor.encrypt(hash: rawHash)
    }()
    
    enum CodingKeys: String, CodingKey {
        
        case ts, privateKey, publicKey
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tsString = try container.decode(String.self, forKey: .ts)
        ts = Int(tsString)!
        privateKey = try container.decode(String.self, forKey: .privateKey)
        publicKey = try container.decode(String.self, forKey: .publicKey)
    }
    
}
