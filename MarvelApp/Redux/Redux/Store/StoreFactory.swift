//
//  AppStore.swift
//  Redux
//
//  Created by Максим Казачков on 15.10.2020.
//

import Foundation
import ReSwift

public let charactersStore = StoreWrapper<CharactersState>(
    store: Store<CharactersState>(
        reducer: charactersReducer,
        state: nil,
        middleware: [charactersMiddleware],
        automaticallySkipsRepeats: true
    )
)
