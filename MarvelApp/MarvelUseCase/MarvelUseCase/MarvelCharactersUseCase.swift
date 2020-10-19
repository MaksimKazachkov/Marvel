//
//  MarvelCharactersUseCase.swift
//  MarvelUseCase
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine
import MarvelDomain
import MarvelNetworkRepository
import MarvelCoreDataRepository
import Core
import CoreData

public struct MarvelCharactersUseCase: CharactersUseCase {
    
    private let networkRepository: CharactersRepository
    
    private let coreDataRepository: CoreDataRepository<MarvelDomain.Character>
    
    public init(
        networkRepository: CharactersRepository,
        coreDataRepository: CoreDataRepository<MarvelDomain.Character>
    ) {
        self.networkRepository = networkRepository
        self.coreDataRepository = coreDataRepository
    }
    
    public func fetch(with paging: Paging) -> AnyPublisher<[MarvelDomain.Character], Swift.Error> {
        return Publishers.Merge(
            persistencePublisher(with: paging),
            networkPublisher(with: paging)
                .flatMap({ self.savePublisher(data: $0) }).print()
                .eraseToAnyPublisher()
        )
//        return persistencePublisher(with: paging)
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func persistencePublisher(with paging: Paging) -> AnyPublisher<[MarvelDomain.Character], Swift.Error> {
        return Future { (promise) in
            do {
                let request: NSFetchRequest<NSFetchRequestResult> = MarvelDomain.Character.CoreDataType.fetchRequest()
                request.resultType = .managedObjectResultType
                request.fetchLimit = paging.limit
                request.fetchOffset = paging.offset
                let entities = try self.coreDataRepository.queryResults(by: request)
                    .compactMap({ $0 as? MarvelDomain.Character.CoreDataType })
                    .compactMap({ $0.asDomain() })
                guard !entities.isEmpty else { return }
                promise(.success(entities))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func networkPublisher(with paging: Paging) -> AnyPublisher<[MarvelDomain.Character], Swift.Error> {
        return networkRepository.characters(with: paging)
    }
    
    private func savePublisher(data: [MarvelDomain.Character]) -> AnyPublisher<[MarvelDomain.Character], Swift.Error> {
        let publishers = data
            .map({ return coreDataRepository.update(object: $0) })
        
        return Publishers.MergeMany(publishers)
            .map({ data })
            .eraseToAnyPublisher()
    }
    
}
