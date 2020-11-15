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
        case .paging(let value):
            state.paging = value
        case .loading(let value):
            state.isLoading = value
        case .updatePagingOffset(let value):
            state.paging.update(offset: value)
        }
    default:
        break
    }
    return state
}
