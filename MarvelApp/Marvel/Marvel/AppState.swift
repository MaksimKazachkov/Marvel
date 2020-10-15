//
//  AppState.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

struct AppState: StateType {
    
    func reducer(state: AppState, action: Action) -> AppState {
        var state = state
        switch action {
        case .some:
            break
        }
        return state
    }
    
    
    enum Action: ActionType {
        
        case some
        
        var asAction: AppState.Action {
            return self
        }
                
    }

    
}
