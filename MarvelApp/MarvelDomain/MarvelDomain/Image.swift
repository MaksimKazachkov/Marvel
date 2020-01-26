//
//  Thumbnail.swift
//  MarvelDomain
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Image {
    
    public enum ExtensionType: String {
        
        case jpg, png, gif
        
        public init(rawValue: String) {
            self = ExtensionType(rawValue: rawValue)
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

