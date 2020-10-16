//
//  ObjectTypeAction.swift
//  Redux
//
//  Created by Максим Казачков on 16.10.2020.
//

import Foundation

public enum ObjectTypeAction<Value, Error: Swift.Error>: ActionType {
    
    case idle
    case loading
    case loaded(Value)
    case failed(Error)
    
    var objectType: ObjectType<Value, Error> {
        switch self {
        case .idle:
            return .idle
        case .loading:
            return .loading
        case .loaded(let value):
            return .loaded(value)
        case .failed(let error):
            return .failed(error)
        }
    }
    
}
