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

struct ContentViewContainer: EnvironmentKey {
    
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
    var contentViewContainer: ContentViewContainer {
        get { self[ContentViewContainer.self] }
        set { self[ContentViewContainer.self] = newValue }
    }
}
