//
//  ObjectState.swift
//  Redux
//
//  Created by Максим Казачков on 16.10.2020.
//

import Foundation

/// For non paginated object
public enum ObjectState<Value, Error: Swift.Error> {
    
    case idle
    case loading
    case loaded(Value)
    case failed(Error)
    
    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    public var value: Value? {
        switch self {
        case let .loaded(value):
            return value
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case let .failed(value):
            return value
        default:
            return nil
        }
    }
    
}
