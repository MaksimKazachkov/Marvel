//
//  CharactersInteractor.swift
//  Marvel
//
//  Created by Максим Казачков on 16.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import MarvelUseCase
import MarvelDomain
import Redux
import Core

class CharactersInteractor: CharactersInteractorType {
    
    let useCase: CharactersUseCase
    let store: StoreWrapper<CharactersState>
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(useCase: CharactersUseCase, store: StoreWrapper<CharactersState>) {
        self.useCase = useCase
        self.store = store
    }
    
    func fetchCharacters() {
        useCase
            .fetch(with: store.state.paging)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] (value) in
                guard let self = self else { return }
                let canPaginate = value.count == self.store.state.paging.limit
                self.store.dispatch(CharactersAction.canPaginate(false))
            })
            .map { CharactersAction.characters($0) }
            .catch { _ in Just(CharactersAction.characters([])) }
            .sink { self.store.dispatch($0) }
            .store(in: &cancelBag)
        
    }
    
}

