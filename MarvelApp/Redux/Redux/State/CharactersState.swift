//
//  CharactersState.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import ReSwift
import MarvelDomain

protocol StateTypeCancellable {
    
    var cancelBag: Set<AnyCancellable> { get set }
    
}

public struct CharactersState: StateType, Equatable, StateTypeCancellable {
    
    var cancelBag = Set<AnyCancellable>()
    
    public var isLoading: Bool = false
    
    public var characters: [Character] = []
        
    public var paging = Paging(limit: 10, offset: 0)
    
}
