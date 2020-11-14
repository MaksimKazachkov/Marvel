//
//  Paging.swift
//  MarvelDomain
//
//  Created by Максим Казачков on 25.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Paging: Equatable {
    
    public private(set) var limit: Int
    
    public private(set) var offset: Int
    
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
        
    mutating func updateOffset() {
        offset += limit
    }
    
}
