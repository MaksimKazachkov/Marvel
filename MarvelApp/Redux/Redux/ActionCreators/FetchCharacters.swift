//
//  FetchCharacters.swift
//  Redux
//
//  Created by Максим Казачков on 14.11.2020.
//

import Foundation
import Combine
import MarvelUseCase
import Core
import ReSwift
import ReSwiftThunk

extension ActionCreators {
    
    public class Characters {
        
        private lazy var cancelBag = Set<AnyCancellable>()
        
        public init() {}
        
        public func fetch() -> Thunk<CharactersState> {
            return Thunk<CharactersState> { [weak self] (dispatch, getState) in
                guard let self = self else { return }
                guard let state = getState() else { return }
                guard state.paging.canPaginate else { return }
                dispatch(CharactersAction.loading(true))
                let useCase = resolver.resolve(CharactersUseCase.self)!
                useCase
                    .fetch(with: state.paging)
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .handleEvents(receiveOutput: { (output) in
                        dispatch(CharactersAction.updatePagingOffset(output.count))
                    })
                    .map { CharactersAction.characters($0) }
                    .replaceError(with: CharactersAction.characters([]))
                    .print()
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
                        receiveValue: { (action) in
                            dispatch(action)
                        }
                    )
                    .store(in: &self.cancelBag)
            }
        }
    
    }
}

//extension Store {
//
//    func dispatchObservable(_ callbackActionCreator: @escaping (@escaping () -> Void) -> (State, Store<State>) -> Action?) -> Future<State> {
//        return Observable.create({ observer in
//            let actionCreator = callbackActionCreator({
//                observer.onNext(self.state)
//                observer.onCompleted()
//            })
//
//            self.dispatch(actionCreator)
//
//            return Disposables.create()
//        })
//    }
//
//}
