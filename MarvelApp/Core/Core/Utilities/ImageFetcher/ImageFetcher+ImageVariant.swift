//
//  ImageFetcher+ImageVariant.swift
//  Marvel
//
//  Created by Максим Казачков on 15.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public extension ImageFetcher {
    
    struct ImageVariant {
        
        public let url: URL
        
        public init(url: URL, aspectRation: AspectRationType) {
            self.url = url.appendingPathComponent(aspectRation.path)
        }
        
    }
    
}
