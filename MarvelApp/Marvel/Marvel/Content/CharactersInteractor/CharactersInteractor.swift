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
    
    func loadCharacters() {
        appState.dispatch(action: .characters(.loading))
        useCase
            .fetch(with: Paging(limit: 20, offset: 0))
            .map { AppState.Action.characters(.loaded($0)) }
            .catch { Just(AppState.Action.characters(.failed($0))) }
            .sink { appStore.dispatch(action: $0) }
            .store(in: &cancelBag)

    }
    
}

