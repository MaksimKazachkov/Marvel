//
//  Error.swift
//  Network
//
//  Created by Maksim Kazachkov on 25.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

indirect public enum Error: Swift.Error {
    
    case decode(DecodingError)
    case url(URLError)
    case undefined(Swift.Error)
    
    static public func create(_ error: Swift.Error) -> Error {
        if let error = error as? DecodingError {
            return .decode(error)
        } else if let error = error as? URLError {
            return .url(error)
        } else {
            return .undefined(error)
        }
    }
    
}
