//
//  CancellableAction.swift
//  Redux
//
//  Created by Maksim Kazachkov on 05.12.2020.
//

import Foundation
import Combine
import ReSwift

enum CancellableAction: Action {
    
    case store(AnyCancellable)
    
}
