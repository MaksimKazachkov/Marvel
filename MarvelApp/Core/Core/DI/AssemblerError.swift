//
//  Error.swift
//  Core
//
//  Created by Maksim Kazachkov on 23.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

enum AssemblerError: Swift.Error, CustomDebugStringConvertible {
    
    case nilBundleIdentifier(String)
    case nilInfoDictionary(String)
    
    var debugDescription: String {
        switch self {
        case .nilBundleIdentifier(let key):
            return "Can not create bundle identifier: \(key)"
        case .nilInfoDictionary(let key):
            return "Can not create info dictionary: \(key)"
        }
    }
    
}
