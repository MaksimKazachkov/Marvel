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
    
    public private(set) var canPaginate: Bool = true
    
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
        
    mutating public func update(offset: Int) {
        self.offset += offset
        self.canPaginate = offset == limit
    }
    
}
