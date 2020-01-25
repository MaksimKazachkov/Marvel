//
//  Credentials.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public class Credentials {
    
    public let ts: Int
    
    public let publicKey: String
    
    public let privateKey: String
    
    public let hash: String?
    
    public init(
        ts: Int,
        publicKey: String,
        privateKey: String) {
        self.ts = ts
        self.publicKey = publicKey
        self.privateKey = privateKey
        let rawHash = "\(ts)\(privateKey)\(publicKey)"
        let encryptor = SHA256Encryptor()
        hash = encryptor.encrypt(hash: rawHash)
    }
    
}
