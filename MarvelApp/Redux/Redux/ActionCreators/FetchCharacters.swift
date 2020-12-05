//
//  FetchCharacters.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation
import Combine
import ReSwift
import ReSwiftThunk
import Core
import MarvelUseCase

extension ActionCreators {
    
    public enum Characters {
        
        public static func fetch() -> Thunk<CharactersState> {
            return Thunk<CharactersState> { (dispatch, getState) in
                guard let state = getState() else { return }
                guard state.paging.canPaginate else { return }
                dispatch(CharactersAction.loading(true))
                let useCase = resolver.resolve(CharactersUseCase.self)!
                useCase
                    .fetch(with: state.paging)
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .replaceError(with: [])
                    .sink(
                        receiveCompletion: { (result) in
                            switch result {
                            case .failure(let error):
                                dispatch(CharactersAction.loading(false))
                                print(error.localizedDescription)
                            case .finished:
                                dispatch(CharactersAction.loading(false))
                            }
                        },
                        receiveValue: { (value) in
                            dispatch(CharactersAction.updatePagingOffset(value.count))
                            dispatch(CharactersAction.characters(value))
                        }
                    )
                    .store(by: dispatch)
            }
        }
        
    }
    
}
