//
//  Resource.swift
//  MarvelDomain
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Resource: Equatable {
    
    // The number of total available resources in this list
    public let available: Int?
    
    // The number of resources returned in this resource list (up to 20).
    public let returned: Int?
    
    // The number of resources returned in this resource list (up to 20).
    public let collectionURI: URL?
    
    // A list of summary views of the items in this resource list.
    public let items: [Item]?
    
    public struct Item: Equatable {
        
        public let name: String?
        
        public let resourceURI: URL?
        
        public init(
            name: String?,
            resourceURI: URL?
        ) {
            self.name = name
            self.resourceURI = resourceURI
        }
        
    }
    
    public init(
        available: Int?,
        returned: Int?,
        collectionURI: URL?,
        items: [Item]?
    ) {
        self.available = available
        self.returned = returned
        self.collectionURI = collectionURI
        self.items = items
    }
    
}
