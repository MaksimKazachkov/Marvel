//
//  URLType.swift
//  MarvelDomain
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct URLType: Equatable {
    
    // A text identifier for the URL.
    public let type: String?
    
    // A full URL (including scheme, domain, and path).
    public let url: URL?
    
    public init(
        type: String?,
        url: URL?
    ) {
        self.type = type
        self.url = url
    }
    
}
