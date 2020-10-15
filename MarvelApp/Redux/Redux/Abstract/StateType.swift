//
//  StateType.swift
//  Marvel
//
//  Created by Максим Казачков on 15.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public protocol StateType {
        
    associatedtype Action: ActionType
    
    func reducer(state: Self, action: Action) -> Self
    
    init()
    
}
