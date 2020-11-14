//
//  Thumbnail.swift
//  MarvelDomain
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Image: Equatable {
    
    public enum ExtensionType: String, Equatable {
        
        case jpg, png, gif

        public init(rawValue: String) {
            switch rawValue {
            case "jpg":
                self = .jpg
            case "png":
                self = .png
            case "gif":
                self = .gif
            default:
                self = .jpg
            }
        }
        
    }
    
    public let path: String
    
    public let extensionType: ExtensionType
    
    public init(
        path: String,
        extensionType: ExtensionType
    ) {
        self.path = path
        self.extensionType = extensionType
    }
    
}

