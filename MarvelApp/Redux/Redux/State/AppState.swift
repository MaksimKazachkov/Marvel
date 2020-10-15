//
//  AppState.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct AppState: StateType {
    
    public func reducer(state: AppState, action: Action) -> AppState {
        var state = state
        switch action {
        case .some:
            break
        }
        return state
    }
    
    public init() {}
    
    public enum Action: ActionType {
        
        case some
                
    }

    
}
