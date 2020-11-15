//
//  StoreWrapper.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import SwiftUI
import ReSwift

public final class StoreWrapper<T: StateType>: ObservableObject, StoreSubscriber {
    
    @Published public private(set) var state: T
    
    private let store: Store<T>
    
    public init(store: Store<T>) {
        self.store = store
        self.state = store.state
        
        store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    public func dispatch(_ action: Action) {
        store.dispatch(action)
    }
    
    public func newState(state: T) {
        DispatchQueue.main.async {
            self.state = state
        }
    }
    
}
