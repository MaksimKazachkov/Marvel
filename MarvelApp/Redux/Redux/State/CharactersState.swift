//
//  CharactersState.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain
import ReSwift

public struct CharactersState: StateType, Equatable {
    
    public var isLoading: Bool = true
    
    public var characters: [Character] = []
        
    public var paging = Paging(limit: 20, offset: 0)
    
}
