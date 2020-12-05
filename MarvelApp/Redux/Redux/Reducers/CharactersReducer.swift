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
        case .characters(let characters):
            characters.forEach { (character) in
                if let index = state.characters.firstIndex(where: { $0.id == character.id }) {
                    state.characters[index] = character
                } else {
                    state.characters.append(character)
                }
            }
        case .paging(let value):
            state.paging = value
        case .loading(let value):
            state.isLoading = value
        case .updatePagingOffset(let value):
            state.paging.update(offset: value)
        }
    case let storeCancellableAction as CancellableAction:
        switch storeCancellableAction {
        case .store(let cancellable):
            cancellable.store(in: &state.cancelBag)
        }
    default:
        break
    }
    return state
}

