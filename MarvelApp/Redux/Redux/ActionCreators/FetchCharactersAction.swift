//
//  FetchCharactersAction.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation
import Combine
import MarvelUseCase
import Core
import ReSwift
import ReSwiftThunk

private var cancelBag = Set<AnyCancellable>()

public let fetchCharactersAction = Thunk<CharactersState> { (dispatch, getState) in
    guard let state = getState() else { return }
    let useCase = resolver.resolve(CharactersUseCase.self)!
    useCase
        .fetch(with: state.paging)
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveOutput: { (value) in
            let canPaginate = value.count == state.paging.limit
            dispatch(CharactersAction.canPaginate(canPaginate))
        })
        .map { CharactersAction.characters($0) }
        .catch { _ in Just(CharactersAction.characters([])) }
        .sink { dispatch($0) }
        .store(in: &cancelBag)
}
