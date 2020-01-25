//
//  String+Encryption.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 24.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CommonCrypto

class MD5Encryptor {
    func encrypt(hash: String) -> String? {
        let data = Data(hash.utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
