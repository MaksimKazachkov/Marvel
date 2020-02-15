//
//  MarvelNetworkTests.swift
//  MarvelNetworkTests
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import XCTest
@testable import MarvelNetwork
import Combine
import MarvelDomain
import Resolver

class MarvelNetworkTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
        
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscriptions.removeAll()
    }
    
    func testFetchAndDecodeCharacters() {
        let expectation = XCTestExpectation()
        let model = CharactersRO(limit: 20, offset: 0)
        let client = MarvelClient()
        client.requestObjects(route: CharactersRoute.characters(model), at: "data.results")
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }) { (characters: [Character]) in
                expectation.fulfill()
        }
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
