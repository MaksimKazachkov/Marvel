//
//  ContentViewContainer.swift
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

struct CharactersViewContainer: EnvironmentKey {
    
    let charactersInteractor: CharactersInteractorType
    
    init(charactersInteractor: CharactersInteractorType) {
        self.charactersInteractor = charactersInteractor
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(
        charactersInteractor: resolver.resolve(CharactersInteractorType.self)!
    )
    
}

extension EnvironmentValues {
    var contentViewContainer: CharactersViewContainer {
        get { self[CharactersViewContainer.self] }
        set { self[CharactersViewContainer.self] = newValue }
    }
}
