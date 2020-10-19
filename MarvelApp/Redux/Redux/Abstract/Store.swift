//
//  AppStore.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import SwiftUI

public final class Store<T: StateType>: ObservableObject, DispatchingStoreType {
    
    @Published public private(set) var state: T
    
    public init(state: T = T()) {
        self.state = state
    }
    
    public func dispatch(action: T.Action) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.state = self.state.reducer(state: self.state, action: action)
        }
    }
    
}
