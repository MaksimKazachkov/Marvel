//
//  CharactersReducer.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation
import ReSwift

public func charactersReducer(action: Action, state: CharactersState?) -> CharactersState {
    var state = state ?? CharactersState()    
    switch action {
    case let charactersActions as CharactersAction:
        switch charactersActions {
        case .characters(let data):
            state.characters.append(contentsOf: data)
        case .canPaginate(let value):
            state.canPaginate = value
        case .paging(let value):
            break
        }
    default:
        break
    }
    return state
}
