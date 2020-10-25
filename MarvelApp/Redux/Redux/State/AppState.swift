//
//  AppState.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

public struct AppState: StateType {
    
    public var characters: [Character] = []
        
    public var paging = Paging(limit: 20, offset: 0)
    
    public var canPaginate: Bool = false
        
    public func reducer(state: AppState, action: Action) -> AppState {
        var state = state
        switch action {
        case .setCharacters(let data):
            state.characters.append(contentsOf: data)
        case .setCanPaginate(let value):
            state.canPaginate = value
        case .setPaging(let value):
            break
//            state.paging = value
        }
        return state
    }
    
    public init() {}
    
    public enum Action: ActionType {
        
        case setCharacters([Character])
        case setCanPaginate(Bool)
        case setPaging(Paging)
                
    }

}
