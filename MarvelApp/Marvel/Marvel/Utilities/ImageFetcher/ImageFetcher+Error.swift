//
//  ImageFetcher+Error.swift
//  Marvel
//
//  Created by Максим Казачков on 15.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public extension ImageFetcher {
    
    enum Error: Swift.Error, CustomDebugStringConvertible {
        
        case incorrectData, badURL, noImageInCache
        
        public var debugDescription: String {
            switch self {
            case .incorrectData:
                return "Data is currupt"
            case .badURL:
                return "Can not create url"
            case .noImageInCache:
                return "Image is not stored in cache"
            }
        }
        
    }
    
}
