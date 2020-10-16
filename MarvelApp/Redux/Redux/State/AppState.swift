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
    
    public var characters: ObjectType<[Character], Swift.Error> = .idle
        
    public func reducer(state: AppState, action: Action) -> AppState {
        var state = state
        switch action {
        case .characters(let action):
            state.characters = action.objectType
        }
        return state
    }
    
    public init() {}
    
    public enum Action: ActionType {
        
        case characters(ObjectTypeAction<[Character], Swift.Error>)
                
    }

}
