//
//  DateTransformer.swift
//  MarvelNetwork
//
//  Created by Максим Казачков on 16.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

struct DateTransformer: DecodingContainerTransformer {
    
    enum Error: Swift.Error, CustomDebugStringConvertible {
        
        case canNotCreateDate(decoded: String, dateFormat: DateFormat)
        
        var debugDescription: String {
            switch self {
            case .canNotCreateDate(let decoded, let dateFormat):
                return "Can't create date from \(decoded) with dateFormat: \(dateFormat)"
            }
        }
        
    }
    
    typealias Input = String
    typealias Output = Date
    
    enum DateFormat: String {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    let dateFormat: DateFormat
    
    func transform(_ decoded: String) throws -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat.rawValue
        guard let date = formatter.date(from: decoded) else {
            throw Error.canNotCreateDate(
                decoded: decoded,
                dateFormat: dateFormat
            )
        }
        return date
    }
    
}
