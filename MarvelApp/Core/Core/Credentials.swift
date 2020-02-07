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
    
}
