//
//  ObjectAction.swift
//  Redux
//
//  Created by Максим Казачков on 16.10.2020.
//

import Foundation
import ReSwift

public enum ObjectAction<Value, Error: Swift.Error>: Action {
    
    case idle
    case loading
    case loaded(Value)
    case failed(Error)
    
}
