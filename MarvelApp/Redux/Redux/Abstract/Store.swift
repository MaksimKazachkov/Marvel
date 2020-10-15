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
    
    @Published private(set) var state: T
    
    public init(state: T = T()) {
        self.state = state
    }
    
    public func dispatch(action: T.Action) {
        state = state.reducer(state: state, action: action)
    }
    
}
