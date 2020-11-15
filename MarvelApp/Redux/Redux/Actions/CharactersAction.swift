//
//  CharactersAction.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation
import MarvelDomain
import ReSwift

public enum CharactersAction: Action {

    case loading(Bool)
    case paging(Paging)
    case updatePagingOffset(Int)
    case characters([Character])

}
