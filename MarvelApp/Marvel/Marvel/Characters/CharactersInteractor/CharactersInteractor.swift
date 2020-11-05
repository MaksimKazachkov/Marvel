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
    let appState: Store<AppState>
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(useCase: CharactersUseCase, appState: Store<AppState>) {
        self.useCase = useCase
        self.appState = appState
    }
    
    func fetchCharacters() {
        useCase
            .fetch(with: appState.state.paging)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] (value) in
                guard let self = self else { return }
                let canPaginate = value.count == self.appState.state.paging.limit
                self.appState.dispatch(action: .setCanPaginate(false))
            })
            .map { AppState.Action.setCharacters($0) }
            .catch { _ in Just(AppState.Action.setCharacters([])) }
            .sink { appStore.dispatch(action: $0) }
            .store(in: &cancelBag)
        
    }
    
}

