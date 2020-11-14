//
//  FetchCharactersAction.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation
import Combine
import ReSwift
import MarvelUseCase
import Core

private var cancelBag = Set<AnyCancellable>()

public func fetchCharacters(state: CharactersState, store: StoreWrapper<CharactersState>) -> Action? {
    let useCase = resolver.resolve(CharactersUseCase.self)!
    useCase
        .fetch(with: store.state.paging)
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveOutput: { (value) in
            let canPaginate = value.count == store.state.paging.limit
            store.dispatch(CharactersAction.canPaginate(canPaginate))
        })
        .map { CharactersAction.characters($0) }
        .catch { _ in Just(CharactersAction.characters([])) }
        .sink { store.dispatch($0) }
        .store(in: &cancelBag)
    
    return nil
}
