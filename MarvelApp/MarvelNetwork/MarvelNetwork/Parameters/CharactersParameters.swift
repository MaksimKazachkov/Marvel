//
//  CharactersParameters.swift
//  MarvelNetwork
//
//  Created by Максим Казачков on 16.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

public struct CharactersParameters {
    
    let paging: Paging
    
    let orderBy: String
    
    public enum OrderBy: String {
        case name, modified
    }
    
    public init(paging: Paging, orderBy: OrderBy, accending: Bool = true) {
        self.paging = paging
        self.orderBy = accending ? orderBy.rawValue : "-".appending(orderBy.rawValue)
    }
    
}
