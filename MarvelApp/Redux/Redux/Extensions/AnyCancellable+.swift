//
//  AnyCancellable+.swift
//  Redux
//
//  Created by Maksim Kazachkov on 05.12.2020.
//

import Foundation
import Combine
import ReSwift

public extension AnyCancellable {

    func store(by dispatch: @escaping DispatchFunction) {
        dispatch(CancellableAction.store(self))
    }
    
}
