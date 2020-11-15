//
//  CharactersMiddleware.swift
//  Redux
//
//  Created by Максим Казачков on 15.11.2020.
//

import Foundation
import ReSwift
import ReSwiftThunk

let charactersMiddleware: Middleware<CharactersState> = createThunkMiddleware()
