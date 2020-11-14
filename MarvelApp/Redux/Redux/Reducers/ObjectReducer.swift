//
//  ObjectReducer.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation

public func objectReducer<Value, Error: Swift.Error>(action: ObjectAction<Value, Error>) -> ObjectState<Value, Error> {
    switch action {
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
