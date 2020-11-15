//
//  ImageFetcher+AspectRatio.swift
//  Marvel
//
//  Created by Максим Казачков on 15.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public extension ImageFetcher {
    
    public enum AspectRationType {
        
        case portrait(ImageType), standard(ImageType), landscape(ImageType), detail, fullSize
        
        public var path: String {
            switch self {
            case .portrait(let value):
                return "portrait_\(value)"
            case .standard(let value):
                return "standard_\(value)"
            case .landscape(let value):
                return "landscape_\(value)"
            case .detail:
                return "detail"
            case .fullSize:
                return "fullSize"
            }
        }
        
    }
    
}
