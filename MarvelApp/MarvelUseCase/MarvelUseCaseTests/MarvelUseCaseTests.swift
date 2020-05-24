//
//  MarvelUseCaseTests.swift
//  MarvelUseCaseTests
//
//  Created by Maksim Kazachkov on 04.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import XCTest
import CoreData
@testable import MarvelUseCase
import Combine
import MarvelDomain
import Core

class MarvelUseCaseTests: XCTestCase {
    
    private let factory = AssemblyFactory()
    
    private var subscriptions = Set<AnyCancellable>()
        
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try! factory.applyAssemblies()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscriptions.removeAll()
    }

    func testFetchCharacters() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation()
        let usecase: CharactersUseCase = resolver.resolve(CharactersUseCase.self)!
        usecase.fetch(limit: 20, offset: 20)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            },
                  receiveValue: { (characters) in
                    XCTAssert(!characters.isEmpty)
                    expectation.fulfill()
            })
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 60)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
