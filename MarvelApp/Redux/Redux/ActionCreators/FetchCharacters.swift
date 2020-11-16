//
//  FetchCharacters.swift
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

public let fetchCharacters = Thunk<CharactersState> { (dispatch, getState) in
    guard let state = getState() else { return }
    guard state.paging.canPaginate else { return }
    dispatch(CharactersAction.loading(true))
    let useCase = resolver.resolve(CharactersUseCase.self)!
    useCase
        .fetch(with: state.paging)
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveOutput: { (output) in
            dispatch(CharactersAction.updatePagingOffset(output.count))
        })
        .map { CharactersAction.characters($0) }
        .catch { _ in Just(CharactersAction.characters([])) }
        .sink(
            receiveCompletion: { (result) in
                switch result {
                case .failure(let error):
                    dispatch(CharactersAction.loading(false))
                case .finished:
                    dispatch(CharactersAction.loading(false))
                }
            },
            receiveValue: { (action) in
                dispatch(action)
            }
        )
        .store(in: &cancelBag)
}