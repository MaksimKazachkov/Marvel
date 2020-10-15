//
//  DispatchingStoreType.swift
//  Redux
//
//  Created by Максим Казачков on 15.10.2020.
//

import Foundation

protocol DispatchingStoreType {
    
    associatedtype T: StateType

    func dispatch(action: T.Action)
}
