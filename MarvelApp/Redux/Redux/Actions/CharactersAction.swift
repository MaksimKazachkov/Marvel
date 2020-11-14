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

    case characters([Character])
    case canPaginate(Bool)
    case paging(Paging)

}
