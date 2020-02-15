//
//  DAOError.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 16.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

enum DAOError: Error, CustomDebugStringConvertible {
    
    case nilUID
    
    case badFetchRequest(uid: String)
    
    var debugDescription: String {
        switch self {
        case .nilUID:
            return "Can not perform operation for entity with nil uid"
        case .badFetchRequest(let uid):
            return "Can not create fetchRequest by uid: \(uid)"
        }
    }
    
}
